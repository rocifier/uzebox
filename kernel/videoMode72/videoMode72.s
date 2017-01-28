/*
 *  Uzebox Kernel - Mode 72
 *  Copyright (C) 2017 Sandor Zsuga (Jubatian)
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 *  Uzebox is a reserved trade mark
*/

;=============================================================================
;
; Video mode 72
;
; Code tiles + "Hard" sprites mode, VSync mixer only
;
; 160 pixels width (7 cycles / pixel, same as NTSC C64 full width)
; 320 pixels wide 1bpp text mode alternative (3.5 cycles / pixel)
; 8 pixels / tile (20 tiles H-scrolling, 40 tiles in text mode)
; Tiles can have up to 16 colors selected from palette
; 160 pixels wide mode can have sprites overlayed
; Up to 20 3 color + transparency sprites in various configurations
;
;=============================================================================
;
; Graphics frame structure:
;
; Px0     Px16                                                   Px176   Px192
; +-------+----------------------------------------------------------+-------+
; |       | Top boundary line: m72_tt_col                            |       |
; |     --+----------------------------------------------------------+--     |
; |       |                                                          |       |
; |       | Text mode, top (40 tiles wide)                           |       |
; |       | m72_tt_vram:  Pointer to VRAM for this part              |       |
; |       | m72_tt_trows: Number of tile rows this part has          |       |
; |       | m72_tt_pad:   Padding in pixels to T.T boundary line     |       |
; |       | m72_tt_hgt:   Height in pixels including padding and     |       |
; |       |               Top boundary line                          |       |
; |       | m72_tt_bcol:  Background color                           |       |
; |       | m72_tt_fcol:  Foreground color                           |       |
; |       |                                                          |       |
; |     --+----------------------------------------------------------+--     |
; |       | T.T boundary line: m72_lt_col                            |       |
; |     --+----------------------------------------------------------+--     |
; |       |                                                          |       |
; |       | Game area (20 visible tiles, 21 logical tiles)           |       |
; |       | palette:      16 color palette (col. 15 is border color) |       |
; |       | m72_rowoff:   Defines the VRAM for this part             |       |
; |       |                                                          |       |
; |     --+----------------------------------------------------------+--     |
; |       | T.B boundary line: m72_lb_col                            |       |
; |     --+----------------------------------------------------------+--     |
; |       |                                                          |       |
; |       | Text mode, bottom (40 tiles wide)                        |       |
; |       | m72_tb_vram:  Pointer to VRAM for this part              |       |
; |       | m72_tb_trows: Number of tile rows this part has          |       |
; |       | m72_tb_pad:   Padding in pixels to T.B boundary line     |       |
; |       | m72_tb_hgt:   Height in pixels including padding and     |       |
; |       |               Bottom boundary line                       |       |
; |       | m72_tb_bcol:  Background color                           |       |
; |       | m72_tb_fcol:  Foreground color                           |       |
; |       |                                                          |       |
; |     --+----------------------------------------------------------+--     |
; |       | Bottom boundary line: m72_tb_col                         |       |
; +-------+----------------------------------------------------------+-------+
;
; The T.T & T.B boundary lines are always visible.
;
; Game area's logical size is render_lines_count - 2, located between the T.T
; and T.B boundary lines. The text modes cover it up when their respective
; heights are nonzero. First visible line of the game area (without overlays)
; is 32.
;
;=============================================================================
;
; The mode needs a code tileset and palette source provided by the user.
;
; The following global symbols are required:
;
; m72_defpalette:
;     16 bytes at arbitrary location in ROM, defining the default palette.
;     This palette is loaded upon initialization into palette.
;
; m72_deftilerows:
;     A generated tileset which is used for background.
;
;=============================================================================



;
; sprite_t sprites[];
;
; 20 sprites. Their structure is as follows:
; off:    Sprite start offset within its memory bank
; bank:   Memory bank of sprite (high byte of RAM address)
; xpos:   X position, 32: Left edge
; ypos:   Y position, 32: Top edge
; height: Sprite height and X mirror flag on bit 7
; col1:   Color of '1' pixels (BBGGGRRR byte)
; col2:   Color of '2' pixels (BBGGGRRR byte)
; col3:   Color of '3' pixels (BBGGGRRR byte)
;
.global sprites

;
; unsigned char palette[];
;
; 16 bytes specifying the 16 colors potentially used by the tiles. The colors
; are in BBGGGRRR format (normal Uzebox colors).
;
.global palette

;
; unsigned char bordercolor;
;
; The border color, same as palette[15]. Use to set a global color for the
; horizontal borders.
;
.global bordercolor

#if (M72_SCOLOR_ENA != 0)
;
; unsigned char m72_scolor[];
;
; Scanline color replacements, as many bytes as many scanlines are used. They
; are used to replace colors on every line based on the settings in
; m72_config.
;
.global m72_scolor
#endif

;
; unsigned int m72_rowoff[];
;
; Row start offsets in pixels (bits 0-11: RAM offset; bits 12-14: Scroll).
; This can be used to set up the VRAM for the game area background. Normally
; it has 32 entries to set up 32 individual tile rows, but with
; M72_USE_LINE_ADDR it may be configured to have as many entries as many
; scanlines are used.
;
.global m72_rowoff

;
; unsigned char m72_config;
;
; Selects configuration & sprite mode.
;
; bit 0: Ignore boundary line colors if set (uses border color instead)
; bit 1: Game area color 0 replace on every scanline if set
; bit 2: Border color replace / extend on every scanline if set
; bit 3: Text area background color replace on every scanline if set
; bit 4-7: Sprite mode to use
;
; If border color replace is set, on boundary lines, the boundary line color
; (m72_lt_col and m72_lb_col) will extend into the borders.
;
; Border color replace / extend has effect even without M72_SCOLOR_ENA: this
; case in the game area, color 0 will replace the normal border color (so the
; normal border color will only be used for text overlays).
;
; Ignoring boundary line colors may be useful in combination with
; M72_SCOLOR_ENA, allowing to color them using the color replaces.
;
.global m72_config

;
; unsigned char m72_ypos;
;
; Y position for game area background.
;
; Sets the topmost row in the game area, can be used for Y scrolling.
;
.global m72_ypos

;
; unsigned const char m72_charrom;
;
; 2K Character generator ROM pointer for text modes. Each row takes 256 bytes,
; pixels within bytes are ordered so leftmost pixels are generated by the
; higher bits. Selects a 256 byte bank where the character ROM begins.
;
.global m72_charrom

;
; Top text area parameters. See Graphics frame structure.
;
.global m72_tt_vram
.global m72_tt_trows
.global m72_tt_pad
.global m72_tt_hgt
.global m72_tt_bcol
.global m72_tt_fcol
.global m72_tt_col
.global m72_lt_col

;
; Bottom text area parameters. See Graphics frame structure.
;
.global m72_tb_vram
.global m72_tb_trows
.global m72_tb_pad
.global m72_tb_hgt
.global m72_tb_bcol
.global m72_tb_fcol
.global m72_tb_col
.global m72_lb_col



