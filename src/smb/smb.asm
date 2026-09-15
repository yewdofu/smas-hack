@include

; edits
incsrc "edits.asm"
incsrc "smb2j/edits.asm"

; hijacks
incsrc "hijacks.asm"
incsrc "smb2j/hijacks.asm"

; hud
org !hud_code
incsrc "hud.asm"

warnpc $0EFFFF
