; =====	Zero-page RAM ==========================================================

; The first 256 bytes of RAM ($0000–$00FF) can be addressed by a special
; zero-page addressing mode, making it ideal for timing critical data.

; In this case, the NMI/vblank counter is stored here, so it can be written/read
; quickly.

.segment "ZEROPAGE"

nmi_counter:			.res 1	; Counts DOWN for each vblank.
txt_ptr:				.res 1	; Points to the next character to fetch from a message.
chr_ptr_x:				.res 1	; Points to a tile to grab.
chr_ptr_y:				.res 1
screen_offset:			.res 1	; Points to the next screen offset to write.
misc_counter:			.res 1