; IO port offsets

#define PIXOUT         VIDEO_PORT
#define GPR0           _SFR_IO_ADDR(GPIOR0)
#define GPR1           _SFR_IO_ADDR(GPIOR1)
#define GPR2           _SFR_IO_ADDR(GPIOR2)
#define STACKL         0x3D
#define STACKH         0x3E
#define AUDOUT         _SFR_MEM_ADDR(OCR2A)
#define SYNC           _SFR_IO_ADDR(SYNC_PORT)
#define SYNC_P         SYNC_PIN

; Offsets within user accessible sprite descriptors

#define SP_OFF         0
#define SP_BANK        1
#define SP_XPOS        2
#define SP_YPOS        3
#define SP_HEIGHT      4
#define SP_COL1        5
#define SP_COL2        6
#define SP_COL3        7

; Various variables at the line buffer's end
; Line buffer:
;   0 -  31: Non-visible left pixels
;  32 - 191: Visible pixels (160)
; 192 - 223: Non-visible right pixels

; Sprite processing codes A / B (A may be used to access B)
#define LB_SPR_B       254
#define LB_SPR_A       252
; Top of video stack (init STACKL to this - 1)
#define LB_STACK       252
; Saved registers
#define LB_S_GP0       224
#define LB_S_GP1       225
#define LB_S_GP2       226
#define LB_S_SPL       227
#define LB_S_SPH       228
; Top text area calculated dimensions
#define LB_TT_CTBL     229
#define LB_TT_CEXT     230
#define LB_TT_CROW     231
#define LB_TT_CPAD     232
#define LB_TT_CBBL     233
; Bottom text area calculated dimensions
#define LB_TB_CTBL     234
#define LB_TB_CEXT     235
#define LB_TB_CROW     236
#define LB_TB_CPAD     237
#define LB_TB_CBBL     238
; Flipping for sprites
#define LB_FLIP        239

; Full variable offsets
#define V_S_GP0        (M72_LBUFFER_OFF + LB_S_GP0)
#define V_S_GP1        (M72_LBUFFER_OFF + LB_S_GP1)
#define V_S_GP2        (M72_LBUFFER_OFF + LB_S_GP2)
#define V_S_SPL        (M72_LBUFFER_OFF + LB_S_SPL)
#define V_S_SPH        (M72_LBUFFER_OFF + LB_S_SPH)
#define V_TT_CTBL      (M72_LBUFFER_OFF + LB_TT_CTBL)
#define V_TT_CEXT      (M72_LBUFFER_OFF + LB_TT_CEXT)
#define V_TT_CROW      (M72_LBUFFER_OFF + LB_TT_CROW)
#define V_TT_CPAD      (M72_LBUFFER_OFF + LB_TT_CPAD)
#define V_TT_CBBL      (M72_LBUFFER_OFF + LB_TT_CBBL)
#define V_TB_CTBL      (M72_LBUFFER_OFF + LB_TB_CTBL)
#define V_TB_CEXT      (M72_LBUFFER_OFF + LB_TB_CEXT)
#define V_TB_CROW      (M72_LBUFFER_OFF + LB_TB_CROW)
#define V_TB_CPAD      (M72_LBUFFER_OFF + LB_TB_CPAD)
#define V_TB_CBBL      (M72_LBUFFER_OFF + LB_TB_CBBL)
#define V_FLIP         (M72_LBUFFER_OFF + LB_FLIP)



.section .bss

	; Globals

	sprites:       .space 20 * 8     ; User accessible sprite descriptors
	palette:       .space 15         ; Game area palette
	bordercolor:   .space 1          ; Border color (last index of game area pal.)
#if (M72_SCOLOR_ENA != 0)
	m72_scolor:    .space M72_MAXHEIGHT
#endif
#if (M72_USE_LINE_ADDR != 0)
	m72_rowoff:    .space (M72_LINE_ADDR_ROWS * 2)
#else
	m72_rowoff:    .space 64
#endif

	m72_config:    .space 1          ; Mode 72 configuration
	m72_ypos:      .space 1          ; Y position for game background
	m72_charrom:   .space 1          ; Character generator ROM address high

	m72_tt_vram:   .space 2
	m72_tt_trows:  .space 1
	m72_tt_pad:    .space 1
	m72_tt_hgt:    .space 1
	m72_tt_bcol:   .space 1
	m72_tt_fcol:   .space 1
	m72_tt_col:    .space 1
	m72_lt_col:    .space 1

	m72_tb_vram:   .space 2
	m72_tb_trows:  .space 1
	m72_tb_pad:    .space 1
	m72_tb_hgt:    .space 1
	m72_tb_bcol:   .space 1
	m72_tb_fcol:   .space 1
	m72_tb_col:    .space 1
	m72_lb_col:    .space 1

	; Locals

	v_spoff:       .space 20         ; Adjusted sprite offsets for their start scanline
	v_sphgt:       .space 20         ; Sprite heights (with removed X mirror flags)

.section .text




;
; Video frame renderer
;

sub_video_mode72:

