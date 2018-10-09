; ---- Interrupt handlers ------------------------------------------------------

; NMI (non-maskable interrupt) handler.
.proc nmi_isr
	dec nmi_counter			; Decrement the nmi_counter
	rti						; Return from interrupt
.endproc

; BRK/IRQ Interrupt Handler (place any handler code within)
.proc irq_isr
	rti						; Return from interrupt
.endproc
