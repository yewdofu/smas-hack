@include

smb3_check_exit:
    phx
    ldx $0726
    lda $14
    bne .continue
    lda $F4,x
    and #$30                    ; save/load priority
    bne .continue
    lda $F2,x
    and #$30
    cmp #$30
    bne .continue
    lda $F6,x
    and #$30
    beq .continue
    plx
    jml smb3_exit_level
.continue:
    plx
    jml smb3_check_reset_buttons

smb3_exit_level:
    jsl !smb3_native_fade_out    ; original function
    sei
    stz $4200
    stz $420C
    lda #$80
    sta $2100
    sta $16
    sta $1202
    stz $0713
    stz $0728
    stz $0729
    stz $0101
    lda #$C0
    sta $0100
    ldx $0726
    lda $BB
    sta $0747,x
    stz $073F,x
    ldy #$00
    cpx #$00
    beq .player
    ldy #$23
.player:
    lda $0715
    sta $1D9F,y
    lda $0716
    sta $1DA0,y
    lda $0717
    sta $1DA1,y
    rep #$30
    ldx #$06FE
.clear_course_ram:
    stz $0000,x
    dex
    dex
    cpx #$01FE
    bne .next
    ldx #$00FE                  ; skip stack/NMI page
.next:
    cpx #$FFFE
    bne .clear_course_ram
    sep #$30
    jml !smb3_map_initialize     ; original function