;
; Entry happens in cycle 467.
;

	; Store away GPIO regs & stack, prepare video stack

	in    r0,      GPR0
	sts   V_S_GP0, r0
	in    r0,      GPR1
	sts   V_S_GP1, r0
	in    r0,      GPR2
	sts   V_S_GP2, r0
	in    r0,      STACKH
	sts   V_S_SPH, r0
	in    r0,      STACKL
	sts   V_S_SPL, r0
	ldi   r18,     hi8(M72_LBUFFER_OFF)
	out   STACKH,  r18
	ldi   r18,     LB_STACK - 1
	out   STACKL,  r18     ; ( 486)

	; Load mode 72 config & sprite multiplexing flip into GPIOR0

	lds   r16,     m72_config
	andi  r16,     0x0E
	lds   r17,     V_FLIP
	com   r17
	andi  r17,     0x01
	sts   V_FLIP,  r17
	or    r16,     r17
	out   GPR0,    r16     ; ( 497)

	; Prepare sprite heights and X mirrors (r24, r25, GPIOR0 bits 4-7)

	ldi   XL,      lo8(sprites + SP_HEIGHT)
	ldi   XH,      hi8(sprites + SP_HEIGHT)
	ldi   YL,      lo8(v_sphgt)
	ldi   YH,      hi8(v_sphgt)
	clr   r24
	clr   r25
	clr   r23              ; ( 504) r23 will be used to fill GPIOR0

	ld    r16,     X       ; Sprite 0
	sbrc  r16,     7
	ori   r24,     0x01
	andi  r16,     0x7F
	st    Y+,      r16
	adiw  XL,      8

	ld    r16,     X       ; Sprite 1
	sbrc  r16,     7
	ori   r24,     0x02
	andi  r16,     0x7F
	st    Y+,      r16
	adiw  XL,      8

	ld    r16,     X       ; Sprite 2
	sbrc  r16,     7
	ori   r24,     0x04
	andi  r16,     0x7F
	st    Y+,      r16
	adiw  XL,      8

	ld    r16,     X       ; Sprite 3
	sbrc  r16,     7
	ori   r24,     0x08
	andi  r16,     0x7F
	st    Y+,      r16
	adiw  XL,      8

	ld    r16,     X       ; Sprite 4
	sbrc  r16,     7
	ori   r24,     0x10
	andi  r16,     0x7F
	st    Y+,      r16
	adiw  XL,      8

	ld    r16,     X       ; Sprite 5
	sbrc  r16,     7
	ori   r24,     0x20
	andi  r16,     0x7F
	st    Y+,      r16
	adiw  XL,      8

	ld    r16,     X       ; Sprite 6
	sbrc  r16,     7
	ori   r24,     0x40
	andi  r16,     0x7F
	st    Y+,      r16
	adiw  XL,      8

	ld    r16,     X       ; Sprite 7
	sbrc  r16,     7
	ori   r24,     0x80
	andi  r16,     0x7F
	st    Y+,      r16
	adiw  XL,      8

	ld    r16,     X       ; Sprite 8
	sbrc  r16,     7
	ori   r25,     0x01
	andi  r16,     0x7F
	st    Y+,      r16
	adiw  XL,      8

	ld    r16,     X       ; Sprite 9
	sbrc  r16,     7
	ori   r25,     0x02
	andi  r16,     0x7F
	st    Y+,      r16
	adiw  XL,      8

	ld    r16,     X       ; Sprite 10
	sbrc  r16,     7
	ori   r25,     0x04
	andi  r16,     0x7F
	st    Y+,      r16
	adiw  XL,      8

	ld    r16,     X       ; Sprite 11
	sbrc  r16,     7
	ori   r25,     0x08
	andi  r16,     0x7F
	st    Y+,      r16
	adiw  XL,      8

	ld    r16,     X       ; Sprite 12
	sbrc  r16,     7
	ori   r25,     0x10
	andi  r16,     0x7F
	st    Y+,      r16
	adiw  XL,      8

	ld    r16,     X       ; Sprite 13
	sbrc  r16,     7
	ori   r25,     0x20
	andi  r16,     0x7F
	st    Y+,      r16
	adiw  XL,      8

	ld    r16,     X       ; Sprite 14
	sbrc  r16,     7
	ori   r25,     0x40
	andi  r16,     0x7F
	st    Y+,      r16
	adiw  XL,      8

	ld    r16,     X       ; Sprite 15
	sbrc  r16,     7
	ori   r25,     0x80
	andi  r16,     0x7F
	st    Y+,      r16
	adiw  XL,      8

	ld    r16,     X       ; Sprite 16
	sbrc  r16,     7
	ori   r23,     0x10
	andi  r16,     0x7F
	st    Y+,      r16
	adiw  XL,      8

	ld    r16,     X       ; Sprite 17
	sbrc  r16,     7
	ori   r23,     0x20
	andi  r16,     0x7F
	st    Y+,      r16
	adiw  XL,      8

	ld    r16,     X       ; Sprite 18
	sbrc  r16,     7
	ori   r23,     0x40
	andi  r16,     0x7F
	st    Y+,      r16
	adiw  XL,      8

	ld    r16,     X       ; Sprite 19
	sbrc  r16,     7
	ori   r23,     0x80
	andi  r16,     0x7F
	st    Y+,      r16
	adiw  XL,      8       ; ( 684)

	in    r0,      GPR0
	or    r0,      r23
	out   GPR0,    r0      ; ( 687)

	; Cancel sprite heights for invisible sprites by allowing a maximal
	; XPOS of 191 (so line buffer 224 - 255 remains free)

	ldi   XL,      lo8(sprites + SP_XPOS)
	ldi   XH,      hi8(sprites + SP_XPOS)
	sbiw  YL,      20      ; Back to first sprite in sprite heights
	ldi   r18,     20
	clr   r0               ; ( 693)
pre_l0:
	ld    r16,     X
	adiw  XL,      8
	cpi   r16,     192
	brcs  .+2
	st    Y+,      r0
	brcc  .+2
	adiw  YL,      1
	dec   r18
	brne  pre_l0           ; ( 952) (13 / iteration)

	; Initialize sprite mode

	lds   ZL,      m72_config
	swap  ZL
	andi  ZL,      0x0F
	lsl   ZL
	clr   ZH
	subi  ZL,      lo8(-(pm(pre_ssel)))
	sbci  ZH,      hi8(-(pm(pre_ssel)))
	icall                  ; (1366) (963 + 3 for jmp ops, + 400 for the body)
	rjmp  pre_l1           ; (1368)

pre_ssel:
#if ((M72_SPRITE_MODES & 0x0001) != 0)
	jmp   m72_sp0_yprep
#else
	jmp   m72_sp15_yprep
#endif
#if ((M72_SPRITE_MODES & 0x0002) != 0)
	jmp   m72_sp1_yprep
#else
	jmp   m72_sp15_yprep
#endif
#if ((M72_SPRITE_MODES & 0x0004) != 0)
	jmp   m72_sp2_yprep
#else
	jmp   m72_sp15_yprep
#endif
#if ((M72_SPRITE_MODES & 0x0008) != 0)
	jmp   m72_sp3_yprep
#else
	jmp   m72_sp15_yprep
#endif
#if ((M72_SPRITE_MODES & 0x0010) != 0)
	jmp   m72_sp4_yprep
#else
	jmp   m72_sp15_yprep
#endif
#if ((M72_SPRITE_MODES & 0x0020) != 0)
	jmp   m72_sp5_yprep
#else
	jmp   m72_sp15_yprep
#endif
#if ((M72_SPRITE_MODES & 0x0040) != 0)
	jmp   m72_sp6_yprep
#else
	jmp   m72_sp15_yprep
#endif
#if ((M72_SPRITE_MODES & 0x0080) != 0)
	jmp   m72_sp7_yprep
#else
	jmp   m72_sp15_yprep
#endif
#if ((M72_SPRITE_MODES & 0x0100) != 0)
	jmp   m72_sp8_yprep
#else
	jmp   m72_sp15_yprep
#endif
#if ((M72_SPRITE_MODES & 0x0200) != 0)
	jmp   m72_sp9_yprep
#else
	jmp   m72_sp15_yprep
#endif
#if ((M72_SPRITE_MODES & 0x0400) != 0)
	jmp   m72_sp10_yprep
#else
	jmp   m72_sp15_yprep
#endif
#if ((M72_SPRITE_MODES & 0x0800) != 0)
	jmp   m72_sp11_yprep
#else
	jmp   m72_sp15_yprep
#endif
#if ((M72_SPRITE_MODES & 0x1000) != 0)
	jmp   m72_sp12_yprep
#else
	jmp   m72_sp15_yprep
