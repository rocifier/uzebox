/*
 *  Uzebox Kernel - Mode 72, Sprite mode 7
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
; Video mode 72, Sprite mode 7
;
; 13 x 16 pixels wide 2bpp sprites, no X mirroring
;
; Up to 6 sprites per scanline
;
; Muxed pairs: 0-1, 2-3, 4-5, 6-7, 8-9, 10-11-(12)
;
; Sprite 12 is not displayed where it shares scanline with 10 or 11.
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
m72_sp7_yprep:

	ldi   XL,      lo8(sprites + SP_OFF)
	ldi   XH,      hi8(sprites + SP_OFF)
	ldi   YL,      lo8(sprites + SP_YPOS)
	ldi   YH,      hi8(sprites + SP_YPOS)
	ldi   ZL,      lo8(v_spoff)
	ldi   ZH,      hi8(v_spoff)
	ldi   r18,     20      ; (  7)
sp7_ypr_l:
	ld    r16,     Y
	ld    r17,     X
	sub   r17,     r16
	sub   r17,     r16
	sub   r17,     r16
	sub   r17,     r16
	subi  r17,     4
	st    Z+,      r17
	adiw  YL,      8
	adiw  XL,      8
	dec   r18
	brne  sp7_ypr_l        ; (366)

	in    XH,      STACKH
	ldi   XL,      LB_SPR_A
	ldi   r18,     hi8(pm(m72_sp7_a))
	st    X+,      r18
	ldi   r18,     lo8(pm(m72_sp7_a))
	st    X+,      r18
	ldi   r18,     hi8(pm(m72_sp7_b))
	st    X+,      r18
	ldi   r18,     lo8(pm(m72_sp7_b))
	st    X+,      r18     ; (380)

	WAIT  r18,     16
	ret                    ; (400)



;
; Entry point A
;
m72_sp7_a:

	ldi   ZL,      LB_STACK - 1 ; Back to video stack (at the end of the line buffer)
	out   STACKL,  ZL
	mov   r1,      r18
	lsl   r1
	lsl   r1                    ; 4 x Phys. scanline for offsets
	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))


	; (1639) Preload

	lds   r15,     sprites + ( 2 * 8) + SP_YPOS
	lds   r16,     v_sphgt + ( 2)
	lds   r0,      sprites + ( 3 * 8) + SP_YPOS
	lds   r14,     v_sphgt + ( 3)
	clr   r20

	; (1648) Sprites 0/1

	lds   XL,      sprites + ( 0 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 0)
	sub   XL,      r18
	add   XL,      YL
	lds   XL,      sprites + ( 1 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 1)
	brcs  sp7_a_00act      ; (11 / 12) Sprite 0 has priority over Sprite 1
	sub   XL,      r18
	add   XL,      YL
	brcs  sp7_a_01act      ; (14 / 15)

	WAIT  YL,      35
	; --- (Display) ---
	out   PIXOUT,  r20     ; (1698) Black border
	; -----------------
	WAIT  YL,      53
	rjmp  sp7_a_00end      ; (104)

sp7_a_00act:

	; Sprite 0 renders, Sprite 1 skips

	nop
	lds   YL,      v_spoff + ( 0)
	lds   YH,      sprites + ( 0 * 8) + SP_BANK
	lds   XL,      sprites + ( 0 * 8) + SP_XPOS
	lds   r21,     sprites + ( 0 * 8) + SP_COL1
	lds   r22,     sprites + ( 0 * 8) + SP_COL2
	lds   r23,     sprites + ( 0 * 8) + SP_COL3
	rjmp  sp7_a_00ren      ; (27)

sp7_a_01act:

	; Sprite 1 renders

	lds   YL,      v_spoff + ( 1)
	lds   YH,      sprites + ( 1 * 8) + SP_BANK
	lds   XL,      sprites + ( 1 * 8) + SP_XPOS
	lds   r21,     sprites + ( 1 * 8) + SP_COL1
	lds   r22,     sprites + ( 1 * 8) + SP_COL2
	lds   r23,     sprites + ( 1 * 8) + SP_COL3

sp7_a_00ren:

	add   YL,      r1      ; (28)
	ldd   ZL,      Y + 0   ; (30)
	icall                  ; (47)
	ldd   ZL,      Y + 1   ; (49)
	; --- (Display) ---
	out   PIXOUT,  r20     ; (1698) Black border
	; -----------------
	icall                  ; (66)
	ldd   ZL,      Y + 2   ; (68)
	icall                  ; (85)
	ldd   ZL,      Y + 3   ; (87)
	icall                  ; (104)

sp7_a_00end:


	; (1753) Preload (cycles added from the ---Preload--- entries below)

	; (1763) Sprites 2/3 (-8 cy)

	sub   r15,     r18
	sub   r0,      r18
	add   r15,     r16
	; --- (Preload) ---
	lds   r15,     sprites + ( 4 * 8) + SP_YPOS
	lds   r16,     v_sphgt + ( 4)
	lds   r20,     sprites + ( 5 * 8) + SP_YPOS
	; -----------------
	brcs  sp7_a_02act      ; (11 + 1 / 12 + 1) Sprite 2 has priority over Sprite 3
	add   r0,      r14
	brcs  sp7_a_03act      ; (14 / 15)

	WAIT  YL,      54
	; --- (Preload) ---
	lds   r14,     v_sphgt + ( 5)
	sub   r15,     r18
	sub   r20,     r18
	; --- (Display) ---
	cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
	; -----------------
	WAIT  YL,      34
	rjmp  sp7_a_02end      ; (104)

sp7_a_02act:

	; Sprite 2 renders, Sprite 3 skips

	lds   YL,      v_spoff + ( 2)
	lds   YH,      sprites + ( 2 * 8) + SP_BANK
	lds   XL,      sprites + ( 2 * 8) + SP_XPOS
	lds   r21,     sprites + ( 2 * 8) + SP_COL1
	lds   r22,     sprites + ( 2 * 8) + SP_COL2
	lds   r23,     sprites + ( 2 * 8) + SP_COL3
	rjmp  sp7_a_02ren      ; (27)

sp7_a_03act:

	; Sprite 3 renders

	lds   YL,      v_spoff + ( 3)
	lds   YH,      sprites + ( 3 * 8) + SP_BANK
	lds   XL,      sprites + ( 3 * 8) + SP_XPOS
	lds   r21,     sprites + ( 3 * 8) + SP_COL1
	lds   r22,     sprites + ( 3 * 8) + SP_COL2
	lds   r23,     sprites + ( 3 * 8) + SP_COL3

sp7_a_02ren:

	add   YL,      r1      ; (28)
	ldd   ZL,      Y + 0   ; (30)
	icall                  ; (47)
	ldd   ZL,      Y + 1   ; (49)
	icall                  ; (66)
	ldd   ZL,      Y + 2   ; (68)
	; --- (Preload) ---
	lds   r14,     v_sphgt + ( 5)
	sub   r15,     r18
	sub   r20,     r18
	; --- (Display) ---
	cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
	; -----------------
	icall                  ; (85)
	ldd   ZL,      Y + 3   ; (87)
	icall                  ; (104)

sp7_a_02end:


	; (  41) Sprites 4/5 (-10 cy)

	add   r15,     r16
	brcs  sp7_a_04act      ; (11 + 1 / 12 + 1) Sprite 4 has priority over Sprite 5
	add   r20,     r14
	brcs  sp7_a_05act      ; (14 / 15)

	WAIT  YL,      88
	rjmp  sp7_a_04end      ; (104)

sp7_a_04act:

	; Sprite 4 renders, Sprite 5 skips

	lds   YL,      v_spoff + ( 4)
	lds   YH,      sprites + ( 4 * 8) + SP_BANK
	lds   XL,      sprites + ( 4 * 8) + SP_XPOS
	lds   r21,     sprites + ( 4 * 8) + SP_COL1
	lds   r22,     sprites + ( 4 * 8) + SP_COL2
	lds   r23,     sprites + ( 4 * 8) + SP_COL3
	rjmp  sp7_a_04ren      ; (27)

sp7_a_05act:

	; Sprite 5 renders

	lds   YL,      v_spoff + ( 5)
	lds   YH,      sprites + ( 5 * 8) + SP_BANK
	lds   XL,      sprites + ( 5 * 8) + SP_XPOS
	lds   r21,     sprites + ( 5 * 8) + SP_COL1
	lds   r22,     sprites + ( 5 * 8) + SP_COL2
	lds   r23,     sprites + ( 5 * 8) + SP_COL3

sp7_a_04ren:

	add   YL,      r1      ; (28)
	ldd   ZL,      Y + 0   ; (30)
	icall                  ; (47)
	ldd   ZL,      Y + 1   ; (49)
	icall                  ; (66)
	ldd   ZL,      Y + 2   ; (68)
	icall                  ; (85)
	ldd   ZL,      Y + 3   ; (87)
	icall                  ; (104)

sp7_a_04end:


	; ( 135) Sprites 6/7

	lds   XL,      sprites + ( 6 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 6)
	; --- (Display) ---
	sbi   SYNC,    SYNC_P  ; ( 141) Sync pulse goes high
	; -----------------
	sub   XL,      r18
	add   XL,      YL
	lds   XL,      sprites + ( 7 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 7)
	brcs  sp7_a_06act      ; (11 / 12) Sprite 6 has priority over Sprite 7
	sub   XL,      r18
	add   XL,      YL
	brcs  sp7_a_07act      ; (14 / 15)

	WAIT  YL,      88
	rjmp  sp7_a_06end      ; (104)

sp7_a_06act:

	; Sprite 6 renders, Sprite 7 skips

	nop
	lds   YL,      v_spoff + ( 6)
	lds   YH,      sprites + ( 6 * 8) + SP_BANK
	lds   XL,      sprites + ( 6 * 8) + SP_XPOS
	lds   r21,     sprites + ( 6 * 8) + SP_COL1
	lds   r22,     sprites + ( 6 * 8) + SP_COL2
	lds   r23,     sprites + ( 6 * 8) + SP_COL3
	rjmp  sp7_a_06ren      ; (27)

sp7_a_07act:

	; Sprite 7 renders

	lds   YL,      v_spoff + ( 7)
	lds   YH,      sprites + ( 7 * 8) + SP_BANK
	lds   XL,      sprites + ( 7 * 8) + SP_XPOS
	lds   r21,     sprites + ( 7 * 8) + SP_COL1
	lds   r22,     sprites + ( 7 * 8) + SP_COL2
	lds   r23,     sprites + ( 7 * 8) + SP_COL3

sp7_a_06ren:

	add   YL,      r1      ; (28)
	ldd   ZL,      Y + 0   ; (30)
	icall                  ; (47)
	ldd   ZL,      Y + 1   ; (49)
	icall                  ; (66)
	ldd   ZL,      Y + 2   ; (68)
	icall                  ; (85)
	ldd   ZL,      Y + 3   ; (87)
	icall                  ; (104)

sp7_a_06end:


	; ( 241) Sprites 8/9

	lds   XL,      sprites + ( 8 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 8)
	sub   XL,      r18
	add   XL,      YL
	lds   XL,      sprites + ( 9 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 9)
	brcs  sp7_a_08act      ; (11 / 12) Sprite 8 has priority over Sprite 9
	sub   XL,      r18
	add   XL,      YL
	brcs  sp7_a_09act      ; (14 / 15)

	WAIT  YL,      88
	rjmp  sp7_a_08end      ; (104)

sp7_a_08act:

	; Sprite 8 renders, Sprite 9 skips

	nop
	lds   YL,      v_spoff + ( 8)
	lds   YH,      sprites + ( 8 * 8) + SP_BANK
	lds   XL,      sprites + ( 8 * 8) + SP_XPOS
	lds   r21,     sprites + ( 8 * 8) + SP_COL1
	lds   r22,     sprites + ( 8 * 8) + SP_COL2
	lds   r23,     sprites + ( 8 * 8) + SP_COL3
	rjmp  sp7_a_08ren      ; (27)

sp7_a_09act:

	; Sprite 9 renders

	lds   YL,      v_spoff + ( 9)
	lds   YH,      sprites + ( 9 * 8) + SP_BANK
	lds   XL,      sprites + ( 9 * 8) + SP_XPOS
	lds   r21,     sprites + ( 9 * 8) + SP_COL1
	lds   r22,     sprites + ( 9 * 8) + SP_COL2
	lds   r23,     sprites + ( 9 * 8) + SP_COL3

sp7_a_08ren:

	add   YL,      r1      ; (28)
	ldd   ZL,      Y + 0   ; (30)
	icall                  ; (47)
	ldd   ZL,      Y + 1   ; (49)
	icall                  ; (66)
	ldd   ZL,      Y + 2   ; (68)
	icall                  ; (85)
	ldd   ZL,      Y + 3   ; (87)
	icall                  ; (104)

sp7_a_08end:


	; ( 345) Sprites 10/11

	lds   XL,      sprites + (10 * 8) + SP_YPOS
	lds   YL,      v_sphgt + (10)
	sub   XL,      r18
	add   XL,      YL
	lds   XL,      sprites + (11 * 8) + SP_YPOS
	; --- (Display) ---
	out   PIXOUT,  r17     ; ( 354) Next scanline colored border begins
	; -----------------
	lds   YL,      v_sphgt + (11)
	brcs  sp7_a_10act      ; (11 / 12) Sprite 10 has priority over Sprite 11
	sub   XL,      r18
	add   XL,      YL
	brcs  sp7_a_11act      ; (14 / 15)
	lds   XL,      sprites + (12 * 8) + SP_YPOS
	lds   YL,      v_sphgt + (12)
	sub   XL,      r18
	add   XL,      YL
	brcs  sp7_a_12act      ; (21 / 22)

	WAIT  YL,      88
	rjmp  sp7_a_10end      ; (111)

sp7_a_10act:

	; Sprite 10 renders, Sprite 11 skips

	rjmp  .
	rjmp  .
	rjmp  .
	rjmp  .
	lds   YL,      v_spoff + (10)
	lds   YH,      sprites + (10 * 8) + SP_BANK
	lds   XL,      sprites + (10 * 8) + SP_XPOS
	lds   r21,     sprites + (10 * 8) + SP_COL1
	lds   r22,     sprites + (10 * 8) + SP_COL2
	lds   r23,     sprites + (10 * 8) + SP_COL3
	rjmp  sp7_a_10ren      ; (34)

sp7_a_11act:

	; Sprite 11 renders

	rjmp  .
	rjmp  .
	nop
	lds   YL,      v_spoff + (11)
	lds   YH,      sprites + (11 * 8) + SP_BANK
	lds   XL,      sprites + (11 * 8) + SP_XPOS
	lds   r21,     sprites + (11 * 8) + SP_COL1
	lds   r22,     sprites + (11 * 8) + SP_COL2
	lds   r23,     sprites + (11 * 8) + SP_COL3
	rjmp  sp7_a_10ren      ; (34)

sp7_a_12act:

	; Sprite 12 renders

	lds   YL,      v_spoff + (12)
	lds   YH,      sprites + (12 * 8) + SP_BANK
	lds   XL,      sprites + (12 * 8) + SP_XPOS
	lds   r21,     sprites + (12 * 8) + SP_COL1
	lds   r22,     sprites + (12 * 8) + SP_COL2
	lds   r23,     sprites + (12 * 8) + SP_COL3

sp7_a_10ren:

	add   YL,      r1      ; (35)
	ldd   ZL,      Y + 0   ; (37)
	icall                  ; (54)
	ldd   ZL,      Y + 1   ; (56)
	icall                  ; (73)
	ldd   ZL,      Y + 2   ; (75)
	icall                  ; (92)
	ldd   ZL,      Y + 3   ; (94)
	icall                  ; (111)

sp7_a_10end:


	; ( 457) End

	rjmp  .
	rjmp  .

	; ( 461) Go on to next line

	ldi   ZL,      15
	out   STACKL,  ZL
	pop   r0
	out   PIXOUT,  r0      ; ( 466) Pixel 0
	jmp   m72_graf_scan_b



;
; Entry point B
;
m72_sp7_b:

	ldi   ZL,      LB_STACK - 1 ; Back to video stack (at the end of the line buffer)
	out   STACKL,  ZL
	mov   r1,      r18
	lsl   r1
	lsl   r1                    ; 4 x Phys. scanline for offsets
	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))


	; (1639) Preload

	lds   r15,     sprites + ( 3 * 8) + SP_YPOS
	lds   r16,     v_sphgt + ( 3)
	lds   r0,      sprites + ( 2 * 8) + SP_YPOS
	lds   r14,     v_sphgt + ( 2)
	clr   r20

	; (1648) Sprites 0/1

	lds   XL,      sprites + ( 1 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 1)
	sub   XL,      r18
	add   XL,      YL
	lds   XL,      sprites + ( 0 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 0)
	brcs  sp7_b_00act      ; (11 / 12) Sprite 0 has priority over Sprite 1
	sub   XL,      r18
	add   XL,      YL
	brcs  sp7_b_01act      ; (14 / 15)

	WAIT  YL,      35
	; --- (Display) ---
	out   PIXOUT,  r20     ; (1698) Black border
	; -----------------
	WAIT  YL,      53
	rjmp  sp7_b_00end      ; (104)

sp7_b_00act:

	; Sprite 0 renders, Sprite 1 skips

	nop
	lds   YL,      v_spoff + ( 1)
	lds   YH,      sprites + ( 1 * 8) + SP_BANK
	lds   XL,      sprites + ( 1 * 8) + SP_XPOS
	lds   r21,     sprites + ( 1 * 8) + SP_COL1
	lds   r22,     sprites + ( 1 * 8) + SP_COL2
	lds   r23,     sprites + ( 1 * 8) + SP_COL3
	rjmp  sp7_b_00ren      ; (27)

sp7_b_01act:

	; Sprite 1 renders

	lds   YL,      v_spoff + ( 0)
	lds   YH,      sprites + ( 0 * 8) + SP_BANK
	lds   XL,      sprites + ( 0 * 8) + SP_XPOS
	lds   r21,     sprites + ( 0 * 8) + SP_COL1
	lds   r22,     sprites + ( 0 * 8) + SP_COL2
	lds   r23,     sprites + ( 0 * 8) + SP_COL3

sp7_b_00ren:

	add   YL,      r1      ; (28)
	ldd   ZL,      Y + 0   ; (30)
	icall                  ; (47)
	ldd   ZL,      Y + 1   ; (49)
	; --- (Display) ---
	out   PIXOUT,  r20     ; (1698) Black border
	; -----------------
	icall                  ; (66)
	ldd   ZL,      Y + 2   ; (68)
	icall                  ; (85)
	ldd   ZL,      Y + 3   ; (87)
	icall                  ; (104)

sp7_b_00end:


	; (1753) Preload (cycles added from the ---Preload--- entries below)

	; (1763) Sprites 2/3 (-8 cy)

	sub   r15,     r18
	sub   r0,      r18
	add   r15,     r16
	; --- (Preload) ---
	lds   r15,     sprites + ( 5 * 8) + SP_YPOS
	lds   r16,     v_sphgt + ( 5)
	lds   r20,     sprites + ( 4 * 8) + SP_YPOS
	; -----------------
	brcs  sp7_b_02act      ; (11 + 1 / 12 + 1) Sprite 2 has priority over Sprite 3
	add   r0,      r14
	brcs  sp7_b_03act      ; (14 / 15)

	WAIT  YL,      54
	; --- (Preload) ---
	lds   r14,     v_sphgt + ( 4)
	sub   r15,     r18
	sub   r20,     r18
	; --- (Display) ---
	cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
	; -----------------
	WAIT  YL,      34
	rjmp  sp7_b_02end      ; (104)

sp7_b_02act:

	; Sprite 2 renders, Sprite 3 skips

	lds   YL,      v_spoff + ( 3)
	lds   YH,      sprites + ( 3 * 8) + SP_BANK
	lds   XL,      sprites + ( 3 * 8) + SP_XPOS
	lds   r21,     sprites + ( 3 * 8) + SP_COL1
	lds   r22,     sprites + ( 3 * 8) + SP_COL2
	lds   r23,     sprites + ( 3 * 8) + SP_COL3
	rjmp  sp7_b_02ren      ; (27)

sp7_b_03act:

	; Sprite 3 renders

	lds   YL,      v_spoff + ( 2)
	lds   YH,      sprites + ( 2 * 8) + SP_BANK
	lds   XL,      sprites + ( 2 * 8) + SP_XPOS
	lds   r21,     sprites + ( 2 * 8) + SP_COL1
	lds   r22,     sprites + ( 2 * 8) + SP_COL2
	lds   r23,     sprites + ( 2 * 8) + SP_COL3

sp7_b_02ren:

	add   YL,      r1      ; (28)
	ldd   ZL,      Y + 0   ; (30)
	icall                  ; (47)
	ldd   ZL,      Y + 1   ; (49)
	icall                  ; (66)
	ldd   ZL,      Y + 2   ; (68)
	; --- (Preload) ---
	lds   r14,     v_sphgt + ( 4)
	sub   r15,     r18
	sub   r20,     r18
	; --- (Display) ---
	cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
	; -----------------
	icall                  ; (85)
	ldd   ZL,      Y + 3   ; (87)
	icall                  ; (104)

sp7_b_02end:


	; (  41) Sprites 4/5 (-10 cy)

	add   r15,     r16
	brcs  sp7_b_04act      ; (11 + 1 / 12 + 1) Sprite 4 has priority over Sprite 5
	add   r20,     r14
	brcs  sp7_b_05act      ; (14 / 15)

	WAIT  YL,      88
	rjmp  sp7_b_04end      ; (104)

sp7_b_04act:

	; Sprite 4 renders, Sprite 5 skips

	lds   YL,      v_spoff + ( 5)
	lds   YH,      sprites + ( 5 * 8) + SP_BANK
	lds   XL,      sprites + ( 5 * 8) + SP_XPOS
	lds   r21,     sprites + ( 5 * 8) + SP_COL1
	lds   r22,     sprites + ( 5 * 8) + SP_COL2
	lds   r23,     sprites + ( 5 * 8) + SP_COL3
	rjmp  sp7_b_04ren      ; (27)

sp7_b_05act:

	; Sprite 5 renders

	lds   YL,      v_spoff + ( 4)
	lds   YH,      sprites + ( 4 * 8) + SP_BANK
	lds   XL,      sprites + ( 4 * 8) + SP_XPOS
	lds   r21,     sprites + ( 4 * 8) + SP_COL1
	lds   r22,     sprites + ( 4 * 8) + SP_COL2
	lds   r23,     sprites + ( 4 * 8) + SP_COL3

sp7_b_04ren:

	add   YL,      r1      ; (28)
	ldd   ZL,      Y + 0   ; (30)
	icall                  ; (47)
	ldd   ZL,      Y + 1   ; (49)
	icall                  ; (66)
	ldd   ZL,      Y + 2   ; (68)
	icall                  ; (85)
	ldd   ZL,      Y + 3   ; (87)
	icall                  ; (104)

sp7_b_04end:


	; ( 135) Sprites 6/7

	lds   XL,      sprites + ( 7 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 7)
	; --- (Display) ---
	sbi   SYNC,    SYNC_P  ; ( 141) Sync pulse goes high
	; -----------------
	sub   XL,      r18
	add   XL,      YL
	lds   XL,      sprites + ( 6 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 6)
	brcs  sp7_b_06act      ; (11 / 12) Sprite 6 has priority over Sprite 7
	sub   XL,      r18
	add   XL,      YL
	brcs  sp7_b_07act      ; (14 / 15)

	WAIT  YL,      88
	rjmp  sp7_b_06end      ; (104)

sp7_b_06act:

	; Sprite 6 renders, Sprite 7 skips

	nop
	lds   YL,      v_spoff + ( 7)
	lds   YH,      sprites + ( 7 * 8) + SP_BANK
	lds   XL,      sprites + ( 7 * 8) + SP_XPOS
	lds   r21,     sprites + ( 7 * 8) + SP_COL1
	lds   r22,     sprites + ( 7 * 8) + SP_COL2
	lds   r23,     sprites + ( 7 * 8) + SP_COL3
	rjmp  sp7_b_06ren      ; (27)

sp7_b_07act:

	; Sprite 7 renders

	lds   YL,      v_spoff + ( 6)
	lds   YH,      sprites + ( 6 * 8) + SP_BANK
	lds   XL,      sprites + ( 6 * 8) + SP_XPOS
	lds   r21,     sprites + ( 6 * 8) + SP_COL1
	lds   r22,     sprites + ( 6 * 8) + SP_COL2
	lds   r23,     sprites + ( 6 * 8) + SP_COL3

sp7_b_06ren:

	add   YL,      r1      ; (28)
	ldd   ZL,      Y + 0   ; (30)
	icall                  ; (47)
	ldd   ZL,      Y + 1   ; (49)
	icall                  ; (66)
	ldd   ZL,      Y + 2   ; (68)
	icall                  ; (85)
	ldd   ZL,      Y + 3   ; (87)
	icall                  ; (104)

sp7_b_06end:


	; ( 241) Sprites 8/9

	lds   XL,      sprites + ( 9 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 9)
	sub   XL,      r18
	add   XL,      YL
	lds   XL,      sprites + ( 8 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 8)
	brcs  sp7_b_08act      ; (11 / 12) Sprite 8 has priority over Sprite 9
	sub   XL,      r18
	add   XL,      YL
	brcs  sp7_b_09act      ; (14 / 15)

	WAIT  YL,      88
	rjmp  sp7_b_08end      ; (104)

sp7_b_08act:

	; Sprite 8 renders, Sprite 9 skips

	nop
	lds   YL,      v_spoff + ( 9)
	lds   YH,      sprites + ( 9 * 8) + SP_BANK
	lds   XL,      sprites + ( 9 * 8) + SP_XPOS
	lds   r21,     sprites + ( 9 * 8) + SP_COL1
	lds   r22,     sprites + ( 9 * 8) + SP_COL2
	lds   r23,     sprites + ( 9 * 8) + SP_COL3
	rjmp  sp7_b_08ren      ; (27)

sp7_b_09act:

	; Sprite 9 renders

	lds   YL,      v_spoff + ( 8)
	lds   YH,      sprites + ( 8 * 8) + SP_BANK
	lds   XL,      sprites + ( 8 * 8) + SP_XPOS
	lds   r21,     sprites + ( 8 * 8) + SP_COL1
	lds   r22,     sprites + ( 8 * 8) + SP_COL2
	lds   r23,     sprites + ( 8 * 8) + SP_COL3

sp7_b_08ren:

	add   YL,      r1      ; (28)
	ldd   ZL,      Y + 0   ; (30)
	icall                  ; (47)
	ldd   ZL,      Y + 1   ; (49)
	icall                  ; (66)
	ldd   ZL,      Y + 2   ; (68)
	icall                  ; (85)
	ldd   ZL,      Y + 3   ; (87)
	icall                  ; (104)

sp7_b_08end:


	; ( 345) Sprites 10/11

	lds   XL,      sprites + (11 * 8) + SP_YPOS
	lds   YL,      v_sphgt + (11)
	sub   XL,      r18
	add   XL,      YL
	lds   XL,      sprites + (10 * 8) + SP_YPOS
	; --- (Display) ---
	out   PIXOUT,  r17     ; ( 354) Next scanline colored border begins
	; -----------------
	lds   YL,      v_sphgt + (10)
	brcs  sp7_b_10act      ; (11 / 12) Sprite 10 has priority over Sprite 11
	sub   XL,      r18
	add   XL,      YL
	brcs  sp7_b_11act      ; (14 / 15)
	lds   XL,      sprites + (12 * 8) + SP_YPOS
	lds   YL,      v_sphgt + (12)
	sub   XL,      r18
	add   XL,      YL
	brcs  sp7_b_12act      ; (21 / 22)

	WAIT  YL,      88
	rjmp  sp7_b_10end      ; (111)

sp7_b_10act:

	; Sprite 10 renders, Sprite 11 skips

	rjmp  .
	rjmp  .
	rjmp  .
	rjmp  .
	lds   YL,      v_spoff + (11)
	lds   YH,      sprites + (11 * 8) + SP_BANK
	lds   XL,      sprites + (11 * 8) + SP_XPOS
	lds   r21,     sprites + (11 * 8) + SP_COL1
	lds   r22,     sprites + (11 * 8) + SP_COL2
	lds   r23,     sprites + (11 * 8) + SP_COL3
	rjmp  sp7_a_10ren      ; (34)

sp7_b_11act:

	; Sprite 11 renders

	rjmp  .
	rjmp  .
	nop
	lds   YL,      v_spoff + (10)
	lds   YH,      sprites + (10 * 8) + SP_BANK
	lds   XL,      sprites + (10 * 8) + SP_XPOS
	lds   r21,     sprites + (10 * 8) + SP_COL1
	lds   r22,     sprites + (10 * 8) + SP_COL2
	lds   r23,     sprites + (10 * 8) + SP_COL3
	rjmp  sp7_b_10ren      ; (34)

sp7_b_12act:

	; Sprite 12 renders

	lds   YL,      v_spoff + (12)
	lds   YH,      sprites + (12 * 8) + SP_BANK
	lds   XL,      sprites + (12 * 8) + SP_XPOS
	lds   r21,     sprites + (12 * 8) + SP_COL1
	lds   r22,     sprites + (12 * 8) + SP_COL2
	lds   r23,     sprites + (12 * 8) + SP_COL3

sp7_b_10ren:

	add   YL,      r1      ; (35)
	ldd   ZL,      Y + 0   ; (37)
	icall                  ; (54)
	ldd   ZL,      Y + 1   ; (56)
	icall                  ; (73)
	ldd   ZL,      Y + 2   ; (75)
	icall                  ; (92)
	ldd   ZL,      Y + 3   ; (94)
	icall                  ; (111)

sp7_b_10end:


	; ( 457) End

	rjmp  .
	rjmp  .

	; ( 461) Go on to next line

	ldi   ZL,      15
	out   STACKL,  ZL
	pop   r0
	out   PIXOUT,  r0      ; ( 466) Pixel 0
	jmp   m72_graf_scan_b
