@include

; move timer 1 tile to the left
org !smb2j_timer_tile
	db $79

; infinite lives
org !smb2j_lives_hook
		bra +
org !smb2j_lives_continue
	+
