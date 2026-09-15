@include

if !savestates
	org !nmi_hook
			jsr nmi_hijack
endif
