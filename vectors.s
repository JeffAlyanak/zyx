; =====	Interrupt vectors ======================================================

; This segment defines three two-byte adddresses that point to the:
	; Address of Non Maskable Interrupt (NMI) handler routine
	; Address of Power on reset handler routine
	; Address of Break (BRK instruction) handler routine

; The nesfil.ini will put these vectors where they must be present at
;  the addresses required; $FFFA-$FFFB, $FFFC-$FFFD, & $FFFE-$FFFF.

.segment "VECTORS"
	.addr nmi_isr, reset, irq_isr
