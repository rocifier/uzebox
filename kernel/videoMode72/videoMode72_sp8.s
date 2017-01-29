/*
 *  Uzebox Kernel - Mode 72, Sprite mode 8
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
; Video mode 72, Sprite mode 8
;
; 18 x 12 pixels wide 2bpp sprites with C64 MC mode limitations
;
; Up to 8 sprites per scanline
;
; Muxed pairs: 0-1, 2-3, 4-5, 6-7, 8-9, 10-11, 12-13, 14-15-(16-17)
;
; The Commodore 64 limitations are: No X mirroring, only Color 1 can be
; specified per sprite (Color 2 and 3 are taken from Sprite 0), the height
; of the sprites is 21 pixels (a sprite taking 63 bytes of RAM).
;
;=============================================================================



.section .text



;
; Scanline notes:
;
; The horizontal layout with borders is constructed to show as if there were
; 24 tiles (or 48 in text mode).
;
; Cycles:
;
; Entry:                 ; (1633)
; out   PIXOUT,  (zero)  ; (1698) Black border begins
; cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
; sbi   SYNC,    SYNC_P  ; ( 141) Sync pulse goes high
; out   PIXOUT,  r17     ; ( 354) Next scanline colored border begins
; Last cycle:            ; ( 461)
;
; Registers:
;
;  r1: r0: Temp
;  r2-r13: Background colors
; r14-r16: Temp
; r17:     Border color
; r18:     Physical scanline (use to check sprite Y)
; r19:     Log. scanline (no usage)
; r20-r23: Temp
; r24:     Sprite 0-7 X mirror
; r25:     Sprite 8-15 X mirror
;  ZH: ZL: Work pointer (code tiling etc.)
;  YH: YL: Work pointer (for sprite data access)
;  XH: XL: Line buffer access
; GPIOR0:  Sprite 16-19 X mirror on bits 4-7
;
; Return sequence (after last cycle):
;
; ldi   ZL,      15
; out   SPL,     ZL
; pop   r0
; out   PIXOUT,  r0      ; ( 466) Pixel 0
; jmp   m72_graf_scan_b
;
; Video stack top = LB_STACK - 1 may be used
;



;
; Sprite Y preparation & Entry point loads
;
; Stack is already on the line buffer (SPH: Line buffer bank)
;
; 400 cycles with ret
;
m72_sp8_yprep:

	ldi   YL,      lo8(sprites)
	ldi   YH,      hi8(sprites)
	ldi   ZL,      lo8(v_spoff)
	ldi   ZH,      hi8(v_spoff)

	; This mode demands limiting X positions to 176 as it doesn't read
	; sprite heights (which would be set zero for an off-screen sprite)

	ldi   r18,     9       ; (  5)
sp8_ypr_l:
	ldd   r16,     Y + 0 + SP_YPOS
	ldd   r17,     Y + 0 + SP_OFF
	sub   r17,     r16
	sub   r17,     r16
	sub   r17,     r16
	subi  r17,     3
	st    Z+,      r17
	ldd   r16,     Y + 0 + SP_XPOS
	cpi   r16,     176
	brcs  .+2
	ldi   r16,     176
	std   Y + 0 + SP_XPOS, r16
	ldd   r16,     Y + 8 + SP_YPOS
	ldd   r17,     Y + 8 + SP_OFF
	sub   r17,     r16
	sub   r17,     r16
	sub   r17,     r16
	subi  r17,     3
	st    Z+,      r17
	ldd   r16,     Y + 8 + SP_XPOS
	cpi   r16,     176
	brcs  .+2
	ldi   r16,     176
	std   Y + 8 + SP_XPOS, r16
	adiw  YL,      16
	dec   r18
	brne  sp8_ypr_l        ; (355)

	in    XH,      STACKH
	ldi   XL,      LB_SPR_A
	ldi   r18,     hi8(pm(m72_sp8_a))
	st    X+,      r18
	ldi   r18,     lo8(pm(m72_sp8_a))
	st    X+,      r18
	ldi   r18,     hi8(pm(m72_sp8_b))
	st    X+,      r18
	ldi   r18,     lo8(pm(m72_sp8_b))
	st    X+,      r18     ; (369)

	WAIT  r18,     27
	ret                    ; (400)



;
; Entry point A
;
m72_sp8_a:

	ldi   ZL,      LB_STACK - 1 ; Back to video stack (at the end of the line buffer)
	out   STACKL,  ZL
	mov   r1,      r18
	lsl   r1
	add   r1,      r18          ; 3 x Phys. scanline for offsets


	; (1638) Prepare loading elements common to all sprites

	lds   r22,     sprites + ( 0 * 8) + SP_COL2
	lds   r23,     sprites + ( 0 * 8) + SP_COL3
	ldi   r20,     21           ; C64 sprite height: 21 pixels
	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	clr   r0

	; (1645) Preload

	lds   r14,     sprites + ( 2 * 8) + SP_YPOS
	sub   r14,     r18
	lds   r15,     sprites + ( 3 * 8) + SP_YPOS
	sub   r15,     r18
	lds   r16,     sprites + ( 4 * 8) + SP_YPOS
	sub   r16,     r18
	rjmp  .

	; (1656) Sprites 0/1

	lds   XL,      sprites + ( 0 * 8) + SP_YPOS
	lds   YL,      sprites + ( 1 * 8) + SP_YPOS
	sub   XL,      r18
	sub   YL,      r18
	add   XL,      r20
	brcs  sp8_a_00act      ; ( 8 /  9) Sprite 0 has priority over Sprite 1
	add   YL,      r20
	brcs  sp8_a_01act      ; (10 / 11)

	WAIT  YL,      31
	; --- (Display) ---
	out   PIXOUT,  r0      ; (1698) Black border
	; -----------------
	WAIT  YL,      34
	rjmp  sp8_a_00end      ; (77)

sp8_a_00act:

	; Sprite 0 renders, Sprite 1 skips

	lds   YL,      v_spoff + ( 0)
	lds   YH,      sprites + ( 0 * 8) + SP_BANK
	lds   XL,      sprites + ( 0 * 8) + SP_XPOS
	lds   r21,     sprites + ( 0 * 8) + SP_COL1
	rjmp  sp8_a_00ren      ; (19)

sp8_a_01act:

	; Sprite 1 renders

	lds   YL,      v_spoff + ( 1)
	lds   YH,      sprites + ( 1 * 8) + SP_BANK
	lds   XL,      sprites + ( 1 * 8) + SP_XPOS
	lds   r21,     sprites + ( 1 * 8) + SP_COL1

sp8_a_00ren:

	add   YL,      r1      ; (20)
	ldd   ZL,      Y + 0   ; (22)
	icall                  ; (39)
	ldd   ZL,      Y + 1   ; (41)
	; --- (Display) ---
	out   PIXOUT,  r0      ; (1698) Black border
	; -----------------
	icall                  ; (58)
	ldd   ZL,      Y + 2   ; (60)
	icall                  ; (77)

sp8_a_00end:


	; (1734) Sprites 2/3 (-6 cy)

	add   r14,     r20
	brcs  sp8_a_02act      ; ( 8 /  9) Sprite 2 has priority over Sprite 3
	add   r15,     r20
	brcs  sp8_a_03act      ; (10 / 11)

	WAIT  YL,      65
	rjmp  sp8_a_02end      ; (77)

sp8_a_02act:

	; Sprite 2 renders, Sprite 3 skips

	lds   YL,      v_spoff + ( 2)
	lds   YH,      sprites + ( 2 * 8) + SP_BANK
	lds   XL,      sprites + ( 2 * 8) + SP_XPOS
	lds   r21,     sprites + ( 2 * 8) + SP_COL1
	rjmp  sp8_a_02ren      ; (19)

sp8_a_03act:

	; Sprite 3 renders

	lds   YL,      v_spoff + ( 3)
	lds   YH,      sprites + ( 3 * 8) + SP_BANK
	lds   XL,      sprites + ( 3 * 8) + SP_XPOS
	lds   r21,     sprites + ( 3 * 8) + SP_COL1

sp8_a_02ren:

	add   YL,      r1      ; (20)
	ldd   ZL,      Y + 0   ; (22)
	icall                  ; (39)
	ldd   ZL,      Y + 1   ; (41)
	icall                  ; (58)
	ldd   ZL,      Y + 2   ; (60)
	icall                  ; (77)

sp8_a_02end:


	; (1805) Preload

	lds   r14,     sprites + ( 6 * 8) + SP_YPOS

	; (1807) Sprites 4/5 (-3 cy)

	lds   YL,      sprites + ( 5 * 8) + SP_YPOS
	sub   YL,      r18
	add   r16,     r20
	brcs  sp8_a_04act      ; ( 8 /  9) Sprite 4 has priority over Sprite 5
	add   YL,      r20
	brcs  sp8_a_05act      ; (10 / 11)

	WAIT  YL,      9
	; --- (Display) ---
	cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
	; -----------------
	WAIT  YL,      56
	rjmp  sp8_a_04end      ; (77)

sp8_a_04act:

	; Sprite 4 renders, Sprite 5 skips

	lds   YL,      v_spoff + ( 4)
	lds   YH,      sprites + ( 4 * 8) + SP_BANK
	lds   XL,      sprites + ( 4 * 8) + SP_XPOS
	lds   r21,     sprites + ( 4 * 8) + SP_COL1
	rjmp  sp8_a_04ren      ; (19)

sp8_a_05act:

	; Sprite 5 renders

	lds   YL,      v_spoff + ( 5)
	lds   YH,      sprites + ( 5 * 8) + SP_BANK
	lds   XL,      sprites + ( 5 * 8) + SP_XPOS
	lds   r21,     sprites + ( 5 * 8) + SP_COL1

sp8_a_04ren:

	; --- (Display) ---
	cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
	; -----------------
	add   YL,      r1      ; (20)
	ldd   ZL,      Y + 0   ; (22)
	icall                  ; (39)
	ldd   ZL,      Y + 1   ; (41)
	icall                  ; (58)
	ldd   ZL,      Y + 2   ; (60)
	icall                  ; (77)

sp8_a_04end:


	; (  63) Sprites 6/7 (-2 cy)

	lds   YL,      sprites + ( 7 * 8) + SP_YPOS
	sub   r14,     r18
	sub   YL,      r18
	add   r14,     r20
	brcs  sp8_a_06act      ; ( 8 /  9) Sprite 6 has priority over Sprite 7
	add   YL,      r20
	brcs  sp8_a_07act      ; (10 / 11)

	WAIT  YL,      65
	rjmp  sp8_a_06end      ; (77)

sp8_a_06act:

	; Sprite 6 renders, Sprite 7 skips

	lds   YL,      v_spoff + ( 6)
	lds   YH,      sprites + ( 6 * 8) + SP_BANK
	lds   XL,      sprites + ( 6 * 8) + SP_XPOS
	lds   r21,     sprites + ( 6 * 8) + SP_COL1
	rjmp  sp8_a_06ren      ; (19)

sp8_a_07act:

	; Sprite 7 renders

	lds   YL,      v_spoff + ( 7)
	lds   YH,      sprites + ( 7 * 8) + SP_BANK
	lds   XL,      sprites + ( 7 * 8) + SP_XPOS
	lds   r21,     sprites + ( 7 * 8) + SP_COL1

sp8_a_06ren:

	add   YL,      r1      ; (20)
	ldd   ZL,      Y + 0   ; (22)
	icall                  ; (39)
	ldd   ZL,      Y + 1   ; (41)
	icall                  ; (58)
	ldd   ZL,      Y + 2   ; (60)
	icall                  ; (77)

sp8_a_06end:


	; ( 138) Sprites 8/9

	; --- (Display) ---
	nop
	sbi   SYNC,    SYNC_P  ; ( 141) Sync pulse goes high
	; -----------------
	lds   XL,      sprites + ( 8 * 8) + SP_YPOS
	lds   YL,      sprites + ( 9 * 8) + SP_YPOS
	sub   XL,      r18
	sub   YL,      r18
	add   XL,      r20
	brcs  sp8_a_08act      ; ( 8 /  9) Sprite 8 has priority over Sprite 9
	add   YL,      r20
	brcs  sp8_a_09act      ; (10 / 11)

	WAIT  YL,      65
	rjmp  sp8_a_08end      ; (77)

sp8_a_08act:

	; Sprite 8 renders, Sprite 9 skips

	lds   YL,      v_spoff + ( 8)
	lds   YH,      sprites + ( 8 * 8) + SP_BANK
	lds   XL,      sprites + ( 8 * 8) + SP_XPOS
	lds   r21,     sprites + ( 8 * 8) + SP_COL1
	rjmp  sp8_a_08ren      ; (19)

sp8_a_09act:

	; Sprite 1 renders

	lds   YL,      v_spoff + ( 9)
	lds   YH,      sprites + ( 9 * 8) + SP_BANK
	lds   XL,      sprites + ( 9 * 8) + SP_XPOS
	lds   r21,     sprites + ( 9 * 8) + SP_COL1

sp8_a_08ren:

	add   YL,      r1      ; (20)
	ldd   ZL,      Y + 0   ; (22)
	icall                  ; (39)
	ldd   ZL,      Y + 1   ; (41)
	icall                  ; (58)
	ldd   ZL,      Y + 2   ; (60)
	icall                  ; (77)

sp8_a_08end:


	; ( 218) Sprites 10/11

	lds   XL,      sprites + (10 * 8) + SP_YPOS
	lds   YL,      sprites + (11 * 8) + SP_YPOS
	sub   XL,      r18
	sub   YL,      r18
	add   XL,      r20
	brcs  sp8_a_10act      ; ( 8 /  9) Sprite 10 has priority over Sprite 11
	add   YL,      r20
	brcs  sp8_a_11act      ; (10 / 11)

	WAIT  YL,      65
	rjmp  sp8_a_10end      ; (77)

sp8_a_10act:

	; Sprite 10 renders, Sprite 11 skips

	lds   YL,      v_spoff + (10)
	lds   YH,      sprites + (10 * 8) + SP_BANK
	lds   XL,      sprites + (10 * 8) + SP_XPOS
	lds   r21,     sprites + (10 * 8) + SP_COL1
	rjmp  sp8_a_10ren      ; (19)

sp8_a_11act:

	; Sprite 11 renders

	lds   YL,      v_spoff + (11)
	lds   YH,      sprites + (11 * 8) + SP_BANK
	lds   XL,      sprites + (11 * 8) + SP_XPOS
	lds   r21,     sprites + (11 * 8) + SP_COL1

sp8_a_10ren:

	add   YL,      r1      ; (20)
	ldd   ZL,      Y + 0   ; (22)
	icall                  ; (39)
	ldd   ZL,      Y + 1   ; (41)
	icall                  ; (58)
	ldd   ZL,      Y + 2   ; (60)
	icall                  ; (77)

sp8_a_10end:


	; ( 295) Sprites 12/13

	lds   XL,      sprites + (12 * 8) + SP_YPOS
	lds   YL,      sprites + (13 * 8) + SP_YPOS
	sub   XL,      r18
	sub   YL,      r18
	add   XL,      r20
	brcs  sp8_a_12act      ; ( 8 /  9) Sprite 12 has priority over Sprite 13
	add   YL,      r20
	brcs  sp8_a_13act      ; (10 / 11)

	WAIT  YL,      48
	; --- (Display) ---
	out   PIXOUT,  r17     ; ( 354) Next scanline colored border begins
	; -----------------
	WAIT  YL,      17
	rjmp  sp8_a_12end      ; (77)

sp8_a_12act:

	; Sprite 12 renders, Sprite 13 skips

	lds   YL,      v_spoff + (12)
	lds   YH,      sprites + (12 * 8) + SP_BANK
	lds   XL,      sprites + (12 * 8) + SP_XPOS
	lds   r21,     sprites + (12 * 8) + SP_COL1
	rjmp  sp8_a_12ren      ; (19)

sp8_a_13act:

	; Sprite 13 renders

	lds   YL,      v_spoff + (13)
	lds   YH,      sprites + (13 * 8) + SP_BANK
	lds   XL,      sprites + (13 * 8) + SP_XPOS
	lds   r21,     sprites + (13 * 8) + SP_COL1

sp8_a_12ren:

	add   YL,      r1      ; (20)
	ldd   ZL,      Y + 0   ; (22)
	icall                  ; (39)
	ldd   ZL,      Y + 1   ; (41)
	icall                  ; (58)
	; --- (Display) ---
	out   PIXOUT,  r17     ; ( 354) Next scanline colored border begins
	; -----------------
	ldd   ZL,      Y + 2   ; (60)
	icall                  ; (77)

sp8_a_12end:


	; ( 373) Sprites 14/15/(16/17)

	lds   XL,      sprites + (14 * 8) + SP_YPOS
	lds   YL,      sprites + (15 * 8) + SP_YPOS
	sub   XL,      r18
	sub   YL,      r18
	add   XL,      r20
	brcs  sp8_a_14act      ; ( 8 /  9) Sprite 14 has priority over Sprite 15
	add   YL,      r20
	brcs  sp8_a_15act      ; (10 / 11)
	lds   XL,      sprites + (16 * 8) + SP_YPOS
	lds   YL,      sprites + (17 * 8) + SP_YPOS
	sub   XL,      r18
	sub   YL,      r18
	add   XL,      r20
	brcs  sp8_a_16act      ; (18 / 19) Sprite 16 has priority over Sprite 17
	add   YL,      r20
	brcs  sp8_a_17act      ; (20 / 21)

	WAIT  YL,      65
	rjmp  sp8_a_14end      ; (87)

sp8_a_14act:

	; Sprite 14 renders, Sprite 15 skips (16, 17 skips)

	lds   YL,      v_spoff + (14)
	lds   YH,      sprites + (14 * 8) + SP_BANK
	lds   XL,      sprites + (14 * 8) + SP_XPOS
	lds   r21,     sprites + (14 * 8) + SP_COL1
	rjmp  sp8_a_14acc      ; (19)

sp8_a_15act:

	; Sprite 15 renders (16, 17 skips)

	lds   YL,      v_spoff + (15)
	lds   YH,      sprites + (15 * 8) + SP_BANK
	lds   XL,      sprites + (15 * 8) + SP_XPOS
	lds   r21,     sprites + (15 * 8) + SP_COL1

sp8_a_14acc:

	rjmp  .
	rjmp  .
	rjmp  .
	rjmp  .
	rjmp  sp8_a_14ren      ; (29)

sp8_a_16act:

	; Sprite 16 renders, Sprite 17 skips

	lds   YL,      v_spoff + (16)
	lds   YH,      sprites + (16 * 8) + SP_BANK
	lds   XL,      sprites + (16 * 8) + SP_XPOS
	lds   r21,     sprites + (16 * 8) + SP_COL1
	rjmp  sp8_a_14ren      ; (29)

sp8_a_17act:

	; Sprite 17 renders

	lds   YL,      v_spoff + (17)
	lds   YH,      sprites + (17 * 8) + SP_BANK
	lds   XL,      sprites + (17 * 8) + SP_XPOS
	lds   r21,     sprites + (17 * 8) + SP_COL1

sp8_a_14ren:

	add   YL,      r1      ; (30)
	ldd   ZL,      Y + 0   ; (32)
	icall                  ; (49)
	ldd   ZL,      Y + 1   ; (51)
	icall                  ; (68)
	ldd   ZL,      Y + 2   ; (70)
	icall                  ; (87)

sp8_a_14end:


	; ( 460) End

	nop

	; ( 461) Go on to next line

	ldi   ZL,      15
	out   STACKL,  ZL
	pop   r0
	out   PIXOUT,  r0      ; ( 466) Pixel 0
	jmp   m72_graf_scan_b



;
; Entry point B
;
m72_sp8_b:

	ldi   ZL,      LB_STACK - 1 ; Back to video stack (at the end of the line buffer)
	out   STACKL,  ZL
	mov   r1,      r18
	lsl   r1
	add   r1,      r18          ; 3 x Phys. scanline for offsets


	; (1638) Prepare loading elements common to all sprites

	lds   r22,     sprites + ( 0 * 8) + SP_COL2
	lds   r23,     sprites + ( 0 * 8) + SP_COL3
	ldi   r20,     21           ; C64 sprite height: 21 pixels
	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	clr   r0

	; (1645) Preload

	lds   r14,     sprites + ( 3 * 8) + SP_YPOS
	sub   r14,     r18
	lds   r15,     sprites + ( 2 * 8) + SP_YPOS
	sub   r15,     r18
	lds   r16,     sprites + ( 5 * 8) + SP_YPOS
	sub   r16,     r18
	rjmp  .

	; (1656) Sprites 0/1

	lds   XL,      sprites + ( 1 * 8) + SP_YPOS
	lds   YL,      sprites + ( 0 * 8) + SP_YPOS
	sub   XL,      r18
	sub   YL,      r18
	add   XL,      r20
	brcs  sp8_b_00act      ; ( 8 /  9) Sprite 0 has priority over Sprite 1
	add   YL,      r20
	brcs  sp8_b_01act      ; (10 / 11)

	WAIT  YL,      31
	; --- (Display) ---
	out   PIXOUT,  r0      ; (1698) Black border
	; -----------------
	WAIT  YL,      34
	rjmp  sp8_b_00end      ; (77)

sp8_b_00act:

	; Sprite 0 renders, Sprite 1 skips

	lds   YL,      v_spoff + ( 1)
	lds   YH,      sprites + ( 1 * 8) + SP_BANK
	lds   XL,      sprites + ( 1 * 8) + SP_XPOS
	lds   r21,     sprites + ( 1 * 8) + SP_COL1
	rjmp  sp8_b_00ren      ; (19)

sp8_b_01act:

	; Sprite 1 renders

	lds   YL,      v_spoff + ( 0)
	lds   YH,      sprites + ( 0 * 8) + SP_BANK
	lds   XL,      sprites + ( 0 * 8) + SP_XPOS
	lds   r21,     sprites + ( 0 * 8) + SP_COL1

sp8_b_00ren:

	add   YL,      r1      ; (20)
	ldd   ZL,      Y + 0   ; (22)
	icall                  ; (39)
	ldd   ZL,      Y + 1   ; (41)
	; --- (Display) ---
	out   PIXOUT,  r0      ; (1698) Black border
	; -----------------
	icall                  ; (58)
	ldd   ZL,      Y + 2   ; (60)
	icall                  ; (77)

sp8_b_00end:


	; (1734) Sprites 2/3 (-6 cy)

	add   r14,     r20
	brcs  sp8_b_02act      ; ( 8 /  9) Sprite 2 has priority over Sprite 3
	add   r15,     r20
	brcs  sp8_b_03act      ; (10 / 11)

	WAIT  YL,      65
	rjmp  sp8_b_02end      ; (77)

sp8_b_02act:

	; Sprite 2 renders, Sprite 3 skips

	lds   YL,      v_spoff + ( 3)
	lds   YH,      sprites + ( 3 * 8) + SP_BANK
	lds   XL,      sprites + ( 3 * 8) + SP_XPOS
	lds   r21,     sprites + ( 3 * 8) + SP_COL1
	rjmp  sp8_b_02ren      ; (19)

sp8_b_03act:

	; Sprite 3 renders

	lds   YL,      v_spoff + ( 2)
	lds   YH,      sprites + ( 2 * 8) + SP_BANK
	lds   XL,      sprites + ( 2 * 8) + SP_XPOS
	lds   r21,     sprites + ( 2 * 8) + SP_COL1

sp8_b_02ren:

	add   YL,      r1      ; (20)
	ldd   ZL,      Y + 0   ; (22)
	icall                  ; (39)
	ldd   ZL,      Y + 1   ; (41)
	icall                  ; (58)
	ldd   ZL,      Y + 2   ; (60)
	icall                  ; (77)

sp8_b_02end:


	; (1805) Preload

	lds   r14,     sprites + ( 7 * 8) + SP_YPOS

	; (1807) Sprites 4/5 (-3 cy)

	lds   YL,      sprites + ( 4 * 8) + SP_YPOS
	sub   YL,      r18
	add   r16,     r20
	brcs  sp8_b_04act      ; ( 8 /  9) Sprite 4 has priority over Sprite 5
	add   YL,      r20
	brcs  sp8_b_05act      ; (10 / 11)

	WAIT  YL,      9
	; --- (Display) ---
	cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
	; -----------------
	WAIT  YL,      56
	rjmp  sp8_b_04end      ; (77)

sp8_b_04act:

	; Sprite 4 renders, Sprite 5 skips

	lds   YL,      v_spoff + ( 5)
	lds   YH,      sprites + ( 5 * 8) + SP_BANK
	lds   XL,      sprites + ( 5 * 8) + SP_XPOS
	lds   r21,     sprites + ( 5 * 8) + SP_COL1
	rjmp  sp8_b_04ren      ; (19)

sp8_b_05act:

	; Sprite 5 renders

	lds   YL,      v_spoff + ( 4)
	lds   YH,      sprites + ( 4 * 8) + SP_BANK
	lds   XL,      sprites + ( 4 * 8) + SP_XPOS
	lds   r21,     sprites + ( 4 * 8) + SP_COL1

sp8_b_04ren:

	; --- (Display) ---
	cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
	; -----------------
	add   YL,      r1      ; (20)
	ldd   ZL,      Y + 0   ; (22)
	icall                  ; (39)
	ldd   ZL,      Y + 1   ; (41)
	icall                  ; (58)
	ldd   ZL,      Y + 2   ; (60)
	icall                  ; (77)

sp8_b_04end:


	; (  63) Sprites 6/7 (-2 cy)

	lds   YL,      sprites + ( 6 * 8) + SP_YPOS
	sub   r14,     r18
	sub   YL,      r18
	add   r14,     r20
	brcs  sp8_b_06act      ; ( 8 /  9) Sprite 6 has priority over Sprite 7
	add   YL,      r20
	brcs  sp8_b_07act      ; (10 / 11)

	WAIT  YL,      65
	rjmp  sp8_b_06end      ; (77)

sp8_b_06act:

	; Sprite 6 renders, Sprite 7 skips

	lds   YL,      v_spoff + ( 7)
	lds   YH,      sprites + ( 7 * 8) + SP_BANK
	lds   XL,      sprites + ( 7 * 8) + SP_XPOS
	lds   r21,     sprites + ( 7 * 8) + SP_COL1
	rjmp  sp8_b_06ren      ; (19)

sp8_b_07act:

	; Sprite 7 renders

	lds   YL,      v_spoff + ( 6)
	lds   YH,      sprites + ( 6 * 8) + SP_BANK
	lds   XL,      sprites + ( 6 * 8) + SP_XPOS
	lds   r21,     sprites + ( 6 * 8) + SP_COL1

sp8_b_06ren:

	add   YL,      r1      ; (20)
	ldd   ZL,      Y + 0   ; (22)
	icall                  ; (39)
	ldd   ZL,      Y + 1   ; (41)
	icall                  ; (58)
	ldd   ZL,      Y + 2   ; (60)
	icall                  ; (77)

sp8_b_06end:


	; ( 138) Sprites 8/9

	; --- (Display) ---
	nop
	sbi   SYNC,    SYNC_P  ; ( 141) Sync pulse goes high
	; -----------------
	lds   XL,      sprites + ( 9 * 8) + SP_YPOS
	lds   YL,      sprites + ( 8 * 8) + SP_YPOS
	sub   XL,      r18
	sub   YL,      r18
	add   XL,      r20
	brcs  sp8_b_08act      ; ( 8 /  9) Sprite 8 has priority over Sprite 9
	add   YL,      r20
	brcs  sp8_b_09act      ; (10 / 11)

	WAIT  YL,      65
	rjmp  sp8_b_08end      ; (77)

sp8_b_08act:

	; Sprite 8 renders, Sprite 9 skips

	lds   YL,      v_spoff + ( 9)
	lds   YH,      sprites + ( 9 * 8) + SP_BANK
	lds   XL,      sprites + ( 9 * 8) + SP_XPOS
	lds   r21,     sprites + ( 9 * 8) + SP_COL1
	rjmp  sp8_b_08ren      ; (19)

sp8_b_09act:

	; Sprite 1 renders

	lds   YL,      v_spoff + ( 8)
	lds   YH,      sprites + ( 8 * 8) + SP_BANK
	lds   XL,      sprites + ( 8 * 8) + SP_XPOS
	lds   r21,     sprites + ( 8 * 8) + SP_COL1

sp8_b_08ren:

	add   YL,      r1      ; (20)
	ldd   ZL,      Y + 0   ; (22)
	icall                  ; (39)
	ldd   ZL,      Y + 1   ; (41)
	icall                  ; (58)
	ldd   ZL,      Y + 2   ; (60)
	icall                  ; (77)

sp8_b_08end:


	; ( 218) Sprites 10/11

	lds   XL,      sprites + (11 * 8) + SP_YPOS
	lds   YL,      sprites + (10 * 8) + SP_YPOS
	sub   XL,      r18
	sub   YL,      r18
	add   XL,      r20
	brcs  sp8_b_10act      ; ( 8 /  9) Sprite 10 has priority over Sprite 11
	add   YL,      r20
	brcs  sp8_b_11act      ; (10 / 11)

	WAIT  YL,      65
	rjmp  sp8_b_10end      ; (77)

sp8_b_10act:

	; Sprite 10 renders, Sprite 11 skips

	lds   YL,      v_spoff + (11)
	lds   YH,      sprites + (11 * 8) + SP_BANK
	lds   XL,      sprites + (11 * 8) + SP_XPOS
	lds   r21,     sprites + (11 * 8) + SP_COL1
	rjmp  sp8_b_10ren      ; (19)

sp8_b_11act:

	; Sprite 11 renders

	lds   YL,      v_spoff + (10)
	lds   YH,      sprites + (10 * 8) + SP_BANK
	lds   XL,      sprites + (10 * 8) + SP_XPOS
	lds   r21,     sprites + (10 * 8) + SP_COL1

sp8_b_10ren:

	add   YL,      r1      ; (20)
	ldd   ZL,      Y + 0   ; (22)
	icall                  ; (39)
	ldd   ZL,      Y + 1   ; (41)
	icall                  ; (58)
	ldd   ZL,      Y + 2   ; (60)
	icall                  ; (77)

sp8_b_10end:


	; ( 295) Sprites 12/13

	lds   XL,      sprites + (13 * 8) + SP_YPOS
	lds   YL,      sprites + (12 * 8) + SP_YPOS
	sub   XL,      r18
	sub   YL,      r18
	add   XL,      r20
	brcs  sp8_b_12act      ; ( 8 /  9) Sprite 12 has priority over Sprite 13
	add   YL,      r20
	brcs  sp8_b_13act      ; (10 / 11)

	WAIT  YL,      48
	; --- (Display) ---
	out   PIXOUT,  r17     ; ( 354) Next scanline colored border begins
	; -----------------
	WAIT  YL,      17
	rjmp  sp8_b_12end      ; (77)

sp8_b_12act:

	; Sprite 12 renders, Sprite 13 skips

	lds   YL,      v_spoff + (13)
	lds   YH,      sprites + (13 * 8) + SP_BANK
	lds   XL,      sprites + (13 * 8) + SP_XPOS
	lds   r21,     sprites + (13 * 8) + SP_COL1
	rjmp  sp8_b_12ren      ; (19)

sp8_b_13act:

	; Sprite 13 renders

	lds   YL,      v_spoff + (12)
	lds   YH,      sprites + (12 * 8) + SP_BANK
	lds   XL,      sprites + (12 * 8) + SP_XPOS
	lds   r21,     sprites + (12 * 8) + SP_COL1

sp8_b_12ren:

	add   YL,      r1      ; (20)
	ldd   ZL,      Y + 0   ; (22)
	icall                  ; (39)
	ldd   ZL,      Y + 1   ; (41)
	icall                  ; (58)
	; --- (Display) ---
	out   PIXOUT,  r17     ; ( 354) Next scanline colored border begins
	; -----------------
	ldd   ZL,      Y + 2   ; (60)
	icall                  ; (77)

sp8_b_12end:


	; ( 373) Sprites 14/15/(16/17)

	lds   XL,      sprites + (15 * 8) + SP_YPOS
	lds   YL,      sprites + (14 * 8) + SP_YPOS
	sub   XL,      r18
	sub   YL,      r18
	add   XL,      r20
	brcs  sp8_b_14act      ; ( 8 /  9) Sprite 14 has priority over Sprite 15
	add   YL,      r20
	brcs  sp8_b_15act      ; (10 / 11)
	lds   XL,      sprites + (17 * 8) + SP_YPOS
	lds   YL,      sprites + (16 * 8) + SP_YPOS
	sub   XL,      r18
	sub   YL,      r18
	add   XL,      r20
	brcs  sp8_b_16act      ; (18 / 19) Sprite 16 has priority over Sprite 17
	add   YL,      r20
	brcs  sp8_b_17act      ; (20 / 21)

	WAIT  YL,      65
	rjmp  sp8_b_14end      ; (87)

sp8_b_14act:

	; Sprite 14 renders, Sprite 15 skips (16, 17 skips)

	lds   YL,      v_spoff + (15)
	lds   YH,      sprites + (15 * 8) + SP_BANK
	lds   XL,      sprites + (15 * 8) + SP_XPOS
	lds   r21,     sprites + (15 * 8) + SP_COL1
	rjmp  sp8_b_14acc      ; (19)

sp8_b_15act:

	; Sprite 15 renders (16, 17 skips)

	lds   YL,      v_spoff + (14)
	lds   YH,      sprites + (14 * 8) + SP_BANK
	lds   XL,      sprites + (14 * 8) + SP_XPOS
	lds   r21,     sprites + (14 * 8) + SP_COL1

sp8_b_14acc:

	rjmp  .
	rjmp  .
	rjmp  .
	rjmp  .
	rjmp  sp8_b_14ren      ; (29)

sp8_b_16act:

	; Sprite 16 renders, Sprite 17 skips

	lds   YL,      v_spoff + (17)
	lds   YH,      sprites + (17 * 8) + SP_BANK
	lds   XL,      sprites + (17 * 8) + SP_XPOS
	lds   r21,     sprites + (17 * 8) + SP_COL1
	rjmp  sp8_b_14ren      ; (29)

sp8_b_17act:

	; Sprite 17 renders

	lds   YL,      v_spoff + (16)
	lds   YH,      sprites + (16 * 8) + SP_BANK
	lds   XL,      sprites + (16 * 8) + SP_XPOS
	lds   r21,     sprites + (16 * 8) + SP_COL1

sp8_b_14ren:

	add   YL,      r1      ; (30)
	ldd   ZL,      Y + 0   ; (32)
	icall                  ; (49)
	ldd   ZL,      Y + 1   ; (51)
	icall                  ; (68)
	ldd   ZL,      Y + 2   ; (70)
	icall                  ; (87)

sp8_b_14end:


	; ( 460) End

	nop

	; ( 461) Go on to next line

	ldi   ZL,      15
	out   STACKL,  ZL
	pop   r0
	out   PIXOUT,  r0      ; ( 466) Pixel 0
	jmp   m72_graf_scan_b
