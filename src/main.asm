lorom

; enable in-game savestates
!savestates ?= 1

table table.txt

incsrc "defines.asm"

incsrc "edits.asm"
incsrc "hijacks.asm"

if !savestates
	org !save_code
	incsrc "save.asm"

	warnpc $00FFC0
endif

; smb1
incsrc "smb/smb.asm"

; smb3
incsrc "smb3/smb3.asm"
