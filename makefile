CC		= ca65
LL  	= ld65

EMUL 	= fceux
BIN		= zyx.nes

CHREDIT	= yychr
CHRDATA	= stuff.chr

# Build the ROM and open it in the fceux emulator.
all: $(BIN)
	$(EMUL) $(BIN) &

# Build the ROM (but don't open it in any emulator).
build: $(BIN)

# Run Unit Tests
test: $(BIN)
	$(EMUL) $(BIN) -lua test_unit.lua

# Take any assembly source files and compile them into binary objects.
%.o: %.s
	rm -f *.nes *.o
	$(CC) $< -o $@

# Link the segments of the binary according to the nesfile.ini and output
# the final ROM image.
zyx.nes: zyx.o
	$(LL) $< -o $@ -C nesfile.ini
	rm zyx.o

# Edit chr data.
chr: 
	$(CHREDIT) $(CHRDATA) &

# Delete junk.
clean:
	rm -f *.nes *.o *.nes.deb
