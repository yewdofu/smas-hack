@include

org !smb3_entry_hook
    jml smb3_capture_entry
    nop

org !smb3_reset_hook
    jml smb3_check_reset
    nop
