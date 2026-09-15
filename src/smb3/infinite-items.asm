@include

; Native map inventory initialization (X/Y opens it). A/X/Y are 8-bit,
; DP=$0000, DB=$21. $05F2 distinguishes inventory from the normal HUD.
; Each player has 28 item slots followed by goal cards and other stats.
smb3_fill_items:
    phx
    phy
    lda $05F2
    beq .done
    ldy #$00
    lda $0726
    beq .player_ready
    ldy #$23
.player_ready:
    ldx #$00
.fill:
    lda.l .items,x
    sta $1D80,y
    iny
    inx
    cpx #$1C
    bne .fill
.done:
    ply
    plx
    ; Replay the five bytes replaced at the native initialization entry.
    lda #$0F
    sta $0419
    rtl

.items:
    ; Mushroom, flower, leaf, frog, tanooki, hammer suit, star, P-wing,
    ; music box, cloud, hammer, whistle, anchor. Remaining slots are empty.
    db $01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D
    fillbyte $00
    fill 15
