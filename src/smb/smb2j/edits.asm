@include

; move timer 1 tile to the left
org $0D9833
	db $79

; infinite lives
org $0D9F89
		bra +
org $0D9F97
	+