#endif
#if ((M72_SPRITE_MODES & 0x2000) != 0)
	jmp   m72_sp13_yprep
#else
	jmp   m72_sp15_yprep
#endif
#if ((M72_SPRITE_MODES & 0x4000) != 0)
	jmp   m72_sp14_yprep
#else
	jmp   m72_sp15_yprep
#endif
	jmp   m72_sp15_yprep

pre_l1:

	; Load border color into r17

	lds   r17,     bordercolor ; (1370)

	; Precalculate heights of various areas

	lds   r20,     render_lines_count ; (1372)

	; Top text area and the Top boundary line. Normally the T.T boundary
	; line should belong to the top text area, but it is rather mixed up
	; with the Top boundary line as a boundary line is needed to prepare
	; the game area (which is the T.T boundary line just above it).

	lds   r21,     m72_tt_pad
	lds   r22,     m72_tt_trows
	lds   r23,     m72_tt_hgt
	lsl   r22
	lsl   r22
	lsl   r22              ; Get line count from tile row count
	subi  r20,     1       ; Max. height allowed for top text area
	brcc  .+2              ; (1383 / 1384)
	rjmp  fr_zero_height   ; (1385) Zero height frame, nothing to render
	cp    r20,     r23
	brcc  .+2
	mov   r23,     r20     ; Limit to this height
	mov   r18,     r23
	ldi   r19,     1       ; Size of Top boundary line
	cp    r18,     r19
	brcc  .+2
	mov   r19,     r18
	sub   r18,     r19
	sts   V_TT_CTBL, r19   ; Top boundary line: Either 1 or 0 lines
	ldi   r19,     1
	sts   V_TT_CBBL, r19   ; T.T boundary line: Always 1 line
	cp    r18,     r21
	brcc  .+2
	mov   r21,     r18     ; Padding lines
	sub   r18,     r21
	sts   V_TT_CPAD, r21
	cp    r18,     r22
	brcc  .+2
	mov   r22,     r18     ; Tile row lines
	sub   r18,     r22
	sts   V_TT_CROW, r22
	sts   V_TT_CEXT, r18   ; Extra lines beyond tile row lines
	mov   r16,     r23
	inc   r16              ; Begin line of game area
	sub   r20,     r23     ; (1415) Remaining lines from the frame

	; T.B boundary line: should only be missing if there are no more
	; scanlines to render (Z flag set if so)

	ldi   r19,     1
	brne  .+2
	ldi   r19,     0       ; T.B boundary line: None if no more lines
	sts   V_TB_CTBL, r19
	breq  .+2
	dec   r20              ; (1422) One less lines remaining

	; Bottom text area and T.B boundary line.

	lds   r21,     m72_tb_pad
	lds   r22,     m72_tb_trows
	lds   r23,     m72_tb_hgt
	lsl   r22
	lsl   r22
	lsl   r22              ; Get line count from tile row count
	cp    r20,     r23
	brcc  .+2
	mov   r23,     r20     ; Limit to this height
	mov   r18,     r23
	ldi   r19,     1       ; Size of Bottom boundary line
	cp    r18,     r19
	brcc  .+2
	mov   r19,     r18
	sub   r18,     r19
	sts   V_TB_CBBL, r19   ; Bottom boundary line: Either 1 or 0 lines
	cp    r18,     r21
	brcc  .+2
	mov   r21,     r18     ; Padding lines
	sub   r18,     r21
	sts   V_TB_CPAD, r21
	cp    r18,     r22
	brcc  .+2
	mov   r22,     r18     ; Tile row lines
	sub   r18,     r22
	sts   V_TB_CROW, r22
	sts   V_TB_CEXT, r18   ; Extra lines beyond tile row lines
	sub   r20,     r23     ; (1457) Remaining lines: Game area height

	; Game area: all the remaining size.

	add   r16,     r20
	subi  r16,     0x100 - 31
	out   GPR2,    r16     ; (1460) Game area end point

	; Prepare scanline counter.

	ldi   r18,     31      ; (1461)

	; Transfer

	WAIT  r20,     236     ; (1697) Fall through to Top boundary line



;
; Top boundary line.
;
; Enters in cycle 1697.
;
tt_tbl_entry:

	lds   r16,     V_TT_CTBL
	cpi   r16,     0
	brne  .+2              ; (1701 / 1702)
	rjmp  tt_ext_entry     ; (1703) None to draw

	; Draw top boundary line

	WAIT  r20,     97      ; (1799)

	; Load color

	lds   r20,     m72_tt_col
	rcall m72_bl_colors    ; (1820 = 0) (19 cycles)

	; Generate line

	rcall m72_blankline    ; (1702)

	; Next scanline, then go on to top text area extra lines

	inc   r18              ; (1703) Fall through to text area extra lines



;
; Top text area extra lines (beyond tile row count).
;
; Enters in cycle 1703.
;
tt_ext_entry:

	lds   r16,     V_TT_CEXT
	cpi   r16,     0
	brne  tt_ext_loope     ; (1707 / 1708)
	rjmp  tt_row_entry     ; (1709) None to draw: go on to rows

	; Draw extra lines

tt_ext_loop:

	WAIT  r20,     2       ; (1708)

tt_ext_loope:

	WAIT  r20,     91      ; (1799)

	; Load colors

	rcall m72_tt_colors    ; (1820 = 0) (21 cycles)

	; Generate line

	rcall m72_blankline    ; (1702)

	; Next scanline, loop

	inc   r18
	dec   r16
	brne  tt_ext_loop      ; (1705 / 1706)

	WAIT  r20,     4       ; (1709) Fall through to text area tile rows



;
; Top text area tile rows.
;
; Enters in cycle 1709.
;
tt_row_entry:

	lds   r16,     V_TT_CROW
	cpi   r16,     0
	brne  tt_row_prep      ; (1713 / 1714)
	rjmp  tt_pad_entry     ; (1715) None to draw: go on to padding

	; Draw extra lines

tt_row_prep:

	lds   YL,      m72_tt_vram + 0
	lds   YH,      m72_tt_vram + 1
	lds   r19,     m72_tt_trows
	lsl   r19
	lsl   r19
	lsl   r19
	sub   r19,     r16     ; (1724) Scanline in tile row to start at
	mov   r22,     r19
	lsr   r22
	lsr   r22
	lsr   r22
	ldi   r23,     40
	mul   r22,     r23
	add   YL,      r0
	adc   YH,      r1      ; (1733) VRAM offset to start at
	rjmp  tt_row_loope     ; (1735)

tt_row_loop:

	WAIT  r20,     29      ; (1735)

tt_row_loope:

	WAIT  r20,     64      ; (1799) (Will need loop preparation, at least a start row calculation)

	; Load colors

	rcall m72_tt_colors    ; (1820 = 0) (21 cycles)

	; Generate line

	rcall m72_txtline      ; (1702)

	; Next scanline, loop

	inc   r18
	dec   r16
	brne  tt_row_loop      ; (1705 / 1706)

	WAIT  r20,     10      ; (1715) Fall through to padding lines



