@include
!sram_header = $00FFD8
!sram_check_launcher = $008063
!sram_check_smb1 = $038015
!sram_check_smb2j = $0D800D
!sram_check_smb2u = $11803C
!sram_check_smb3 = $20A116
!nmi_hook = $0082F6
!save_code = $00E5C4
!hud_tiles = $0CF800
!smb1_timer_tile = $039C78
!smb1_lives_hook = $03A06B
!smb1_lives_continue = $03A079
!smb1_gameplay_hook = $038269
!smb1_hud_init_hook = $039131
!smb1_world_win_hook = $038AC8
!smb1_level_win_hook = $03D87A
!smb1_tick_hook = $03ADE5
!smb1_tick_code = $03FFDE
!smb1_pause_hook = $05DF38
!smb1_pause_code = $05EE66
!hud_code = $0EF4C8
!smb2j_timer_tile = $0D9833
!smb2j_lives_hook = $0D9F89
!smb2j_lives_continue = $0D9F97
!smb2j_gameplay_hook = $0D8114
!smb2j_hud_init_hook = $0D8E0F
!smb2j_world_win_hook = $0D8849
!smb2j_level_win_hook = $0DD769
!smb2j_tick_hook = $0DAC02
!smb2j_tick_code = $0DFFF4
!smb2j_pause_hook = $0FD99F
!smb2j_pause_code = $0FFD01
!smb1_gameplay_frozen = $0382D4
!smb1_gameplay_continue = $03826D
!smb2j_gameplay_frozen = $0D817F
!smb2j_gameplay_continue = $0D8118
!smb2j_coin_update = $0D983D
!smb2j_rtl = $0D839F
!smb1_area_init = $04C00B
!smb2j_area_init = $0EC34C
assert read1(!sram_header+0) == $03
assert read3(!sram_check_launcher+0) == $A9EAEA
assert read3(!sram_check_launcher+3) == $008FAA
assert read3(!sram_check_launcher+6) == $CF7020
assert read3(!sram_check_launcher+9) == $700000
assert read3(!sram_check_launcher+12) == $A9C6D0
assert read3(!sram_check_launcher+15) == $008F55
assert read3(!sram_check_launcher+18) == $CF7020
assert read3(!sram_check_launcher+21) == $700000
assert read2(!sram_check_launcher+24) == $BAD0
assert read3(!sram_check_smb1+0) == $A9EAEA
assert read3(!sram_check_smb1+3) == $008FAA
assert read3(!sram_check_smb1+6) == $CF7020
assert read3(!sram_check_smb1+9) == $700000
assert read3(!sram_check_smb1+12) == $A9EED0
assert read3(!sram_check_smb1+15) == $008F55
assert read3(!sram_check_smb1+18) == $CF7020
assert read3(!sram_check_smb1+21) == $700000
assert read2(!sram_check_smb1+24) == $E2D0
assert read3(!sram_check_smb2j+0) == $A9EAEA
assert read3(!sram_check_smb2j+3) == $008FAA
assert read3(!sram_check_smb2j+6) == $CF7020
assert read3(!sram_check_smb2j+9) == $700000
assert read3(!sram_check_smb2j+12) == $A9EED0
assert read3(!sram_check_smb2j+15) == $008F55
assert read3(!sram_check_smb2j+18) == $CF7020
assert read3(!sram_check_smb2j+21) == $700000
assert read2(!sram_check_smb2j+24) == $E2D0
assert read3(!sram_check_smb2u+0) == $A9EAEA
assert read3(!sram_check_smb2u+3) == $008FAA
assert read3(!sram_check_smb2u+6) == $CF7020
assert read3(!sram_check_smb2u+9) == $700000
assert read3(!sram_check_smb2u+12) == $A9EED0
assert read3(!sram_check_smb2u+15) == $008F55
assert read3(!sram_check_smb2u+18) == $CF7020
assert read3(!sram_check_smb2u+21) == $700000
assert read2(!sram_check_smb2u+24) == $E2D0
assert read3(!sram_check_smb3+0) == $A9EAEA
assert read3(!sram_check_smb3+3) == $008FAA
assert read3(!sram_check_smb3+6) == $CF7020
assert read3(!sram_check_smb3+9) == $700000
assert read3(!sram_check_smb3+12) == $A9EED0
assert read3(!sram_check_smb3+15) == $008F55
assert read3(!sram_check_smb3+18) == $CF7020
assert read3(!sram_check_smb3+21) == $700000
assert read2(!sram_check_smb3+24) == $E2D0
assert read3(!nmi_hook+0) == $00008D
assert read1(!smb1_timer_tile+0) == $7A
assert read3(!smb1_lives_hook+0) == $075ACE
assert read3(!smb1_lives_continue+0) == $075FAD
assert read3(!smb1_lives_continue+3) == $ADAA0A
assert read3(!smb1_lives_continue+6) == $29075C
assert read3(!smb1_lives_continue+9) == $01F002
assert read3(!smb1_gameplay_hook+0) == $0776AD
assert read1(!smb1_gameplay_hook+3) == $4A
assert read3(!smb1_hud_init_hook+0) == $99FFA9
assert read2(!smb1_hud_init_hook+3) == $1702
assert read3(!smb1_world_win_hook+0) == $8D06A9
assert read2(!smb1_world_win_hook+3) == $07B1
assert read3(!smb1_level_win_hook+0) == $9D06A9
assert read2(!smb1_level_win_hook+3) == $07A2
assert read3(!smb1_tick_hook+0) == $935220
assert read3(!smb1_pause_hook+0) == $29F2A5
assert read1(!smb1_pause_hook+3) == $10
assert read1(!smb2j_timer_tile+0) == $7A
assert read3(!smb2j_lives_hook+0) == $075ACE
assert read3(!smb2j_lives_continue+0) == $075FAD
assert read3(!smb2j_lives_continue+3) == $ADAA0A
assert read3(!smb2j_lives_continue+6) == $29075C
assert read3(!smb2j_lives_continue+9) == $01F002
assert read3(!smb2j_gameplay_hook+0) == $0776AD
assert read1(!smb2j_gameplay_hook+3) == $4A
assert read3(!smb2j_hud_init_hook+0) == $99FFA9
assert read2(!smb2j_hud_init_hook+3) == $1702
assert read3(!smb2j_world_win_hook+0) == $A906A9
assert read1(!smb2j_world_win_hook+3) == $08
assert read3(!smb2j_level_win_hook+0) == $9D06A9
assert read2(!smb2j_level_win_hook+3) == $07A2
assert read3(!smb2j_tick_hook+0) == $902520
assert read3(!smb2j_pause_hook+0) == $0FF6AD
assert read3(!smb1_gameplay_frozen+0) == $DD7A22
assert read3(!smb1_gameplay_frozen+3) == $549C05
assert read3(!smb1_gameplay_frozen+6) == $A94C01
assert read1(!smb1_gameplay_frozen+9) == $81
assert read3(!smb1_gameplay_continue+0) == $0B5EB0
assert read3(!smb1_gameplay_continue+3) == $EB07A9
assert read3(!smb1_gameplay_continue+6) == $5B00A9
assert read3(!smb1_gameplay_continue+9) == $F047A5
assert read3(!smb1_gameplay_continue+12) == $47C604
assert read1(!smb1_gameplay_continue+15) == $D0
assert read3(!smb2j_gameplay_frozen+0) == $EBC622
assert read3(!smb2j_gameplay_frozen+3) == $549C0F
assert read3(!smb2j_gameplay_frozen+6) == $624C01
assert read1(!smb2j_gameplay_frozen+9) == $80
assert read3(!smb2j_gameplay_continue+0) == $0B5EB0
assert read3(!smb2j_gameplay_continue+3) == $EB07A9
assert read3(!smb2j_gameplay_continue+6) == $5B00A9
assert read3(!smb2j_gameplay_continue+9) == $F047A5
assert read3(!smb2j_gameplay_continue+12) == $47C604
assert read1(!smb2j_gameplay_continue+15) == $D0
assert read3(!smb2j_coin_update+0) == $200085
assert read3(!smb2j_coin_update+3) == $A59848
assert read3(!smb2j_coin_update+6) == $4A4A00
assert read3(!smb2j_coin_update+9) == $1A4A4A
assert read3(!smb2j_coin_update+12) == $C90F29
assert read1(!smb2j_coin_update+15) == $06
assert read1(!smb2j_rtl+0) == $6B
assert read3(!smb1_area_init+0) == $AB4B8B
assert read3(!smb1_area_init+3) == $C01F22
assert read3(!smb1_area_init+6) == $508D04
assert read3(!smb1_area_init+9) == $602907
assert read3(!smb1_area_init+12) == $2A2A0A
assert read3(!smb1_area_init+15) == $5C852A
assert read3(!smb1_area_init+18) == $8B6BAB
assert read3(!smb1_area_init+21) == $ACAB4B
assert read3(!smb1_area_init+24) == $C0075F
assert read3(!smb2j_area_init+0) == $AB4B8B
assert read3(!smb2j_area_init+3) == $C37422
assert read3(!smb2j_area_init+6) == $508D0E
assert read3(!smb2j_area_init+9) == $602907
assert read3(!smb2j_area_init+12) == $2A2A0A
assert read3(!smb2j_area_init+15) == $5C852A
assert read3(!smb2j_area_init+18) == $ADBA85
assert read3(!smb2j_area_init+21) == $C9075F
assert read3(!smb2j_area_init+24) == $0BD007
assert read1(!save_code) == $FF
assert read1($00FFBF) == $FF
assert read1(!smb1_tick_code) == $FF
assert read1($03FFFE) == $FF
assert read1(!smb1_pause_code) == $FF
assert read1($05FFFE) == $FF
assert read1(!hud_code) == $FF
assert read1($0EFFFE) == $FF
assert read1(!smb2j_tick_code) == $FF
assert read1($0DFFFE) == $FF
assert read1(!smb2j_pause_code) == $FF
assert read1($0FFFFE) == $FF
!smb1_coin_update = $039CF1
assert read3(!smb1_coin_update+0) == $AB4B8B
assert read3(!smb1_coin_update+3) == $9C8220
assert read2(!smb1_coin_update+6) == $6BAB
!smb1_pause_open_hook = $0385A4
assert read3(!smb1_pause_open_hook+0) == $0FF6B9
assert read2(!smb1_pause_open_hook+3) == $1029
