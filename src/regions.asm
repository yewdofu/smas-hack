@include

; Build through tools/build.py to verify the full original ROM hash first.
!region_jp ?= 1
if !region_jp
    incsrc "regions/jp.asm"
else
    incsrc "regions/us.asm"
endif
