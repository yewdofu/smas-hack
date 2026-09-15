@include

org !smb2j_gameplay_hook
        jml gameplay_hijack_smb

org !smb2j_hud_init_hook
        jsl og_hud_init
        nop

org !smb2j_world_win_hook
        jsl world_win

org !smb2j_level_win_hook
        jsl level_win
        nop

org !smb2j_tick_hook
        jsr level_tick_hijack_smb2j
org !smb2j_tick_code
level_tick_hijack_smb2j:
        jsl level_tick
        rts

warnpc $0DFFFF

org !smb2j_pause_hook
        jsr pause_check_smb2j
org !smb2j_pause_code
pause_check_smb2j:
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

warnpc $0FFFFF
