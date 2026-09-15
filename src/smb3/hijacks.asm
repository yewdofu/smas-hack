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
