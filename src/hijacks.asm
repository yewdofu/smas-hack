@include

if !savestates
	org $0082F6
			jsr nmi_hijack
endif
