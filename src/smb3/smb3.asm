@include

; hijacks
incsrc "hijacks.asm"

; level reset
org !smb3_reset_code
incsrc "level-reset.asm"

warnpc $22EFFF
