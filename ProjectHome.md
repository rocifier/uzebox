![![](http://uzebox.org/gc1.jpg)](http://belogic.com/uzebox/images/board_details.jpg) ![![](http://uzebox.org/gc2.jpg)](http://belogic.com/uzebox/images/avcore-gamecard.jpg) ![![](http://uzebox.org/gc3.jpg)](http://belogic.com/uzebox/images/megatris.jpg) ![![](http://uzebox.org/gc4.gif)](http://uzebox.org/gc4_full.gif) ![![](http://uzebox.org/gc5.gif)](http://uzebox.org/gc5_full.gif)

The Uzebox is an open source, retro-minimalist game console design. It is based on an AVR 8-bit general purpose microcontroller made by Atmel. The particularity of the system is that it's based on an interrupt driven engine and has no frame buffer. Functions such as video sync generation, tile rendering and music mixing is done realtime in software by a background task so games can easily be developed in C. The design goal was to be as simple as possible yet have good enough sound and graphics while leaving enough resources to implement interesting games. Emphasis was put on making it easy and fun to assemble and program for any hobbyists. The final design contains only two chips: an ATmega644 and an AD725 RGB-to-NTSC converter.

Many commercial version are or where available: The Uzebox AVCore by Embedded Engineering llc and the Fuzebox by Adafruit Industries. There's also the [Uzebox deluxe kit](http://uzebox.org/shop/catalog/product_info.php?products_id=44) and the [EUzebox](http://www.hwhardsoft.de/deutsch/projekte/euzebox/), a version with a SCART interface. Get one of those if you know nothing about electronics!

Features:

  * Interrupt driven: No cycle counting required, sound mixing and video generation are all made in the background
  * 5 channels sound engine: The sound subsystem is composed of 3 wavetable channels, 1 noise and 1 PCM channel. Sound is 8-bit mono, mixed at ~15Khz
  * 256 simultaneous colors arranged in a 3:3:2 color space (Red:3 bits, Green:3 bits, Blue: 2 bits)
  * Resolution: 9 video modes offering up to 360x224 pixels (tiles-only, tiles & sprites, and bitmap video modes)
  * Full screen scrolling in certain video modes
  * Sprites: Up to 32 simultaneous sprites
  * Inputs supported: Two SNES compatible joypad inputs (including SNES mouse)
  * MIDI In: With a music sequencer, allows the creation of music directly on the console
  * SD/MicroSD and FAT16 API
  * GameLoader: 4K Bootloader which allows to flash games from a standard FAT16 formatted SD card
  * Cross-platform cycle perfect emulator with GDB support to ease development
  * Multiple tools to convert MIDI, sound file and graphics to include files

The sources comes complete with fully functional games, demos, content generation tools and even a cross-platform emulator!

Youtube videos of the Uzebox in action:<br>
<a href='http://www.youtube.com/watch?v=hWWsSn_QKLM'><img src='http://i1.ytimg.com/vi/hWWsSn_QKLM/default.jpg' /></a> <a href='http://www.youtube.com/watch?v=MmbjgadImt8'><img src='http://i2.ytimg.com/vi/MmbjgadImt8/default.jpg' /></a> <a href='http://www.youtube.com/watch?v=oHKiBjiAg8o'><img src='http://i4.ytimg.com/vi/oHKiBjiAg8o/default.jpg' /></a> <a href='http://www.youtube.com/watch?v=0u1Q3kpV1B0'><img src='http://i1.ytimg.com/vi/0u1Q3kpV1B0/default.jpg' /></a> <a href='http://www.youtube.com/watch?v=t2pMxKWWDlY'><img src='http://i1.ytimg.com/vi/t2pMxKWWDlY/default.jpg' /></a> <a href='http://www.youtube.com/watch?v=AmMM3IjrmCg'><img src='http://i2.ytimg.com/vi/AmMM3IjrmCg/default.jpg' /></a>