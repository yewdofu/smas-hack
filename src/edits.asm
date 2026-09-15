@include

if !savestates
	; 256kB sram
	org !sram_header
			db $08
endif

; disable sram size checks
org !sram_check_launcher
		bra $18
org !sram_check_smb1
		bra $18
org !sram_check_smb2j
		bra $18
org !sram_check_smb2u
		bra $18
org !sram_check_smb3
		bra $18


; hud tiles
org !hud_tiles
		incbin "bg3tiles.bin"