;
; Top text area padding lines.
;
; Enters in cycle 1715.
;
tt_pad_entry:

	lds   r16,     V_TT_CPAD
	cpi   r16,     0
	brne  tt_pad_loope     ; (1719 / 1720)
	rjmp  ga_tran_entry    ; (1721) None to draw: transfer to game area

	; Draw extra lines

tt_pad_loop:

	WAIT  r20,     14      ; (1720)

tt_pad_loope:

	WAIT  r20,     79      ; (1799)

	; Load colors

	rcall m72_tt_colors    ; (1820 = 0) (21 cycles)

	; Generate line

	rcall m72_blankline    ; (1702)

	; Next scanline, loop

	inc   r18
	dec   r16
	brne  tt_pad_loop      ; (1705 / 1706)

	WAIT  r20,     16      ; (1721) Fall through to game area transfer



;
; Transfer to game area code
;
; Enters in cycle 1721.
;
ga_tran_entry:

	WAIT  r20,     34      ; (1755)

	; Load game area palette into r2 - r13 (r14, r15 and r16 will be
	; loaded with colors 12, 13 and 14 within the scanline code, to allow
	; using these registers in sprite modes).

	ldi   XL,      lo8(palette)
	ldi   XH,      hi8(palette)
	ld    r2,      X+
	ld    r3,      X+
	ld    r4,      X+
	ld    r5,      X+
	ld    r6,      X+
	ld    r7,      X+
	ld    r8,      X+
	ld    r9,      X+
	ld    r10,     X+
	ld    r11,     X+
	ld    r12,     X+
	ld    r13,     X+      ; (1781)

	; Prepare logical row counter. No scan line increment (r18) since it
	; is pre-incremented in the game area scanline code.

	lds   r19,     m72_ypos
	add   r19,     r18     ; Compensate for possible overlay
	subi  r19,     32      ; (1785)

	; Prepare for line buffer fill

	in    XH,      STACKH
	ldi   XL,      32      ; (1787)

	; Load colors (T.T boundary line)

	lds   r20,     m72_lt_col
	rcall m72_bl_colors    ; (1808) (19 cycles)

	; Fill in line buffer for T.T boundary line

	rcall gap_t4           ; (   3)
	cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
	rcall gap_t6           ; (  24)
	rcall gap_t8           ; (  47)
	rcall gap_t8           ; (  70)
	rcall gap_t8           ; (  93)
	rcall gap_t8           ; ( 116)
	rcall gap_t8           ; ( 139)
	sbi   SYNC,    SYNC_P  ; ( 141) Sync pulse goes high
	nop
	st    X+,      r20
	st    X+,      r20     ; ( 146)
	rcall gap_t8           ; ( 169)
	rcall gap_t8           ; ( 192)
	rcall gap_t8           ; ( 215)
	rcall gap_t8           ; ( 238)
	rcall gap_t8           ; ( 261)
	rcall gap_t8           ; ( 284)
	rcall gap_t8           ; ( 307)
	rcall gap_t8           ; ( 330)
	rcall gap_t8           ; ( 353)
	out   PIXOUT,  r17     ; ( 354) Next scanline colored border begins (T.T boundary line)
	rcall gap_t4           ; ( 369)
	rcall gap_t8           ; ( 392)
	rcall gap_t8           ; ( 415)
	rcall gap_t8           ; ( 438)
	rcall gap_t8           ; ( 461)

	ldi   ZL,      31
	out   STACKL,  ZL
	pop   r0
	out   PIXOUT,  r0      ; ( 466) Pixel 0
	jmp   m72_graf_scan_b

gap_t8:
	st    X+,      r20
gap_t7:
	st    X+,      r20
gap_t6:
	st    X+,      r20
gap_t5:
	st    X+,      r20
gap_t4:
	st    X+,      r20
gap_t3:
	st    X+,      r20
gap_t2:
	st    X+,      r20
gap_t1:
	st    X+,      r20
	ret



;
; Game area lead-out code. This produces the last line of the game area in
; which no new line is rendered into the line buffer. The scanline counter
; (r18) is set properly. No need to do anything, just render the line and
; transfer to T.B boundary line.
;
; Enters in cycle 512.
;
m72_gtxt_tran:

	pop   r0
	out   PIXOUT,  r0      ; ( 515) Pixel 7
	ldi   r20,     152
	rjmp  .
gtx_loop:
	nop
	pop   r0
	out   PIXOUT,  r0      ; Pixels 8 - 159
	dec   r20
	brne  gtx_loop
	ldi   ZL,      LB_STACK - 1
	out   STACKL,  ZL      ; Restore stack to work as stack
	rjmp  .
	out   PIXOUT,  r17     ; (1586)
	WAIT  r20,     110
	clr   r20
	out   PIXOUT,  r20     ; (1698) Black border begins



;
; T.B boundary line.
;
; Enters in cycle 1698.
;
tb_tbl_entry:

	lds   r16,     V_TB_CTBL
	cpi   r16,     0
	brne  .+2              ; (1702 / 1703)
	rjmp  tb_pad_entry     ; (1704) None to draw

	; Draw top boundary line

	WAIT  r20,     96      ; (1799)

	; Load color

	lds   r20,     m72_lb_col
	rcall m72_bl_colors    ; (1820 = 0) (19 cycles)

	; Generate line

	rcall m72_blankline    ; (1702)

	; Next scanline, then go on to top text area extra lines

	inc   r18              ; (1703)
	WAIT  r20,     1       ; (1704) Fall through to padding lines



;
; Bottom text area padding lines.
;
; Enters in cycle 1704.
;
tb_pad_entry:

	lds   r16,     V_TB_CPAD
	cpi   r16,     0
	brne  tb_pad_loope     ; (1708 / 1709)
	rjmp  tb_row_entry     ; (1710) None to draw: go on to rows

	; Draw extra lines

tb_pad_loop:

	WAIT  r20,     3       ; (1709)

tb_pad_loope:

	WAIT  r20,     90      ; (1799)

	; Load colors

	rcall m72_tb_colors    ; (1820 = 0) (21 cycles)

	; Generate line

	rcall m72_blankline    ; (1702)

	; Next scanline, loop

	inc   r18
	dec   r16
	brne  tb_pad_loop      ; (1705 / 1706)

	WAIT  r20,     5       ; (1710) Fall through to rows



;
; Bottom text area tile rows.
;
; Enters in cycle 1710.
;
tb_row_entry:

	lds   r16,     V_TB_CROW
	cpi   r16,     0
	brne  tb_row_prep      ; (1714 / 1715)
	rjmp  tb_ext_entry     ; (1716) None to draw: go on to extra lines

	; Draw extra lines

