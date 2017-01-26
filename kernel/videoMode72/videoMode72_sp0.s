/*
 *  Uzebox Kernel - Mode 72, Sprite mode 0
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
; Video mode 72, Sprite mode 0
;
; 18 x 8 pixels wide 2bpp sprites
;
; Up to 9 sprites per scanline
;
; Muxed pairs: 0-1, 2-3, 4-5, 6-7, 8-9, 10-11, 12-13, 14-15, 16-17
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
;  r2-r17: Background colors (r17: border)
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
; ldi   ZL,      31
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
m72_sp0_yprep:

	ldi   XL,      lo8(sprites + SP_OFF)
	ldi   XH,      hi8(sprites + SP_OFF)
	ldi   YL,      lo8(sprites + SP_YPOS)
	ldi   YH,      hi8(sprites + SP_YPOS)
	ldi   ZL,      lo8(v_spoff)
	ldi   ZH,      hi8(v_spoff)
	ldi   r18,     20      ; (  7)
sp0_ypr_l:
	ld    r16,     Y
	ld    r17,     X
	sub   r17,     r16
	sub   r17,     r16
	subi  r17,     2
	st    Z+,      r17
	adiw  YL,      8
	adiw  XL,      8
	dec   r18
	brne  sp0_ypr_l        ; (326)

	in    XH,      STACKH
	ldi   XL,      LB_SPR_A
	ldi   r18,     hi8(pm(m72_sp0_a))
	st    X+,      r18
	ldi   r18,     lo8(pm(m72_sp0_a))
	st    X+,      r18
	ldi   r18,     hi8(pm(m72_sp0_b))
	st    X+,      r18
	ldi   r18,     lo8(pm(m72_sp0_b))
	st    X+,      r18     ; (340)

	WAIT  r18,     56
	ret                    ; (400)



;
; Entry point A
;
m72_sp0_a:

	ldi   ZL,      LB_STACK - 1 ; Back to video stack (at the end of the line buffer)
	out   STACKL,  ZL
	rjmp  .
	rjmp  .
	mov   r1,      r18
	lsl   r1               ; 2 x Phys. scanline for offsets


	; (1641) Preload

	lds   r0,      sprites + ( 2 * 8) + SP_YPOS
	clr   r20

	; (1644) Sprites 0/1

	lds   XL,      sprites + ( 0 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 0)
	sub   XL,      r18
	add   XL,      YL
	lds   XL,      sprites + ( 1 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 1)
	brcs  sp0_a_00act      ; (11 / 12) Sprite 0 has priority over Sprite 1
	sub   XL,      r18
	add   XL,      YL
	brcc  sp0_a_01ina      ; (14 / 15)

	; Sprite 1 renders

	lds   YL,      v_spoff + ( 1)
	lds   YH,      sprites + ( 1 * 8) + SP_BANK
	lds   XL,      sprites + ( 1 * 8) + SP_XPOS
	lds   r21,     sprites + ( 1 * 8) + SP_COL1
	lds   r22,     sprites + ( 1 * 8) + SP_COL2
	lds   r23,     sprites + ( 1 * 8) + SP_COL3
	add   YL,      r1      ; (27)
	sbrc  r24,     1       ; (28 / 29)
	rjmp  sp0_a_00mir      ; (30)

sp0_a_00nor:

	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	ldd   ZL,      Y + 0   ; (32)
	icall                  ; (49)
	ldd   ZL,      Y + 1   ; (51)
	rjmp  sp0_a_00mie      ; (53)

sp0_a_01ina:

	WAIT  YL,      38
	; --- (Display) ---
	out   PIXOUT,  r20     ; (1698) Black border
	; -----------------
	WAIT  YL,      15
	rjmp  sp0_a_00end      ; (70)

sp0_a_00act:

	; Sprite 0 renders, Sprite 1 skips

	lds   YL,      v_spoff + ( 0)
	lds   YH,      sprites + ( 0 * 8) + SP_BANK
	lds   XL,      sprites + ( 0 * 8) + SP_XPOS
	lds   r21,     sprites + ( 0 * 8) + SP_COL1
	lds   r22,     sprites + ( 0 * 8) + SP_COL2
	lds   r23,     sprites + ( 0 * 8) + SP_COL3
	add   YL,      r1      ; (25)
	sbrc  r24,     0       ; (26 / 27)
	rjmp  .+2              ; (28)
	rjmp  sp0_a_00nor      ; (29)
	rjmp  sp0_a_00mir      ; (30)

sp0_a_00mir:

	nop
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	ldd   ZL,      Y + 1   ; (34)
	icall                  ; (51)
	ldd   ZL,      Y + 0   ; (53)

sp0_a_00mie:

	; --- (Display) ---
	out   PIXOUT,  r20     ; (1698) Black border
	; -----------------
	icall                  ; (70)

sp0_a_00end:


	; (1715) Sprites 2/3 (-2 cy)

	lds   YL,      v_sphgt + ( 2)
	sub   r0,      r18
	add   r0,      YL
	lds   XL,      sprites + ( 3 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 3)
	brcs  sp0_a_02act      ; (11 / 12) Sprite 2 has priority over Sprite 3
	sub   XL,      r18
	add   XL,      YL
	brcc  sp0_a_03ina      ; (14 / 15)

	; Sprite 3 renders

	lds   YL,      v_spoff + ( 3)
	lds   YH,      sprites + ( 3 * 8) + SP_BANK
	lds   XL,      sprites + ( 3 * 8) + SP_XPOS
	lds   r21,     sprites + ( 3 * 8) + SP_COL1
	lds   r22,     sprites + ( 3 * 8) + SP_COL2
	lds   r23,     sprites + ( 3 * 8) + SP_COL3
	add   YL,      r1      ; (27)
	sbrc  r24,     3       ; (28 / 29)
	rjmp  sp0_a_02mir      ; (30)

sp0_a_02nor:

	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	ldd   ZL,      Y + 0   ; (32)
	icall                  ; (49)
	ldd   ZL,      Y + 1   ; (51)
	rjmp  sp0_a_02mie      ; (53)

sp0_a_03ina:

	WAIT  YL,      53
	rjmp  sp0_a_02end      ; (70)

sp0_a_02act:

	; Sprite 2 renders, Sprite 3 skips

	lds   YL,      v_spoff + ( 2)
	lds   YH,      sprites + ( 2 * 8) + SP_BANK
	lds   XL,      sprites + ( 2 * 8) + SP_XPOS
	lds   r21,     sprites + ( 2 * 8) + SP_COL1
	lds   r22,     sprites + ( 2 * 8) + SP_COL2
	lds   r23,     sprites + ( 2 * 8) + SP_COL3
	add   YL,      r1      ; (25)
	sbrc  r24,     2       ; (26 / 27)
	rjmp  .+2              ; (28)
	rjmp  sp0_a_02nor      ; (29)
	rjmp  sp0_a_02mir      ; (30)

sp0_a_02mir:

	nop
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	ldd   ZL,      Y + 1   ; (34)
	icall                  ; (51)
	ldd   ZL,      Y + 0   ; (53)

sp0_a_02mie:

	icall                  ; (70)

sp0_a_02end:


	; (1783) Preload

	lds   r0,      sprites + ( 6 * 8) + SP_YPOS
	sub   r0,      r18
	lds   r20,     sprites + ( 7 * 8) + SP_YPOS
	sub   r20,     r18
	rjmp  .

	; (1791) Sprites 4/5

	lds   XL,      sprites + ( 4 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 4)
	sub   XL,      r18
	add   XL,      YL
	lds   XL,      sprites + ( 5 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 5)
	brcs  sp0_a_04act      ; (11 / 12) Sprite 4 has priority over Sprite 5
	sub   XL,      r18
	add   XL,      YL
	brcc  sp0_a_05ina      ; (14 / 15)

	; Sprite 5 renders

	lds   YL,      v_spoff + ( 5)
	lds   YH,      sprites + ( 5 * 8) + SP_BANK
	lds   XL,      sprites + ( 5 * 8) + SP_XPOS
	lds   r21,     sprites + ( 5 * 8) + SP_COL1
	lds   r22,     sprites + ( 5 * 8) + SP_COL2
	lds   r23,     sprites + ( 5 * 8) + SP_COL3
	add   YL,      r1      ; (27)
	sbrc  r24,     5       ; (28 / 29)
	rjmp  sp0_a_04mir      ; (30)

sp0_a_04nor:

	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	ldd   ZL,      Y + 0   ; (32)
	; --- (Display) ---
	cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
	; -----------------
	icall                  ; (49)
	ldd   ZL,      Y + 1   ; (51)
	rjmp  sp0_a_04mie      ; (53)

sp0_a_05ina:

	WAIT  YL,      17
	; --- (Display) ---
	cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
	; -----------------
	WAIT  YL,      36
	rjmp  sp0_a_04end      ; (70)

sp0_a_04act:

	; Sprite 4 renders, Sprite 5 skips

	lds   YL,      v_spoff + ( 4)
	lds   YH,      sprites + ( 4 * 8) + SP_BANK
	lds   XL,      sprites + ( 4 * 8) + SP_XPOS
	lds   r21,     sprites + ( 4 * 8) + SP_COL1
	lds   r22,     sprites + ( 4 * 8) + SP_COL2
	lds   r23,     sprites + ( 4 * 8) + SP_COL3
	add   YL,      r1      ; (25)
	sbrc  r24,     4       ; (26 / 27)
	rjmp  .+2              ; (28)
	rjmp  sp0_a_04nor      ; (29)
	rjmp  sp0_a_04mir      ; (30)

sp0_a_04mir:

	nop
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	; --- (Display) ---
	cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
	; -----------------
	ldd   ZL,      Y + 1   ; (34)
	icall                  ; (51)
	ldd   ZL,      Y + 0   ; (53)

sp0_a_04mie:

	icall                  ; (70)

sp0_a_04end:


	; (  43) Sprites 6/7 (-6 cy)

	lds   YL,      v_sphgt + ( 6)
	add   r0,      YL
	lds   YL,      v_sphgt + ( 7)
	brcs  sp0_a_06act      ; (11 + 1 / 12 + 1) Sprite 6 has priority over Sprite 7
	add   r20,     YL
	brcc  sp0_a_07ina      ; (14 / 15)

	; Sprite 7 renders

	lds   YL,      v_spoff + ( 7)
	lds   YH,      sprites + ( 7 * 8) + SP_BANK
	lds   XL,      sprites + ( 7 * 8) + SP_XPOS
	lds   r21,     sprites + ( 7 * 8) + SP_COL1
	lds   r22,     sprites + ( 7 * 8) + SP_COL2
	lds   r23,     sprites + ( 7 * 8) + SP_COL3
	add   YL,      r1      ; (27)
	sbrc  r24,     7       ; (28 / 29)
	rjmp  sp0_a_06mir      ; (30)

sp0_a_06nor:

	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	ldd   ZL,      Y + 0   ; (32)
	icall                  ; (49)
	ldd   ZL,      Y + 1   ; (51)
	rjmp  sp0_a_06mie      ; (53)

sp0_a_07ina:

	WAIT  YL,      53
	rjmp  sp0_a_06end      ; (70)

sp0_a_06act:

	; Sprite 6 renders, Sprite 7 skips

	lds   YL,      v_spoff + ( 6)
	lds   YH,      sprites + ( 6 * 8) + SP_BANK
	lds   XL,      sprites + ( 6 * 8) + SP_XPOS
	lds   r21,     sprites + ( 6 * 8) + SP_COL1
	lds   r22,     sprites + ( 6 * 8) + SP_COL2
	lds   r23,     sprites + ( 6 * 8) + SP_COL3
	add   YL,      r1      ; (25 + 1)
	sbrs  r24,     6       ; (26 + 1 / 27 + 1)
	rjmp  sp0_a_06nor      ; (29)
	rjmp  sp0_a_06mir      ; (30)

sp0_a_06mir:

	nop
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	ldd   ZL,      Y + 1   ; (34)
	icall                  ; (51)
	ldd   ZL,      Y + 0   ; (53)

sp0_a_06mie:

	icall                  ; (70)

sp0_a_06end:


	; ( 107) Sprites 8/9

	lds   XL,      sprites + ( 8 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 8)
	sub   XL,      r18
	add   XL,      YL
	lds   XL,      sprites + ( 9 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 9)
	brcs  sp0_a_08act      ; (11 / 12) Sprite 8 has priority over Sprite 9
	sub   XL,      r18
	add   XL,      YL
	brcc  sp0_a_09ina      ; (14 / 15)

	; Sprite 9 renders

	lds   YL,      v_spoff + ( 9)
	lds   YH,      sprites + ( 9 * 8) + SP_BANK
	lds   XL,      sprites + ( 9 * 8) + SP_XPOS
	lds   r21,     sprites + ( 9 * 8) + SP_COL1
	lds   r22,     sprites + ( 9 * 8) + SP_COL2
	lds   r23,     sprites + ( 9 * 8) + SP_COL3
	add   YL,      r1      ; (27)
	sbrc  r25,     1       ; (28 / 29)
	rjmp  sp0_a_08mir      ; (30)

sp0_a_08nor:

	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	ldd   ZL,      Y + 0   ; (32)
	; --- (Display) ---
	sbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes high
	; -----------------
	icall                  ; (49)
	ldd   ZL,      Y + 1   ; (51)
	rjmp  sp0_a_08mie      ; (53)

sp0_a_09ina:

	WAIT  YL,      17
	; --- (Display) ---
	sbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes high
	; -----------------
	WAIT  YL,      36
	rjmp  sp0_a_08end      ; (70)

sp0_a_08act:

	; Sprite 8 renders, Sprite 9 skips

	lds   YL,      v_spoff + ( 8)
	lds   YH,      sprites + ( 8 * 8) + SP_BANK
	lds   XL,      sprites + ( 8 * 8) + SP_XPOS
	lds   r21,     sprites + ( 8 * 8) + SP_COL1
	lds   r22,     sprites + ( 8 * 8) + SP_COL2
	lds   r23,     sprites + ( 8 * 8) + SP_COL3
	add   YL,      r1      ; (25)
	sbrc  r25,     0       ; (26 / 27)
	rjmp  .+2              ; (28)
	rjmp  sp0_a_08nor      ; (29)
	rjmp  sp0_a_08mir      ; (30)

sp0_a_08mir:

	nop
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	; --- (Display) ---
	sbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes high
	; -----------------
	ldd   ZL,      Y + 1   ; (34)
	icall                  ; (51)
	ldd   ZL,      Y + 0   ; (53)

sp0_a_08mie:

	icall                  ; (70)

sp0_a_08end:


	; ( 179) Sprites 10/11

	lds   XL,      sprites + (10 * 8) + SP_YPOS
	lds   YL,      v_sphgt + (10)
	sub   XL,      r18
	add   XL,      YL
	lds   XL,      sprites + (11 * 8) + SP_YPOS
	lds   YL,      v_sphgt + (11)
	brcs  sp0_a_10act      ; (11 / 12) Sprite 10 has priority over Sprite 11
	sub   XL,      r18
	add   XL,      YL
	brcc  sp0_a_11ina      ; (14 / 15)

	; Sprite 11 renders

	lds   YL,      v_spoff + (11)
	lds   YH,      sprites + (11 * 8) + SP_BANK
	lds   XL,      sprites + (11 * 8) + SP_XPOS
	lds   r21,     sprites + (11 * 8) + SP_COL1
	lds   r22,     sprites + (11 * 8) + SP_COL2
	lds   r23,     sprites + (11 * 8) + SP_COL3
	add   YL,      r1      ; (27)
	sbrc  r25,     3       ; (28 / 29)
	rjmp  sp0_a_10mir      ; (30)

sp0_a_10nor:

	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	ldd   ZL,      Y + 0   ; (32)
	icall                  ; (49)
	ldd   ZL,      Y + 1   ; (51)
	rjmp  sp0_a_10mie      ; (53)

sp0_a_11ina:

	WAIT  YL,      53
	rjmp  sp0_a_10end      ; (70)

sp0_a_10act:

	; Sprite 10 renders, Sprite 11 skips

	lds   YL,      v_spoff + (10)
	lds   YH,      sprites + (10 * 8) + SP_BANK
	lds   XL,      sprites + (10 * 8) + SP_XPOS
	lds   r21,     sprites + (10 * 8) + SP_COL1
	lds   r22,     sprites + (10 * 8) + SP_COL2
	lds   r23,     sprites + (10 * 8) + SP_COL3
	add   YL,      r1      ; (25)
	sbrc  r25,     2       ; (26 / 27)
	rjmp  .+2              ; (28)
	rjmp  sp0_a_10nor      ; (29)
	rjmp  sp0_a_10mir      ; (30)

sp0_a_10mir:

	nop
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	ldd   ZL,      Y + 1   ; (34)
	icall                  ; (51)
	ldd   ZL,      Y + 0   ; (53)

sp0_a_10mie:

	icall                  ; (70)

sp0_a_10end:


	; ( 249) Sprites 12/13

	lds   XL,      sprites + (12 * 8) + SP_YPOS
	lds   YL,      v_sphgt + (12)
	sub   XL,      r18
	add   XL,      YL
	lds   XL,      sprites + (13 * 8) + SP_YPOS
	lds   YL,      v_sphgt + (13)
	brcs  sp0_a_12act      ; (11 / 12) Sprite 12 has priority over Sprite 13
	sub   XL,      r18
	add   XL,      YL
	brcc  sp0_a_13ina      ; (14 / 15)

	; Sprite 13 renders

	lds   YL,      v_spoff + (13)
	lds   YH,      sprites + (13 * 8) + SP_BANK
	lds   XL,      sprites + (13 * 8) + SP_XPOS
	lds   r21,     sprites + (13 * 8) + SP_COL1
	lds   r22,     sprites + (13 * 8) + SP_COL2
	lds   r23,     sprites + (13 * 8) + SP_COL3
	add   YL,      r1      ; (27)
	sbrc  r25,     5       ; (28 / 29)
	rjmp  sp0_a_12mir      ; (30)

sp0_a_12nor:

	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	ldd   ZL,      Y + 0   ; (32)
	icall                  ; (49)
	ldd   ZL,      Y + 1   ; (51)
	rjmp  sp0_a_12mie      ; (53)

sp0_a_13ina:

	WAIT  YL,      53
	rjmp  sp0_a_12end      ; (70)

sp0_a_12act:

	; Sprite 12 renders, Sprite 13 skips

	lds   YL,      v_spoff + (12)
	lds   YH,      sprites + (12 * 8) + SP_BANK
	lds   XL,      sprites + (12 * 8) + SP_XPOS
	lds   r21,     sprites + (12 * 8) + SP_COL1
	lds   r22,     sprites + (12 * 8) + SP_COL2
	lds   r23,     sprites + (12 * 8) + SP_COL3
	add   YL,      r1      ; (25)
	sbrc  r25,     4       ; (26 / 27)
	rjmp  .+2              ; (28)
	rjmp  sp0_a_12nor      ; (29)
	rjmp  sp0_a_12mir      ; (30)

sp0_a_12mir:

	nop
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	ldd   ZL,      Y + 1   ; (34)
	icall                  ; (51)
	ldd   ZL,      Y + 0   ; (53)

sp0_a_12mie:

	icall                  ; (70)

sp0_a_12end:


	; ( 319) Preload

	lds   r0,      sprites + (16 * 8) + SP_YPOS

	; ( 321) Sprites 14/15

	lds   XL,      sprites + (14 * 8) + SP_YPOS
	lds   YL,      v_sphgt + (14)
	sub   XL,      r18
	add   XL,      YL
	lds   XL,      sprites + (15 * 8) + SP_YPOS
	lds   YL,      v_sphgt + (15)
	brcs  sp0_a_14act      ; (11 / 12) Sprite 14 has priority over Sprite 15
	sub   XL,      r18
	add   XL,      YL
	brcc  sp0_a_15ina      ; (14 / 15)

	; Sprite 15 renders

	lds   YL,      v_spoff + (15)
	lds   YH,      sprites + (15 * 8) + SP_BANK
	lds   XL,      sprites + (15 * 8) + SP_XPOS
	lds   r21,     sprites + (15 * 8) + SP_COL1
	lds   r22,     sprites + (15 * 8) + SP_COL2
	lds   r23,     sprites + (15 * 8) + SP_COL3
	add   YL,      r1      ; (27)
	sbrc  r25,     7       ; (28 / 29)
	rjmp  sp0_a_14mir      ; (30)

sp0_a_14nor:

	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	ldd   ZL,      Y + 0   ; (32)
	; --- (Display) ---
	out   PIXOUT,  r17     ; ( 354) Next scanline colored border begins
	; -----------------
	icall                  ; (49)
	ldd   ZL,      Y + 1   ; (51)
	rjmp  sp0_a_14mie      ; (53)

sp0_a_15ina:

	WAIT  YL,      17
	; --- (Display) ---
	out   PIXOUT,  r17     ; ( 354) Next scanline colored border begins
	; -----------------
	WAIT  YL,      36
	rjmp  sp0_a_14end      ; (70)

sp0_a_14act:

	; Sprite 14 renders, Sprite 15 skips

	lds   YL,      v_spoff + (14)
	lds   YH,      sprites + (14 * 8) + SP_BANK
	lds   XL,      sprites + (14 * 8) + SP_XPOS
	lds   r21,     sprites + (14 * 8) + SP_COL1
	lds   r22,     sprites + (14 * 8) + SP_COL2
	lds   r23,     sprites + (14 * 8) + SP_COL3
	add   YL,      r1      ; (25)
	sbrc  r25,     6       ; (26 / 27)
	rjmp  .+2              ; (28)
	rjmp  sp0_a_14nor      ; (29)
	rjmp  sp0_a_14mir      ; (30)

sp0_a_14mir:

	nop
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	; --- (Display) ---
	out   PIXOUT,  r17     ; ( 354) Next scanline colored border begins
	; -----------------
	ldd   ZL,      Y + 1   ; (34)
	icall                  ; (51)
	ldd   ZL,      Y + 0   ; (53)

sp0_a_14mie:

	icall                  ; (70)

sp0_a_14end:


	; ( 392) Sprites 16/17 (-2)

	lds   YL,      v_sphgt + (16)
	sub   r0,      r18
	add   r0,      YL
	lds   XL,      sprites + (17 * 8) + SP_YPOS
	lds   YL,      v_sphgt + (17)
	brcs  sp0_a_16act      ; (11 / 12) Sprite 16 has priority over Sprite 17
	sub   XL,      r18
	add   XL,      YL
	brcc  sp0_a_17ina      ; (14 / 15)

	; Sprite 17 renders

	lds   YL,      v_spoff + (17)
	lds   YH,      sprites + (17 * 8) + SP_BANK
	lds   XL,      sprites + (17 * 8) + SP_XPOS
	lds   r21,     sprites + (17 * 8) + SP_COL1
	lds   r22,     sprites + (17 * 8) + SP_COL2
	lds   r23,     sprites + (17 * 8) + SP_COL3
	add   YL,      r1      ; (27)
	sbic  GPR0,    5       ; (28 / 29)
	rjmp  sp0_a_16mir      ; (30)

sp0_a_16nor:

	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	ldd   ZL,      Y + 0   ; (32)
	icall                  ; (49)
	ldd   ZL,      Y + 1   ; (51)
	rjmp  sp0_a_16mie      ; (53)

sp0_a_17ina:

	WAIT  YL,      53
	rjmp  sp0_a_16end      ; (70)

sp0_a_16act:

	; Sprite 16 renders, Sprite 17 skips

	lds   YL,      v_spoff + (16)
	lds   YH,      sprites + (16 * 8) + SP_BANK
	lds   XL,      sprites + (16 * 8) + SP_XPOS
	lds   r21,     sprites + (16 * 8) + SP_COL1
	lds   r22,     sprites + (16 * 8) + SP_COL2
	lds   r23,     sprites + (16 * 8) + SP_COL3
	add   YL,      r1      ; (25)
	sbic  GPR0,    4       ; (26 / 27)
	rjmp  .+2              ; (28)
	rjmp  sp0_a_16nor      ; (29)
	rjmp  sp0_a_16mir      ; (30)

sp0_a_16mir:

	nop
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	ldd   ZL,      Y + 1   ; (34)
	icall                  ; (51)
	ldd   ZL,      Y + 0   ; (53)

sp0_a_16mie:

	icall                  ; (70)

sp0_a_16end:


	; ( 460) End

	nop

	; ( 461) Go on to next line

	ldi   ZL,      31
	out   STACKL,  ZL
	pop   r0
	out   PIXOUT,  r0      ; ( 466) Pixel 0
	jmp   m72_graf_scan_b



;
; Entry point B
;
m72_sp0_b:

	ldi   ZL,      LB_STACK - 1 ; Back to video stack (at the end of the line buffer)
	out   STACKL,  ZL
	rjmp  .
	rjmp  .
	mov   r1,      r18
	lsl   r1               ; 2 x Phys. scanline for offsets


	; (1641) Preload

	lds   r0,      sprites + ( 3 * 8) + SP_YPOS
	clr   r20

	; (1644) Sprites 0/1

	lds   XL,      sprites + ( 1 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 1)
	sub   XL,      r18
	add   XL,      YL
	lds   XL,      sprites + ( 0 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 0)
	brcs  sp0_b_00act      ; (11 / 12) Sprite 0 has priority over Sprite 1
	sub   XL,      r18
	add   XL,      YL
	brcc  sp0_b_01ina      ; (14 / 15)

	; Sprite 1 renders

	lds   YL,      v_spoff + ( 0)
	lds   YH,      sprites + ( 0 * 8) + SP_BANK
	lds   XL,      sprites + ( 0 * 8) + SP_XPOS
	lds   r21,     sprites + ( 0 * 8) + SP_COL1
	lds   r22,     sprites + ( 0 * 8) + SP_COL2
	lds   r23,     sprites + ( 0 * 8) + SP_COL3
	add   YL,      r1      ; (27)
	sbrc  r24,     0       ; (28 / 29)
	rjmp  sp0_b_00mir      ; (30)

sp0_b_00nor:

	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	ldd   ZL,      Y + 0   ; (32)
	icall                  ; (49)
	ldd   ZL,      Y + 1   ; (51)
	rjmp  sp0_b_00mie      ; (53)

sp0_b_01ina:

	WAIT  YL,      38
	; --- (Display) ---
	out   PIXOUT,  r20     ; (1698) Black border
	; -----------------
	WAIT  YL,      15
	rjmp  sp0_b_00end      ; (70)

sp0_b_00act:

	; Sprite 0 renders, Sprite 1 skips

	lds   YL,      v_spoff + ( 1)
	lds   YH,      sprites + ( 1 * 8) + SP_BANK
	lds   XL,      sprites + ( 1 * 8) + SP_XPOS
	lds   r21,     sprites + ( 1 * 8) + SP_COL1
	lds   r22,     sprites + ( 1 * 8) + SP_COL2
	lds   r23,     sprites + ( 1 * 8) + SP_COL3
	add   YL,      r1      ; (25)
	sbrc  r24,     1       ; (26 / 27)
	rjmp  .+2              ; (28)
	rjmp  sp0_b_00nor      ; (29)
	rjmp  sp0_b_00mir      ; (30)

sp0_b_00mir:

	nop
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	ldd   ZL,      Y + 1   ; (34)
	icall                  ; (51)
	ldd   ZL,      Y + 0   ; (53)

sp0_b_00mie:

	; --- (Display) ---
	out   PIXOUT,  r20     ; (1698) Black border
	; -----------------
	icall                  ; (70)

sp0_b_00end:


	; (1715) Sprites 2/3 (-2 cy)

	lds   YL,      v_sphgt + ( 3)
	sub   r0,      r18
	add   r0,      YL
	lds   XL,      sprites + ( 2 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 2)
	brcs  sp0_b_02act      ; (11 / 12) Sprite 2 has priority over Sprite 3
	sub   XL,      r18
	add   XL,      YL
	brcc  sp0_b_03ina      ; (14 / 15)

	; Sprite 3 renders

	lds   YL,      v_spoff + ( 2)
	lds   YH,      sprites + ( 2 * 8) + SP_BANK
	lds   XL,      sprites + ( 2 * 8) + SP_XPOS
	lds   r21,     sprites + ( 2 * 8) + SP_COL1
	lds   r22,     sprites + ( 2 * 8) + SP_COL2
	lds   r23,     sprites + ( 2 * 8) + SP_COL3
	add   YL,      r1      ; (27)
	sbrc  r24,     2       ; (28 / 29)
	rjmp  sp0_b_02mir      ; (30)

sp0_b_02nor:

	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	ldd   ZL,      Y + 0   ; (32)
	icall                  ; (49)
	ldd   ZL,      Y + 1   ; (51)
	rjmp  sp0_b_02mie      ; (53)

sp0_b_03ina:

	WAIT  YL,      53
	rjmp  sp0_b_02end      ; (70)

sp0_b_02act:

	; Sprite 2 renders, Sprite 3 skips

	lds   YL,      v_spoff + ( 3)
	lds   YH,      sprites + ( 3 * 8) + SP_BANK
	lds   XL,      sprites + ( 3 * 8) + SP_XPOS
	lds   r21,     sprites + ( 3 * 8) + SP_COL1
	lds   r22,     sprites + ( 3 * 8) + SP_COL2
	lds   r23,     sprites + ( 3 * 8) + SP_COL3
	add   YL,      r1      ; (25)
	sbrc  r24,     3       ; (26 / 27)
	rjmp  .+2              ; (28)
	rjmp  sp0_b_02nor      ; (29)
	rjmp  sp0_b_02mir      ; (30)

sp0_b_02mir:

	nop
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	ldd   ZL,      Y + 1   ; (34)
	icall                  ; (51)
	ldd   ZL,      Y + 0   ; (53)

sp0_b_02mie:

	icall                  ; (70)

sp0_b_02end:


	; (1783) Preload

	lds   r0,      sprites + ( 7 * 8) + SP_YPOS
	sub   r0,      r18
	lds   r20,     sprites + ( 6 * 8) + SP_YPOS
	sub   r20,     r18
	rjmp  .

	; (1791) Sprites 4/5

	lds   XL,      sprites + ( 5 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 5)
	sub   XL,      r18
	add   XL,      YL
	lds   XL,      sprites + ( 4 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 4)
	brcs  sp0_b_04act      ; (11 / 12) Sprite 4 has priority over Sprite 5
	sub   XL,      r18
	add   XL,      YL
	brcc  sp0_b_05ina      ; (14 / 15)

	; Sprite 5 renders

	lds   YL,      v_spoff + ( 4)
	lds   YH,      sprites + ( 4 * 8) + SP_BANK
	lds   XL,      sprites + ( 4 * 8) + SP_XPOS
	lds   r21,     sprites + ( 4 * 8) + SP_COL1
	lds   r22,     sprites + ( 4 * 8) + SP_COL2
	lds   r23,     sprites + ( 4 * 8) + SP_COL3
	add   YL,      r1      ; (27)
	sbrc  r24,     4       ; (28 / 29)
	rjmp  sp0_b_04mir      ; (30)

sp0_b_04nor:

	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	ldd   ZL,      Y + 0   ; (32)
	; --- (Display) ---
	cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
	; -----------------
	icall                  ; (49)
	ldd   ZL,      Y + 1   ; (51)
	rjmp  sp0_b_04mie      ; (53)

sp0_b_05ina:

	WAIT  YL,      17
	; --- (Display) ---
	cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
	; -----------------
	WAIT  YL,      36
	rjmp  sp0_b_04end      ; (70)

sp0_b_04act:

	; Sprite 4 renders, Sprite 5 skips

	lds   YL,      v_spoff + ( 5)
	lds   YH,      sprites + ( 5 * 8) + SP_BANK
	lds   XL,      sprites + ( 5 * 8) + SP_XPOS
	lds   r21,     sprites + ( 5 * 8) + SP_COL1
	lds   r22,     sprites + ( 5 * 8) + SP_COL2
	lds   r23,     sprites + ( 5 * 8) + SP_COL3
	add   YL,      r1      ; (25)
	sbrc  r24,     5       ; (26 / 27)
	rjmp  .+2              ; (28)
	rjmp  sp0_b_04nor      ; (29)
	rjmp  sp0_b_04mir      ; (30)

sp0_b_04mir:

	nop
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	; --- (Display) ---
	cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
	; -----------------
	ldd   ZL,      Y + 1   ; (34)
	icall                  ; (51)
	ldd   ZL,      Y + 0   ; (53)

sp0_b_04mie:

	icall                  ; (70)

sp0_b_04end:


	; (  43) Sprites 6/7 (-6 cy)

	lds   YL,      v_sphgt + ( 7)
	add   r0,      YL
	lds   YL,      v_sphgt + ( 6)
	brcs  sp0_b_06act      ; (11 + 1 / 12 + 1) Sprite 6 has priority over Sprite 7
	add   r20,     YL
	brcc  sp0_b_07ina      ; (14 / 15)

	; Sprite 7 renders

	lds   YL,      v_spoff + ( 6)
	lds   YH,      sprites + ( 6 * 8) + SP_BANK
	lds   XL,      sprites + ( 6 * 8) + SP_XPOS
	lds   r21,     sprites + ( 6 * 8) + SP_COL1
	lds   r22,     sprites + ( 6 * 8) + SP_COL2
	lds   r23,     sprites + ( 6 * 8) + SP_COL3
	add   YL,      r1      ; (27)
	sbrc  r24,     6       ; (28 / 29)
	rjmp  sp0_b_06mir      ; (30)

sp0_b_06nor:

	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	ldd   ZL,      Y + 0   ; (32)
	icall                  ; (49)
	ldd   ZL,      Y + 1   ; (51)
	rjmp  sp0_b_06mie      ; (53)

sp0_b_07ina:

	WAIT  YL,      53
	rjmp  sp0_b_06end      ; (70)

sp0_b_06act:

	; Sprite 6 renders, Sprite 7 skips

	lds   YL,      v_spoff + ( 7)
	lds   YH,      sprites + ( 7 * 8) + SP_BANK
	lds   XL,      sprites + ( 7 * 8) + SP_XPOS
	lds   r21,     sprites + ( 7 * 8) + SP_COL1
	lds   r22,     sprites + ( 7 * 8) + SP_COL2
	lds   r23,     sprites + ( 7 * 8) + SP_COL3
	add   YL,      r1      ; (25 + 1)
	sbrs  r24,     7       ; (26 + 1 / 27 + 1)
	rjmp  sp0_b_06nor      ; (29)
	rjmp  sp0_b_06mir      ; (30)

sp0_b_06mir:

	nop
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	ldd   ZL,      Y + 1   ; (34)
	icall                  ; (51)
	ldd   ZL,      Y + 0   ; (53)

sp0_b_06mie:

	icall                  ; (70)

sp0_b_06end:


	; ( 107) Sprites 8/9

	lds   XL,      sprites + ( 9 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 9)
	sub   XL,      r18
	add   XL,      YL
	lds   XL,      sprites + ( 8 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 8)
	brcs  sp0_b_08act      ; (11 / 12) Sprite 8 has priority over Sprite 9
	sub   XL,      r18
	add   XL,      YL
	brcc  sp0_b_09ina      ; (14 / 15)

	; Sprite 9 renders

	lds   YL,      v_spoff + ( 8)
	lds   YH,      sprites + ( 8 * 8) + SP_BANK
	lds   XL,      sprites + ( 8 * 8) + SP_XPOS
	lds   r21,     sprites + ( 8 * 8) + SP_COL1
	lds   r22,     sprites + ( 8 * 8) + SP_COL2
	lds   r23,     sprites + ( 8 * 8) + SP_COL3
	add   YL,      r1      ; (27)
	sbrc  r25,     0       ; (28 / 29)
	rjmp  sp0_b_08mir      ; (30)

sp0_b_08nor:

	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	ldd   ZL,      Y + 0   ; (32)
	; --- (Display) ---
	sbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes high
	; -----------------
	icall                  ; (49)
	ldd   ZL,      Y + 1   ; (51)
	rjmp  sp0_b_08mie      ; (53)

sp0_b_09ina:

	WAIT  YL,      17
	; --- (Display) ---
	sbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes high
	; -----------------
	WAIT  YL,      36
	rjmp  sp0_b_08end      ; (70)

sp0_b_08act:

	; Sprite 8 renders, Sprite 9 skips

	lds   YL,      v_spoff + ( 9)
	lds   YH,      sprites + ( 9 * 8) + SP_BANK
	lds   XL,      sprites + ( 9 * 8) + SP_XPOS
	lds   r21,     sprites + ( 9 * 8) + SP_COL1
	lds   r22,     sprites + ( 9 * 8) + SP_COL2
	lds   r23,     sprites + ( 9 * 8) + SP_COL3
	add   YL,      r1      ; (25)
	sbrc  r25,     1       ; (26 / 27)
	rjmp  .+2              ; (28)
	rjmp  sp0_b_08nor      ; (29)
	rjmp  sp0_b_08mir      ; (30)

sp0_b_08mir:

	nop
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	; --- (Display) ---
	sbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes high
	; -----------------
	ldd   ZL,      Y + 1   ; (34)
	icall                  ; (51)
	ldd   ZL,      Y + 0   ; (53)

sp0_b_08mie:

	icall                  ; (70)

sp0_b_08end:


	; ( 179) Sprites 10/11

	lds   XL,      sprites + (11 * 8) + SP_YPOS
	lds   YL,      v_sphgt + (11)
	sub   XL,      r18
	add   XL,      YL
	lds   XL,      sprites + (10 * 8) + SP_YPOS
	lds   YL,      v_sphgt + (10)
	brcs  sp0_b_10act      ; (11 / 12) Sprite 10 has priority over Sprite 11
	sub   XL,      r18
	add   XL,      YL
	brcc  sp0_b_11ina      ; (14 / 15)

	; Sprite 11 renders

	lds   YL,      v_spoff + (10)
	lds   YH,      sprites + (10 * 8) + SP_BANK
	lds   XL,      sprites + (10 * 8) + SP_XPOS
	lds   r21,     sprites + (10 * 8) + SP_COL1
	lds   r22,     sprites + (10 * 8) + SP_COL2
	lds   r23,     sprites + (10 * 8) + SP_COL3
	add   YL,      r1      ; (27)
	sbrc  r25,     2       ; (28 / 29)
	rjmp  sp0_b_10mir      ; (30)

sp0_b_10nor:

	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	ldd   ZL,      Y + 0   ; (32)
	icall                  ; (49)
	ldd   ZL,      Y + 1   ; (51)
	rjmp  sp0_b_10mie      ; (53)

sp0_b_11ina:

	WAIT  YL,      53
	rjmp  sp0_b_10end      ; (70)

sp0_b_10act:

	; Sprite 10 renders, Sprite 11 skips

	lds   YL,      v_spoff + (11)
	lds   YH,      sprites + (11 * 8) + SP_BANK
	lds   XL,      sprites + (11 * 8) + SP_XPOS
	lds   r21,     sprites + (11 * 8) + SP_COL1
	lds   r22,     sprites + (11 * 8) + SP_COL2
	lds   r23,     sprites + (11 * 8) + SP_COL3
	add   YL,      r1      ; (25)
	sbrc  r25,     3       ; (26 / 27)
	rjmp  .+2              ; (28)
	rjmp  sp0_b_10nor      ; (29)
	rjmp  sp0_b_10mir      ; (30)

sp0_b_10mir:

	nop
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	ldd   ZL,      Y + 1   ; (34)
	icall                  ; (51)
	ldd   ZL,      Y + 0   ; (53)

sp0_b_10mie:

	icall                  ; (70)

sp0_b_10end:


	; ( 249) Sprites 12/13

	lds   XL,      sprites + (13 * 8) + SP_YPOS
	lds   YL,      v_sphgt + (13)
	sub   XL,      r18
	add   XL,      YL
	lds   XL,      sprites + (12 * 8) + SP_YPOS
	lds   YL,      v_sphgt + (12)
	brcs  sp0_b_12act      ; (11 / 12) Sprite 12 has priority over Sprite 13
	sub   XL,      r18
	add   XL,      YL
	brcc  sp0_b_13ina      ; (14 / 15)

	; Sprite 13 renders

	lds   YL,      v_spoff + (12)
	lds   YH,      sprites + (12 * 8) + SP_BANK
	lds   XL,      sprites + (12 * 8) + SP_XPOS
	lds   r21,     sprites + (12 * 8) + SP_COL1
	lds   r22,     sprites + (12 * 8) + SP_COL2
	lds   r23,     sprites + (12 * 8) + SP_COL3
	add   YL,      r1      ; (27)
	sbrc  r25,     4       ; (28 / 29)
	rjmp  sp0_b_12mir      ; (30)

sp0_b_12nor:

	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	ldd   ZL,      Y + 0   ; (32)
	icall                  ; (49)
	ldd   ZL,      Y + 1   ; (51)
	rjmp  sp0_b_12mie      ; (53)

sp0_b_13ina:

	WAIT  YL,      53
	rjmp  sp0_b_12end      ; (70)

sp0_b_12act:

	; Sprite 12 renders, Sprite 13 skips

	lds   YL,      v_spoff + (13)
	lds   YH,      sprites + (13 * 8) + SP_BANK
	lds   XL,      sprites + (13 * 8) + SP_XPOS
	lds   r21,     sprites + (13 * 8) + SP_COL1
	lds   r22,     sprites + (13 * 8) + SP_COL2
	lds   r23,     sprites + (13 * 8) + SP_COL3
	add   YL,      r1      ; (25)
	sbrc  r25,     5       ; (26 / 27)
	rjmp  .+2              ; (28)
	rjmp  sp0_b_12nor      ; (29)
	rjmp  sp0_b_12mir      ; (30)

sp0_b_12mir:

	nop
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	ldd   ZL,      Y + 1   ; (34)
	icall                  ; (51)
	ldd   ZL,      Y + 0   ; (53)

sp0_b_12mie:

	icall                  ; (70)

sp0_b_12end:


	; ( 319) Preload

	lds   r0,      sprites + (17 * 8) + SP_YPOS

	; ( 321) Sprites 14/15

	lds   XL,      sprites + (15 * 8) + SP_YPOS
	lds   YL,      v_sphgt + (15)
	sub   XL,      r18
	add   XL,      YL
	lds   XL,      sprites + (14 * 8) + SP_YPOS
	lds   YL,      v_sphgt + (14)
	brcs  sp0_b_14act      ; (11 / 12) Sprite 14 has priority over Sprite 15
	sub   XL,      r18
	add   XL,      YL
	brcc  sp0_b_15ina      ; (14 / 15)

	; Sprite 15 renders

	lds   YL,      v_spoff + (14)
	lds   YH,      sprites + (14 * 8) + SP_BANK
	lds   XL,      sprites + (14 * 8) + SP_XPOS
	lds   r21,     sprites + (14 * 8) + SP_COL1
	lds   r22,     sprites + (14 * 8) + SP_COL2
	lds   r23,     sprites + (14 * 8) + SP_COL3
	add   YL,      r1      ; (27)
	sbrc  r25,     6       ; (28 / 29)
	rjmp  sp0_b_14mir      ; (30)

sp0_b_14nor:

	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	ldd   ZL,      Y + 0   ; (32)
	; --- (Display) ---
	out   PIXOUT,  r17     ; ( 354) Next scanline colored border begins
	; -----------------
	icall                  ; (49)
	ldd   ZL,      Y + 1   ; (51)
	rjmp  sp0_b_14mie      ; (53)

sp0_b_15ina:

	WAIT  YL,      17
	; --- (Display) ---
	out   PIXOUT,  r17     ; ( 354) Next scanline colored border begins
	; -----------------
	WAIT  YL,      36
	rjmp  sp0_b_14end      ; (70)

sp0_b_14act:

	; Sprite 14 renders, Sprite 15 skips

	lds   YL,      v_spoff + (15)
	lds   YH,      sprites + (15 * 8) + SP_BANK
	lds   XL,      sprites + (15 * 8) + SP_XPOS
	lds   r21,     sprites + (15 * 8) + SP_COL1
	lds   r22,     sprites + (15 * 8) + SP_COL2
	lds   r23,     sprites + (15 * 8) + SP_COL3
	add   YL,      r1      ; (25)
	sbrc  r25,     7       ; (26 / 27)
	rjmp  .+2              ; (28)
	rjmp  sp0_b_14nor      ; (29)
	rjmp  sp0_b_14mir      ; (30)

sp0_b_14mir:

	nop
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	; --- (Display) ---
	out   PIXOUT,  r17     ; ( 354) Next scanline colored border begins
	; -----------------
	ldd   ZL,      Y + 1   ; (34)
	icall                  ; (51)
	ldd   ZL,      Y + 0   ; (53)

sp0_b_14mie:

	icall                  ; (70)

sp0_b_14end:


	; ( 392) Sprites 16/17 (-2)

	lds   YL,      v_sphgt + (17)
	sub   r0,      r18
	add   r0,      YL
	lds   XL,      sprites + (16 * 8) + SP_YPOS
	lds   YL,      v_sphgt + (16)
	brcs  sp0_b_16act      ; (11 / 12) Sprite 16 has priority over Sprite 17
	sub   XL,      r18
	add   XL,      YL
	brcc  sp0_b_17ina      ; (14 / 15)

	; Sprite 17 renders

	lds   YL,      v_spoff + (16)
	lds   YH,      sprites + (16 * 8) + SP_BANK
	lds   XL,      sprites + (16 * 8) + SP_XPOS
	lds   r21,     sprites + (16 * 8) + SP_COL1
	lds   r22,     sprites + (16 * 8) + SP_COL2
	lds   r23,     sprites + (16 * 8) + SP_COL3
	add   YL,      r1      ; (27)
	sbic  GPR0,    4       ; (28 / 29)
	rjmp  sp0_b_16mir      ; (30)

sp0_b_16nor:

	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	ldd   ZL,      Y + 0   ; (32)
	icall                  ; (49)
	ldd   ZL,      Y + 1   ; (51)
	rjmp  sp0_b_16mie      ; (53)

sp0_b_17ina:

	WAIT  YL,      53
	rjmp  sp0_b_16end      ; (70)

sp0_b_16act:

	; Sprite 16 renders, Sprite 17 skips

	lds   YL,      v_spoff + (17)
	lds   YH,      sprites + (17 * 8) + SP_BANK
	lds   XL,      sprites + (17 * 8) + SP_XPOS
	lds   r21,     sprites + (17 * 8) + SP_COL1
	lds   r22,     sprites + (17 * 8) + SP_COL2
	lds   r23,     sprites + (17 * 8) + SP_COL3
	add   YL,      r1      ; (25)
	sbic  GPR0,    5       ; (26 / 27)
	rjmp  .+2              ; (28)
	rjmp  sp0_b_16nor      ; (29)
	rjmp  sp0_b_16mir      ; (30)

sp0_b_16mir:

	nop
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	ldd   ZL,      Y + 1   ; (34)
	icall                  ; (51)
	ldd   ZL,      Y + 0   ; (53)

sp0_b_16mie:

	icall                  ; (70)

sp0_b_16end:


	; ( 460) End

	nop

	; ( 461) Go on to next line

	ldi   ZL,      31
	out   STACKL,  ZL
	pop   r0
	out   PIXOUT,  r0      ; ( 466) Pixel 0
	jmp   m72_graf_scan_b
