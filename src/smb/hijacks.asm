@include

org $038269
		jml gameplay_hijack_smb

org $039131
		jsl og_hud_init
		nop

org $038AC8
		jsl world_win
		nop

org $03D87A
		jsl level_win
		nop

org $03ADE5
		jsr level_tick_hijack_smb1
org $03FFDE
level_tick_hijack_smb1:
		jsl level_tick
		rts

warnpc $03FFFF

org $05DF38
		jsr pause_check_smb1
		nop
org $05EE66
pause_check_smb1:
		lda !menu_closing
		ora !menu_flag
		bne .no_pause
		lda !axlr
		and #%00010000
		bne .no_pause
		lda !byetudlr_1f
		rts

	.no_pause:
		lda #$00
		rts

warnpc $05FFFF
