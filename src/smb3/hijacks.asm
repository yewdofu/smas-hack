@include

org !smb3_entry_hook
    jml smb3_capture_entry
    nop

org !smb3_reset_hook
    jml smb3_check_reset
    nop

org !smb3_items_open_hook
    jsl smb3_fill_items
    nop

; Keep the selected item and its position; retain the native menu redraw.
org !smb3_items_consume_hook
    jmp.w !smb3_items_redraw

; Allow leaving an uncleared course in every connected direction.
org !smb3_map_direction_hook
    db $80

org !smb3_map_tile_hook
    jml smb3_map_course_tile
    nop

org !smb3_map_neighbor_hook
    jsl smb3_map_neighbor

; Moving bridges may be crossed in either phase.
org !smb3_map_bridge_hook
    nop #2

; World 8 hand tiles remain selectable with A/B, without automatic capture.
org !smb3_map_hand_hook
    db $80

; Map sprites (Hammer Bros., Piranha Plants, etc.) require A/B at rest.
org !smb3_map_encounter_hook
    jml smb3_map_encounter
    nop
