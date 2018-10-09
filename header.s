; ---- iNES Header -------------------------------------------------------------
; The data here is mostly metadata that is defined as part of the iNES standard
; It's not used for real hardware NES games but instead used for emulation to
; define important elements of the cartridge architecture.

.segment "INESHDR"
	; These bytes (NES + character break) are required.
	.byt $4E, $45, $53, $1A

	; Select PRG/CHR size. 16kB/8kB in this example.
	.byt 1, 1

	; The upper nible of each of these bytes selects the mapper and the lower
	; bits do various things. In this case we're using mapper 4 (MMC3) and
	; enabling vertical mirroring.
	.byt %00000001
	.byt %00000000

	; These bytes are not used for this type of header, all values must be zero.
	.byt 0, 0, 0, 0
	.byt 0, 0, 0, 0