tb_row_prep:

	lds   YL,      m72_tb_vram + 0
	lds   YH,      m72_tb_vram + 1
	clr   r19              ; Tile row to start at: zero
	rjmp  tb_row_loope     ; (1722)

tb_row_loop:

	WAIT  r20,     16      ; (1722)

tb_row_loope:

	WAIT  r20,     77      ; (1799) (Will need loop preparation, at least a start row calculation)

	; Load colors

	rcall m72_tb_colors    ; (1820 = 0) (21 cycles)

	; Generate line

	rcall m72_txtline      ; (1702)

	; Next scanline, loop

	inc   r18
	dec   r16
	brne  tb_row_loop      ; (1705 / 1706)

	WAIT  r20,     11      ; (1716) Fall through to extra lines



;
; Bottom text area extra lines (beyond tile row count).
;
; Enters in cycle 1716.
;
tb_ext_entry:

	lds   r16,     V_TB_CEXT
	cpi   r16,     0
	brne  tb_ext_loope     ; (1720 / 1721)
	rjmp  tb_bbl_entry     ; (1722) None to draw: go on to bottom boundary line

	; Draw extra lines

tb_ext_loop:

	WAIT  r20,     15      ; (1721)

tb_ext_loope:

	WAIT  r20,     78      ; (1799)

	; Load colors

	rcall m72_tb_colors    ; (1820 = 0) (21 cycles)

	; Generate line

	rcall m72_blankline    ; (1702)

	; Next scanline, loop

	inc   r18
	dec   r16
	brne  tb_ext_loop      ; (1705 / 1706)

	WAIT  r20,     17      ; (1722) Fall through to bottom boundary line



;
; Bottom boundary line.
;
; Enters in cycle 1722.
;
tb_bbl_entry:

	lds   r16,     V_TB_CBBL
	cpi   r16,     0
	brne  .+2              ; (1726 / 1727)
	rjmp  fr_leadout       ; (1728) None to draw

	; Draw top boundary line

	WAIT  r20,     72      ; (1799)

	; Load color

	lds   r20,     m72_tb_col
	rcall m72_bl_colors    ; (1820 = 0) (19 cycles)

	; Generate line

	rcall m72_blankline    ; (1702)

	; Next scanline, then go on to top text area extra lines

	inc   r18              ; (1703)
	WAIT  r20,     23      ; (1726)
	rjmp  fr_leadout       ; (1728)



;
; Exit points.
;
; fr_zero_height: 1385
; fr_leadout:     1728
;
fr_zero_height:

	WAIT  r20,     343     ; (1728)

fr_leadout:

	WAIT  r20,     95      ; (   3)
	cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
	rcall m72_sample       ; (  31)

	; Update sync pulse counter

	lds   r20,     render_lines_count
	lds   ZL,      sync_pulse
	inc   r20              ; One extra line for this leadout
	sub   ZL,      r20
	sts   sync_pulse, ZL   ; (  39)

	; Set vsync flag & flip field

	lds   ZL,      sync_flags
	ldi   r20,     SYNC_FLAG_FIELD
	ori   ZL,      SYNC_FLAG_VSYNC
	eor   ZL,      r20
	sts   sync_flags, ZL   ; (  46)

	; Restore clobbered stuff

	lds   r0,      V_S_GP0
	out   GPR0,    r0
	lds   r0,      V_S_GP1
	out   GPR1,    r0
	lds   r0,      V_S_GP2
	out   GPR2,    r0
	lds   r0,      V_S_SPH
	out   STACKH,  r0
	lds   r0,      V_S_SPL
	out   STACKL,  r0      ; (  61)

	WAIT  r20,     78
	sbi   SYNC,    SYNC_P  ; ( 141) Sync pulse goes high

	; Clear any pending timer interrupt

	ldi   ZL,      (1<<OCF1A)
	sts   _SFR_MEM_ADDR(TIFR1), ZL

	ret



;
; Game area line calculation code (interleaved with first few pixels)
;
; Scanline notes:
;
; The horizontal layout with borders is constructed to show as if there were
; 24 tiles (or 48 in text mode).
;
; Cycles:
;
; out PIXOUT, (zero) ; (1698) Black border begins
; cbi SYNC,   SYNC_P ; (   5) Sync pulse goes low
; sbi SYNC,   SYNC_P ; ( 141) Sync pulse goes high
; out PIXOUT, r17    ; ( 354) Next scanline colored border begins
;
m72_graf_scan_b:

	; Display line starts here, sprite blocks jump here
	;
	; Entry must be made as follows:
	;
	; ldi   ZL,      31
	; out   STACKL,  ZL
	; pop   r0
	; out   PIXOUT,  r0      ; ( 466) Pixel 0
	; jmp   m72_graf_scan_b
	;
	;  r1: r0: Temp
	;  r2-r17: Colors (r2: Bg, r17: Border)
	; r18:     Physical scanline
	; r19:     Logical scanline
	; r20-r23: Temp
	; r24-r25: Not used here (X mirrors for sprites 0-15)
	; XH: XL:  Line buffer, target
	; YH: YL:  VRAM
	; ZH: ZL:  Work pointer
	;
	; GPIOR0:
	; 0: Sprite priority select for multiplexing
	; 1: Color 0 (bg) loading enabled from scanline color list
	; 2: Color 15 (border) loading enabled from scanline color list
	; 4-7: X mirrors for sprites 16-19
	;
	; GPIOR1:
	; Preloaded color
	;
	; GPIOR2:
	; Split point into text mode or end of frame (checked in text mode)

	; Preload sound sample & increment pointer (VSync mixer)

	ldi   r22,     hi8(MIX_BUF_SIZE + mix_buf)
	pop   r0
	out   PIXOUT,  r0      ; ( 473) Pixel 1
	lds   ZL,      mix_pos + 0
	lds   ZH,      mix_pos + 1
	pop   r0
	out   PIXOUT,  r0      ; ( 480) Pixel 2
	ld    r23,     Z+      ; Load next sample
	sts   AUDOUT,  r23     ; Sample output is a bit delayed, no big problem
	pop   r0
	out   PIXOUT,  r0      ; ( 487) Pixel 3
	cpi   ZL,      lo8(MIX_BUF_SIZE + mix_buf)
	cpc   ZH,      r22
	ldi   r22,     lo8(mix_buf)
	ldi   r23,     hi8(mix_buf)
	pop   r0
	out   PIXOUT,  r0      ; ( 494) Pixel 4
	brlo  .+2
	movw  ZL,      r22
	sts   mix_pos + 0, ZL
	pop   r0
	out   PIXOUT,  r0      ; ( 501) Pixel 5
	sts   mix_pos + 1, ZH

	; Increment scanline counters & check end condition

	inc   r18
	in    r1,      GPR2    ; Terminating scanline
	pop   r0
	out   PIXOUT,  r0      ; ( 508) Pixel 6
	cp    r18,     r1
	brne  .+2
	rjmp  m72_gtxt_tran    ; ( 512) Transfer to text mode
	inc   r19              ; ( 512)

	; Preload color or logical scanline

