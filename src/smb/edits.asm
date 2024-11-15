@include

; move timer 1 tile to the left
org $039C78
    db $79

;infinite lives
org $03A06B
		bra +
org $03A079
	+
