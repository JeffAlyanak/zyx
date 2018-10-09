; zyx boilerplate

; ---- Includes ----------------------------------------------------------------

.include "nes.inc"		; This is found in cc65's "asminc" dir.
.include "nesdefs.inc"	; This may be better than "nes.inc".

; The following segments include various blocks of data that need to be aligned
; to certain addresses. These locations are defined in the nesfile.ini which is
; passed to the linker.

.include "header.s"			; iNES Header
.include "zeropage.s"		; 256 bytes of 'fast' RAM.
.include "vectors.s"		; Interrupt handler vectors
.include "bss.s"			; Uninitialised main RAM
.include "rodata.s"			; Read-only program data
.include "chr.s"			; CHR-ROM, graphics data

; ---- Main code ---------------------------------------------------------------
; This segment contains the executable code of your program.

.segment "CODE"
.include "interrupts.s"

.proc reset				; This procedure marks the point where the hardware
						; will begin running your program on boot/reset.

.include "hw_init.s"

; .include "main_menu.s"

; .include "game_start.s"
; .include "level_one.s"
; .include "level_two.s"
; .include "level_three.s"
; .include "game_over.s"

.endproc
