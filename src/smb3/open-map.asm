@include

; Map tile lookup: A/X/Y are 8-bit, DP=$0000, DB=$21.
; Keep the native map/clear flags and graphics. When a cleared tile is read,
; recover its original course from the world's ROM map (144 bytes/screen).
smb3_map_course_tile:
    php
    xba
    pha
    xba
    lda [$2E],y
    cmp #$60
    beq .original
    cmp #$E3
    beq .original
    pha
    and #$3E
    bne .unchanged
    pla
    bra .original
.unchanged:
    pla
    bra .store
.original:
    cpy #$10
    bcc .store
    cpy #$A0
    bcs .store
    phx
    phy
    lda $00
    pha
    lda $01
    pha
    lda $02
    pha
    rep #$30
    tya
    and #$00FF
    sec
    sbc #$0010
    pha
    lda $45,x
    and #$00FF
    asl #4
    sta $00
    asl #3
    clc
    adc $00
    sta $00
    pla
    clc
    adc $00
    tay
    lda $0727
    and #$00FF
    asl
    tax
    lda.l !smb3_map_rom_pointers,x
    sta $00
    sep #$20
    lda #$2A
    sta $02
    lda [$00],y
    sta $B3
    sep #$10
    pla
    sta $02
    pla
    sta $01
    pla
    sta $00
    ply
    plx
    lda $B3
.store:
    sta $B3
    pla
    xba
    plp
    lda $B3
    rtl

; Normalize only the movement test; keep rocks/locks visible on the map.
; The native direction-specific path tables still prevent leaving the roads.
smb3_map_neighbor:
    jsl !smb3_map_neighbor_native
    phx
    ldx #$05
.find:
    cmp.l .blocked,x
    beq .open
    dex
    bpl .find
    plx
    rtl
.open:
    lda.l .paths,x
    plx
    rtl
.blocked:
    db $51,$52,$54,$56,$E4,$9D
.paths:
    db $45,$46,$46,$45,$DA,$B3

; Called only after the native map-sprite collision and eligibility checks.
; A/X/Y are 8-bit, DP=$0000, DB=$21; Y remains the sprite index.
smb3_map_encounter:
    ldx $0726
    lda $49,x
    bne .skip
    lda $F8,x
    ora $F6,x
    and #$80
    beq .skip
    lda #$00
    jml !smb3_map_encounter_hook+5
.skip:
    jml !smb3_map_encounter_return
