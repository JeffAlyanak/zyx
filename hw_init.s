; ---- Hardware init -----------------------------------------------------------
; This code initializes the famicom/NES hardware.



; ---- Main Hardware init ------------------------------------------------------

; MAIN PROGRAM START: The 'reset' address.



	sei						; Disable IRQs, you don't want the init interrupted.
	cld						; Disable binary coded decimal mode.
	; Basic init:
	ldx #0
	stx PPU_CTRL			; Disable non-maskable interrupts.
	stx PPU_MASK			; Turn off draw on sprites & backgrounds.
	stx APU_DMC_CTRL		; Disable DMC IRQs.

	; Set stack pointer:
	ldx #$FF
	txs

	; Clear interrupts that may persist through reset.
	bit PPU_STATUS
	bit APU_CHAN_CTRL

	; Init APU
	lda #$40
	sta APU_FRAME			; Disable APU framecounter
	lda #$0F
	sta APU_CHAN_CTRL		; Disable DMC interrupt, enable/init other channels.

	; NOTE: Reading PPU_STATUS will occasionally miss a frame. It's fine to use
	; this method during init but not once the game is running.
:	bit PPU_STATUS		; Puts bit 7 of the PPU_STATUS in the N status bit.
	bpl	:-				; Branches until N=1.

	; While waiting for the PPU to stabilize, we can put the RAM into a known
	; state.
		ldx #0
		txa
	:	sta $000,x
		sta $100,x
		sta $300,x
		sta $400,x
		sta $500,x
		sta $600,x
		sta $700,x
	    inx
	    bne :-

	; The OAM_RAM ($200-2FF) generally contains data to be copied to OAM during
	; next vblank, so we'll initialize it with $FF instead of $00, so sprites
	; don't init at co-ordinates 0, 0.
		ldx #$FF
		txa
	:	sta OAM_RAM,x
		inx
		bne :-

	; Now wait for the second VBLANK to ensure PPU is stable.
:	bit PPU_STATUS
	bpl :-

	; While we're in VBLANK we can send some important data to the PPU

	; The ppu_addr macro will load a given 16-bit address into the PPUs
	; read/write address. In this case, we want to write to the memory block
	; where the first background palette is stored.
	ppu_addr BG_PALETTE
	ldx #0
:	lda palette_data,x
	sta PPU_DATA
	inx
	cpx #$20
	bcc :-

	; Zero out nametable0.
	ppu_addr NAME_TABLE_0
	lda #$0
	ldx #$78
:	Repeat 8, sta PPU_DATA
	dex
	bne :-

	; Fill attributetable0 (which follows the nametable0) with default palette.
	; (reg a still holds 0 since last lda #0)
	ldx #$40
:	sta PPU_DATA
	dex
	bne :-

	; Reactivate non-maskable interrupts.
	lda #VBLANK_NMI
	sta PPU_CTRL

	; An OAM DMA operation will suspend the CPU for 513/514 cycles and copy
	; the data stored at $200-$2FF (on the CPU bus) to $00-$FF (on the PPU bus).

	; NOTE: From now on we must use the more complex wait_for_nmi macro to check
	; for VBLANK.
	wait_for_nmi
	lda #0
	sta PPU_OAM_ADDR
	lda #>OAM_RAM
	sta OAM_DMA

	; Init x and y scroll.
	lda #0
	sta PPU_SCROLL		; First write is X.
	sta PPU_SCROLL		; Second write is Y.

	; Set some other important PPU flags and then turn on background and sprite
	; drawing to finish the screen initialization!
	lda #VBLANK_NMI|BG_0|SPR_0|NT_0|VRAM_RIGHT
	sta PPU_CTRL
	lda #BG_ON|SPR_ON
	sta PPU_MASK
	wait_for_nmi

	; Sets up the bank switching to the following configuration:
	;	2KB bank at $0000-$07FF
	;	2KB bank at $0800-$13FF
	LDA #%01000010
	STA $8000

	LDA #%00000011
	STA $8001

	lda #$01
	STA $A000
	STA $A000
	STA $A000
	STA $A000
	STA $A000

	; Some setup for the noise channel.
	; We'll fire some one-shot sounds with this sound channel for
	; use in debugging.
	lda #%00000000
	sta APU_NOISE_VOL
	lda #%11111000
	sta APU_NOISE_TIMER
	lda #%00001000
	sta APU_NOISE_FREQ
	lda #%00001000
	sta APU_CHAN_CTRL
