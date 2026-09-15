@include

org !smb1_gameplay_hook
		jml gameplay_hijack_smb

org !smb1_hud_init_hook
		jsl og_hud_init
		nop

org !smb1_world_win_hook
		jsl world_win_smb1
		nop

org !smb1_level_win_hook
		jsl level_win
		nop

org !smb1_tick_hook
		jsr level_tick_hijack_smb1
org !smb1_tick_code
level_tick_hijack_smb1:
		jsl level_tick
		rts

warnpc $03FFFF

org !smb1_pause_hook
		jsr pause_check_smb1
		nop

; The native pause-opening check is separate from its window's Start handler.
org !smb1_pause_open_hook
		jsl pause_open_check_smb1
		nop

org !smb1_pause_code
pause_check_smb1:
		lda !menu_closing
		ora !menu_flag
		bne .no_pause
		lda !axlr
		and #%00010000
		bne .no_pause
		lda !byetudlr_1f
		and #%00010000
		rts

	.no_pause:
		lda #$00
		rts

pause_open_check_smb1:
		lda !menu_closing
		ora !menu_flag
		bne .no_pause
		; Practice-menu controls use player 1, matching gameplay_hijack_smb.
		lda !axlr
		and #%00010000
		bne .no_pause
		lda !byetudlr_1f,y
		and #%00010000
		rtl

	.no_pause:
		lda #$00
		rtl

warnpc $05FFFF
