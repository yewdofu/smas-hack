@include

; move timer 1 tile to the left
org !smb1_timer_tile
    db $79

;infinite lives
org !smb1_lives_hook
		bra +
org !smb1_lives_continue
	+
