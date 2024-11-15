lorom

; enable in-game savestates
!savestates ?= 1

table table.txt

incsrc "defines.asm"

incsrc "edits.asm"
incsrc "hijacks.asm"

if !savestates
	org $00E5C4
	incsrc "save.asm"

	warnpc $00FFC0
endif

; smb1
incsrc "smb/smb.asm"
