@include

; hijacks
incsrc "hijacks.asm"

; level reset
org !smb3_reset_code
incsrc "level-reset.asm"
incsrc "infinite-items.asm"

warnpc $22EFFF
