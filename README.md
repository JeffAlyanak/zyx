# Zyx v0.2

## Current Version
The current version of Zyx represents only a simple boilerplate for NES development using cc65. It comes heavily commented to act as a learning tool for those with an interest in Famicom/NES development.

It is ready to be compiled and run right out of the box using `cc65` (tested with V2.13.3).

Also recommended are the `FCEUX` emulator (v2.2.1+) and the tile editor `yy-chr` (v0.99 beta).

### The current project offers the following:

* Simple Makefile configured to build an iNES ROM.
* Linker configuration for a standard iNES MMC3 mapper ROM.
* Clean organization of CPU and PPU memory space elements:
  * Zeropage
  * General RAM
  * Read-only data
  * Character ROM
  * Program ROM
  * Hardware interrupt vectors
  * iNES Header
* Simple and highly commented hardware initialization routine covering:
  * Basic initialization of 2A03, PPU & APU
  * OAM direct memory access (DMA)
  * MMC3 initialization
* Debug-friendly graphic set featuring 8x8 tiles containing all hexadecimal values from $00-FF at their respective address(ie, tile $ff is the 256th tile).

### Coming in the next version(s)

* Main Menu
  * Drawing backgrounds
  * Drawing & moving sprites
  * Taking controller input
  * Playing Sound FX (basic APU use)
* Main Game Logic
  * Sprite 0 (screen splitting)
  * Bank switching
  * Playing music (advanced APU use)

## About
This basic NES example program can be used as an example on the basics of program structure, memory addresses, compilation/makefiles, etc in regards to NES development.

The nesdefs.inc and nesfile.ini are adapted and expanded from Anton Maurovic's NES Gamedev Examples which can be found here:

https://github.com/algofoogle/nes-gamedev-examples

## How to compile
You can simply run `make` to compile, link and run the program.

Or:

* Use `make build` to compile and link.
* Use `make chr` to generate/edit the character tile file.
* Use `make clean` to delete the compiled rom.
