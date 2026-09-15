@include

; Course-entry working RAM, independent of FXPAK savestates. The original
; SMB3 code uses $7FCxxx and $7FFBxx-$7FFF03, leaving this range available.
; Do not copy the stack/NMI page ($0100-$01FF) or controller state ($F0-$FF).
!smb3_entry_ram = $7FE000
!smb3_entry_player_data = $7FE800

smb3_capture_entry:
    php
    rep #$30
    pha
    phx
    ldx #$00EE
.save_direct_page:
    lda $0000,x
    sta !smb3_entry_ram,x
    dex
    dex
    bpl .save_direct_page
    ldx #$07FE
.save_work_ram:
    lda $0000,x
    sta !smb3_entry_ram,x
    dex
    dex
    cpx #$0200
    bcs .save_work_ram
    ldx #$0044
.save_player_data:
    lda $1D80,x
    sta !smb3_entry_player_data,x
    dex
    dex
    bpl .save_player_data
    plx
    pla
    plp
smb3_entry_continue:
    stz $12
    stz $0210
    jml !smb3_entry_hook+5

; Called after the gameplay loop's VBlank wait, including while paused.
; Map, title, minigames and battle mode never run this hook.
; Entry: A/X/Y 8-bit, DP=$0000, DB=$21. Preserve the original CMP flags.
smb3_check_reset:
    jml smb3_check_exit
smb3_check_reset_buttons:
    phx
    ldx $0726
    lda $F2,x
    and #$20                    ; Select belongs to shared save/load shortcuts.
    bne .continue
    lda $F4,x
    and #$30
    cmp #$30
    bne .continue
    lda $F8,x
    and #$30                    ; A newly pressed shoulder, not held repeats.
    beq .continue
    lda $14                     ; Do not interrupt a completed course exit.
    bne .continue
    plx
    jml smb3_reset_level
.continue:
    plx
    lda $1206
    cmp #$04
    jml !smb3_reset_hook+5

smb3_reset_level:
    ; Reload via the original course-entry path with its original inputs.
    ; No death handler, player switch or SRAM save is involved.
    sei
    stz $4200
    stz $420C
    lda #$80
    sta $2100
    sta $16
    sta $1202
    rep #$30
    ldx #$00EE
.restore_direct_page:
    lda !smb3_entry_ram,x
    sta $0000,x
    dex
    dex
    bpl .restore_direct_page
    ldx #$07FE
.restore_work_ram:
    lda !smb3_entry_ram,x
    sta $0000,x
    dex
    dex
    cpx #$0200
    bcs .restore_work_ram
    ldx #$0044
.restore_player_data:
    lda !smb3_entry_player_data,x
    sta $1D80,x
    dex
    dex
    bpl .restore_player_data
    sep #$30
    ; Native entry already has NMI disabled and the loading flag set.
    lda #$01
    sta $7E3955
    jml smb3_entry_continue
