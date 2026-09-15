@include

; hijacks
incsrc "hijacks.asm"

; level reset
org !smb3_reset_code
incsrc "level-reset.asm"
incsrc "infinite-items.asm"
incsrc "open-map.asm"
incsrc "level-exit.asm"

warnpc $22EFFF
