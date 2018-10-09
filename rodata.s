; =====	Program data (read-only) ===============================================

; This section holds read-only data sits inside the PRG ROM after the CODE
; segment and contains any unchanging data you may want to reference.

.segment "RODATA"

; Colours available in the NES palette are:
; http://bobrost.com/nes/files/NES_Palette.png

palette_data:
.repeat 2
	pal $2D,	$03, $02, $07	; gray, purple, blue, red
	pal			$03, $28, $3A	; purple, yellow, very light green
	pal			$00, $10, $20	; grey, light grey, white
	pal			$00, $10, $20	; grey, light grey, white
.endrepeat