#if (M72_SCOLOR_ENA != 0)
	pop   r0
	out   PIXOUT,  r0      ; ( 515) Pixel 7
	mov   ZL,      r18
	clr   ZH
	subi  ZL,      lo8(m72_scolor - 31)
	sbci  ZH,      hi8(m72_scolor - 31)
	pop   r0
	out   PIXOUT,  r0      ; ( 522) Pixel 8
#if (M72_SLINE_ENA != 0)
	ld    r19,     Z
	out   GPR1,    r2      ; Extend color 0 into border if log. line reload is used
#else
	ld    r23,     Z
	out   GPR1,    r23
#endif
#else
	pop   r0
	out   PIXOUT,  r0      ; ( 515) Pixel 7
	rjmp  .
	rjmp  .
	pop   r0
	out   PIXOUT,  r0      ; ( 522) Pixel 8
	rjmp  .
	out   GPR1,    r2      ; Extend color 0 into border if no M72_SCOLOR_ENA
#endif

	; Flip sprite priority for interlacing (GPIOR0 bit 0)

	ldi   ZH,      0x01
	pop   r0
	out   PIXOUT,  r0      ; ( 529) Pixel 9
	in    ZL,      GPR0
	eor   ZL,      ZH
	out   GPR0,    ZL

	; Fetch VRAM entry offset & pixel (X scroll). Either one row offset
	; for each line or each tile row.

	mov   ZL,      r19
	pop   r0
	out   PIXOUT,  r0      ; ( 536) Pixel 10
	clr   ZH
#if (M72_USE_LINE_ADDR != 0)
	nop
	lsl   ZL
	rol   ZH
#else
	lsr   ZL
	lsr   ZL
	andi  ZL,      0x3E
#endif
	pop   r0
	out   PIXOUT,  r0      ; ( 543) Pixel 11
	subi  ZL,      lo8(-(m72_rowoff))
	sbci  ZH,      hi8(-(m72_rowoff))

	; Calculate VRAM entry offset & pixel (X scroll)

	ld    YL,      Z+
	pop   r0
	out   PIXOUT,  r0      ; ( 550) Pixel 12
	ld    YH,      Z+
	mov   XL,      YH
	andi  YH,      0x0F    ; Y: VRAM offset
	pop   r0
	out   PIXOUT,  r0      ; ( 557) Pixel 13
	swap  XL
	andi  XL,      0x07
	neg   XL
	subi  XL,      224     ; Adds 32, so scroll became 0-7 pixels left shift
	pop   r0
	out   PIXOUT,  r0      ; ( 564) Pixel 14

	; Reload palette entries 12 - 14, which regs could be used by sprites

	lds   r14,     palette + 12
	lds   r15,     palette + 13
	pop   r0
	out   PIXOUT,  r0      ; ( 571) Pixel 15
	lds   r16,     palette + 14

	; Jump to appropriate tile row render code

	mov   ZL,      r19     ; Logical scanline => tile row select
	andi  ZL,      0x07
	pop   r0
	out   PIXOUT,  r0      ; ( 578) Pixel 16
	clr   ZH
	subi  ZL,      lo8(-(pm(m72_deftilerows)))
	sbci  ZH,      hi8(-(pm(m72_deftilerows)))
	ldi   r20,     20      ; 20 visible tiles
	pop   r0
	out   PIXOUT,  r0      ; ( 585) Pixel 17
	pop   r21
	pop   r1
	pop   r0
	out   PIXOUT,  r21     ; ( 592) Pixel 18
	clt
	ijmp



;
; VSync mixer output
;
m72_sample:
	ldi   r22,     hi8(MIX_BUF_SIZE + mix_buf)
	lds   ZL,      mix_pos + 0
	lds   ZH,      mix_pos + 1
	ld    r23,     Z+      ; Load next sample
	sts   AUDOUT,  r23
	cpi   ZL,      lo8(MIX_BUF_SIZE + mix_buf)
	cpc   ZH,      r22
	ldi   r22,     lo8(mix_buf)
	ldi   r23,     hi8(mix_buf)
	brlo  .+2
	movw  ZL,      r22
	sts   mix_pos + 0, ZL
	sts   mix_pos + 1, ZH
	ret                    ; (23)



;
; Empty line output. r17: border, r20: background, r22, r23, Z: clobbered
;
m72_blankline:
	cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
	rcall m72_sample       ; (  31)
	WAIT  r22,     108
	sbi   SYNC,    SYNC_P  ; ( 141) Sync pulse goes high
	WAIT  r22,     212
	out   PIXOUT,  r17     ; ( 354) Colored border begins
	WAIT  r22,     111
	out   PIXOUT,  r20     ; ( 466) Background begins
	WAIT  r22,     1119
	out   PIXOUT,  r17     ; (1586) Colored border begins
	WAIT  r22,     110
	clr   r22
	out   PIXOUT,  r22     ; (1698) Black border begins
	ret                    ; (1702)



;
; Text line output. See m72_txt_row in videoMode72_txt.s
; Prepares bg & fg colors from r20 and r21 respectively.
;
m72_txtline:
	cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
	rcall m72_sample       ; (  31)
	WAIT  r22,     108
	sbi   SYNC,    SYNC_P  ; ( 141) Sync pulse goes high
	WAIT  r22,     212
	out   PIXOUT,  r17     ; ( 354) Colored border begins
	WAIT  r22,     69      ; ( 423)
	mov   r4,      r21     ; ( 424) Foreground (1) color
	mov   r5,      r20     ; ( 425) Background (0) color
	call  m72_txt_row      ; (1595)
	WAIT  r22,     101
	clr   r22
	out   PIXOUT,  r22     ; (1698) Black border begins
	ret                    ; (1702)



;
; Boundary line color loads. In r20 the appropriate line color has to be
; prepared.
;
m72_bl_colors:
	lds   r21,     m72_config
#if (M72_SCOLOR_ENA != 0)
	mov   ZL,      r18
	clr   ZH
	subi  ZL,      lo8(m72_scolor - 31)
	sbci  ZH,      hi8(m72_scolor - 31)
	ld    ZL,      Z
#else
	rjmp  .
	rjmp  .
	lds   ZL,      bordercolor
#endif
	sbrc  r21,     0       ; Boundary line colors disabled?
	mov   r20,     ZL      ; If so, use the border color
	sbic  GPR0,    2       ; Color 15 (border) loading enabled?
	mov   r17,     r20     ; If so, load boundary line color
	ret                    ; (16)



;
; Top text region color loads. r20: background, r21: foreground
;
m72_tt_colors:
	lds   r20,     m72_tt_bcol
	lds   r21,     m72_tt_fcol
#if (M72_SCOLOR_ENA != 0)
	mov   ZL,      r18
	clr   ZH
	subi  ZL,      lo8(m72_scolor - 31)
	sbci  ZH,      hi8(m72_scolor - 31)
	ld    r22,     Z
