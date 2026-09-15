import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import shutil
import sys
import uuid

ROOT = Path(__file__).resolve().parents[1]
ROM_HASHES = {
    "jp": "2be58db4c82330bb843fb6ba08a8d6760592256db24f7e06ef7bacc0b09da4de",
    "us": "a9e3e57d591e995e8e0dd228b619b6aed42205eaf55316fa8ff33f236b3a32b3",
}
CODE_LIMITS = {
    "save_code": "00FFC0", "smb1_tick_code": "03FFFF", "smb1_pause_code": "05FFFF",
    "hud_code": "0EFFFF", "smb2j_tick_code": "0DFFFF", "smb2j_pause_code": "0FFFFF",
    "smb3_reset_code": "22EFFF",
}


def pc(address):
    address = int(address, 16) if isinstance(address, str) else address
    return (address >> 16) * 0x8000 + (address & 0x7FFF)


def verify(data, profile):
    if len(data) != profile["size"]:
        raise ValueError("Expected an unheadered 2 MiB original ROM")
    digest = hashlib.sha256(data).hexdigest()
    if digest != profile["sha256"]:
        raise ValueError(f"Original ROM SHA-256 mismatch: {digest}")


def verify_output(original, patched, profile, savestates):
    if len(patched) != len(original):
        raise ValueError("Unexpected ROM expansion")
    allowed = bytearray(len(original))
    sizes = {"hud_tiles": 2048, "sram_header": int(savestates),
             "nmi_hook": 3 if savestates else 0, "smb1_pause_open_hook": 5,
             "smb3_entry_hook": 5, "smb3_reset_hook": 5,
             "smb3_items_open_hook": 5, "smb3_items_consume_hook": 3}
    sizes.update({"smb3_map_direction_hook": 1, "smb3_map_tile_hook": 5,
                  "smb3_map_neighbor_hook": 4, "smb3_map_bridge_hook": 2,
                  "smb3_map_hand_hook": 1, "smb3_map_encounter_hook": 5})
    for game in ("smb1", "smb2j"):
        sizes.update({f"{game}_timer_tile": 1, f"{game}_lives_hook": 2,
                      f"{game}_gameplay_hook": 4, f"{game}_hud_init_hook": 5,
                      f"{game}_world_win_hook": 5 if game == "smb1" else 4,
                      f"{game}_level_win_hook": 5, f"{game}_tick_hook": 3,
                      f"{game}_pause_hook": 4 if game == "smb1" else 3})
    for name in profile["addresses"]:
        if name.startswith("sram_check_"):
            sizes[name] = 2
    for name, length in sizes.items():
        start = pc(profile["addresses"][name])
        allowed[start:start + length] = b"\x01" * length
    for name, end in profile["free"].items():
        start, end = pc(profile["addresses"][name]), pc(end)
        if not 0 <= start < end <= len(original):
            raise ValueError(f"Invalid code space: {name}")
        if original[start:end] != b"\xff" * (end - start):
            raise ValueError(f"Code space is not empty: {name}")
        if name == "save_code" and not savestates:
            continue
        allowed[start:end] = b"\x01" * (end - start)
    allowed[0x7FDC:0x7FE0] = b"\x01" * 4  # Asar checksum/complement.
    changed = 0
    for offset, (old, new) in enumerate(zip(original, patched)):
        if old != new:
            changed += 1
            if not allowed[offset]:
                raise ValueError(f"Unexpected write outside patch regions at PC {offset:06X}")
    checksum = int.from_bytes(patched[0x7FDE:0x7FE0], "little")
    complement = int.from_bytes(patched[0x7FDC:0x7FDE], "little")
    if checksum ^ complement != 0xFFFF or sum(patched) & 0xFFFF != checksum:
        raise ValueError("Invalid output SNES checksum")
    return changed


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--region", choices=("jp", "us"), default="jp")
    parser.add_argument("--savestates", choices=("0", "1"), default="0")
    parser.add_argument("--rom", type=Path)
    parser.add_argument("--verify-only", action="store_true")
    args = parser.parse_args()
    profile = {"sha256": ROM_HASHES[args.region], "size": 0x200000, "free": CODE_LIMITS}
    rom = (args.rom or ROOT / "sfc" / ("smas_j.sfc" if args.region == "jp" else "smas_u.sfc")).resolve()
    if not rom.is_file():
        raise ValueError(f"Original ROM not found: {rom}. Place it there or specify --rom.")
    data = rom.read_bytes()
    verify(data, profile)
    if args.verify_only:
        print(f"Verified {args.region}: {profile['sha256']}")
        return
    binding = ROOT / "asar/asar.py"
    if not binding.is_file():
        raise ValueError(f"Asar Python binding not found: {binding}")
    spec = importlib.util.spec_from_file_location("project_asar", binding)
    asar = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(asar)
    library_name = {"win32": "asar.dll", "darwin": "libasar.dylib"}.get(sys.platform, "libasar.so")
    library = binding.with_name(library_name)
    if not asar.init(str(library)):
        raise ValueError(f"Asar initialization failed: {library}")
    run = ROOT / "target" / "builds" / uuid.uuid4().hex[:12]
    run.mkdir(parents=True)
    output = run / f"smashack_{args.region}_{'ss' if args.savestates == '1' else 'emu'}.sfc"
    try:
        asar_version = asar.version()
        success, patched = asar.patch(str(ROOT / "src/main.asm"), data,
                                      additional_defines={"region_jp": str(int(args.region == "jp")),
                                                          "savestates": args.savestates},
                                      override_checksum=True)
        messages = asar.getprints() + [entry.fullerrdata.decode("utf-8", errors="replace")
                                       for entry in asar.getwarnings() + asar.geterrors()]
        labels = asar.getalllabels() if success else {}
        profile["addresses"] = {name: value[1:] for name, value in asar.getalldefines().items()
                                if re.fullmatch(r"\$[0-9A-Fa-f]{6}", value)} if success else {}
    finally:
        asar.close()
    symbols = "\n".join(f"{name}={labels[name]:X}" for name in
                        ("gameplay_hijack_smb", "hud_menu_init", "hud_menu", "level_tick", "world_win", "level_win",
                         "smb3_capture_entry", "smb3_check_reset", "smb3_reset_level",
                         "smb3_fill_items", "smb3_map_course_tile", "smb3_map_neighbor",
                         "smb3_exit_level")
                        if name in labels)
    log = "\n".join(messages + [symbols]) + "\n"
    (run / "asar.log").write_text(log, encoding="utf-8", newline="\n")
    if not success:
        raise ValueError(f"Asar failed; {run / 'asar.log'}\n{log}")
    changed = verify_output(data, patched, profile, args.savestates == "1")
    if rom.read_bytes() != data:
        raise ValueError("Original ROM changed during build")
    report = {"region": args.region, "savestates": int(args.savestates),
              "input_sha256": profile["sha256"], "output_sha256": hashlib.sha256(patched).hexdigest(),
              "changed_bytes": changed, "addresses": profile["addresses"], "symbols": symbols,
              "asar_version": asar_version}
    (run / "verification.json").write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8", newline="\n")
    stable = ROOT / "target" / output.name
    output.write_bytes(patched)
    shutil.copyfile(output, stable)
    (stable.with_suffix(".json")).write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8", newline="\n")
    print(f"Built {stable}\nAsar version: {asar_version}\nChanged bytes: {changed}\n{symbols}")


if __name__ == "__main__":
    try:
        main()
    except (OSError, ValueError) as error:
        print(f"Build rejected: {error}", file=sys.stderr)
        sys.exit(1)