#else
	rjmp  .
	rjmp  .
	lds   r22,     bordercolor
#endif
	sbic  GPR0,    2       ; Border color loading / expansion enabled?
	mov   r17,     r22     ; If so, load it
	sbic  GPR0,    3       ; Background color replace enabled?
	mov   r20,     r22     ; If so, replace it
	ret                    ; (18)



;
; Bottom text region color loads. r20: background, r21: foreground
;
m72_tb_colors:
	lds   r20,     m72_tb_bcol
	lds   r21,     m72_tb_fcol
#if (M72_SCOLOR_ENA != 0)
	mov   ZL,      r18
	clr   ZH
	subi  ZL,      lo8(m72_scolor - 31)
	sbci  ZH,      hi8(m72_scolor - 31)
	ld    r22,     Z
#else
	rjmp  .
	rjmp  .
	lds   r22,     bordercolor
#endif
	sbic  GPR0,    2       ; Border color loading / expansion enabled?
	mov   r17,     r22     ; If so, load it
	sbic  GPR0,    3       ; Background color replace enabled?
	mov   r20,     r22     ; If so, replace it
	ret                    ; (18)



;
; Empty sprite mode
;
m72_sp15_yprep:
	in    XH,      STACKH
	ldi   XL,      252
	ldi   r18,     hi8(pm(m72_sp15))
	st    X+,      r18
	ldi   r18,     lo8(pm(m72_sp15))
	st    X+,      r18
	ldi   r18,     hi8(pm(m72_sp15))
	st    X+,      r18
	ldi   r18,     lo8(pm(m72_sp15))
	st    X+,      r18     ; ( 14)
	WAIT  r18,     382
	ret                    ; (400)

m72_sp15:
	WAIT  r20,     63      ; (1633 + 63)
	clr   r20
	out   PIXOUT,  r20     ; (1698) Black border begins
	WAIT  r20,     125
	cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
	WAIT  r20,     134
	sbi   SYNC,    SYNC_P  ; ( 141) Sync pulse goes high
	WAIT  r20,     212
	out   PIXOUT,  r17     ; ( 354) Next scanline colored border begins
	WAIT  r20,     107     ; ( 461)
	ldi   ZL,      31
	out   STACKL,  ZL
	pop   r0
	out   PIXOUT,  r0      ; ( 466) Pixel 0
	jmp   m72_graf_scan_b



#if (M72_DUMMY_BG != 0)
;
; Blank tileset code (background color, sprites only)
;
; Use as template to build the code tiles (note the 2x rjmp entry, can be used
; for code tile row reuse schemes).
;
m72_deftilerows:
	rjmp  bts_row_00
	rjmp  bts_row_01
	rjmp  bts_row_02
	rjmp  bts_row_03
	rjmp  bts_row_04
	rjmp  bts_row_05
	rjmp  bts_row_06
	rjmp  bts_row_07

bts_row_00:
bts_row_01:
bts_row_02:
bts_row_03:
bts_row_04:
bts_row_05:
bts_row_06:
bts_row_07:
	nop                    ; Normally ldi ZH, hi8(pm(rowmap))
	out   PIXOUT,  r1      ; ( 599) Pixel 19
	jmp   bts_entry

bts_rowmap:
	rjmp  bts_cbsel        ; Normally 256 entries / row

bts_cbsel:
	rjmp  bts_cblock

bts_cblock:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  bts_common

bts_common:
	out   PIXOUT,  r0
	breq  bts_exit         ; Uses Z flag
	pop   r0
bts_entry:
	dec   r20              ; Remaining tile count (Z flag sets accordingly)
	rjmp  .                ; Normally ld ZL, Y+
	out   PIXOUT,  r0
	pop   r0
	pop   r21
	pop   r1
	out   PIXOUT,  r0
	pop   r22
	pop   r23
	pop   r0
	out   PIXOUT,  r21
	rjmp  bts_rowmap       ; Normally ijmp
bts_exit:
	brts  bts_exitf        ; (1582 / 1621)
	mov   r22,     r17
	mov   r23,     r17
	movw  r0,      r22
	out   PIXOUT,  r17     ; (1586)
	rjmp  .                ; Normally ld ZL, Y+
	set                    ; T reg indicates final exit condition
	rjmp  bts_rowmap       ; Normally ijmp
bts_exitf:
	sbic  GPR0,    1       ; (1622) Color 0 (bg) loading enabled?
	in    r2,      GPR1    ; (1623) If so, load it
	sbic  GPR0,    2       ; (1624) Color 15 (border) loading enabled?
	in    r17,     GPR1    ; (1625) If so, load it
	ldi   ZL,      LB_SPR_B - 1 ; (1626) 254(HI):255(LO): Sprite conf B
	sbic  GPR0,    0       ; (1627)
	ldi   ZL,      LB_SPR_A - 1 ; (1628) 252(HI):253(LO): Sprite conf A
	out   STACKL,  ZL      ; (1629)
	ret                    ; (1633)
#endif



; Code table for 2bpp sprites

#include "videoMode72_sp2bpp.s"

; Text mode

#include "videoMode72_txt.s"

; Sprite modes

#if ((M72_SPRITE_MODES & 0x0001) != 0)
#include "videoMode72_sp0.s"
#endif
#if ((M72_SPRITE_MODES & 0x0002) != 0)
#include "videoMode72_sp1.s"
#endif
#if ((M72_SPRITE_MODES & 0x0004) != 0)
#include "videoMode72_sp2.s"
#endif
#if ((M72_SPRITE_MODES & 0x0008) != 0)
#include "videoMode72_sp3.s"
#endif
#if ((M72_SPRITE_MODES & 0x0010) != 0)
#include "videoMode72_sp4.s"
#endif
#if ((M72_SPRITE_MODES & 0x0020) != 0)
#include "videoMode72_sp5.s"
#endif
#if ((M72_SPRITE_MODES & 0x0040) != 0)
#include "videoMode72_sp6.s"
#endif
#if ((M72_SPRITE_MODES & 0x0080) != 0)
#include "videoMode72_sp7.s"
#endif
#if ((M72_SPRITE_MODES & 0x0100) != 0)
#include "videoMode72_sp8.s"
#endif
#if ((M72_SPRITE_MODES & 0x0200) != 0)
#include "videoMode72_sp9.s"
#endif
#if ((M72_SPRITE_MODES & 0x0400) != 0)
#include "videoMode72_sp10.s"
#endif
#if ((M72_SPRITE_MODES & 0x0800) != 0)
#include "videoMode72_sp11.s"
#endif
#if ((M72_SPRITE_MODES & 0x1000) != 0)
#include "videoMode72_sp12.s"
#endif
#if ((M72_SPRITE_MODES & 0x2000) != 0)
#include "videoMode72_sp13.s"
#endif
#if ((M72_SPRITE_MODES & 0x4000) != 0)
#include "videoMode72_sp14.s"
#endif
