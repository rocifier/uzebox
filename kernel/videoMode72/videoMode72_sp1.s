/*
 *  Uzebox Kernel - Mode 72, Sprite mode 1
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
; Video mode 72, Sprite mode 1
;
; 14 x 12 pixels wide 2bpp sprites
;
; Up to 7 sprites per scanline
;
; Muxed pairs: 0-1, 2-3, 4-5, 6-7, 8-9, 10-11, 12-13
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
m72_sp1_yprep:

	ldi   XL,      lo8(sprites + SP_OFF)
	ldi   XH,      hi8(sprites + SP_OFF)
	ldi   YL,      lo8(sprites + SP_YPOS)
	ldi   YH,      hi8(sprites + SP_YPOS)
	ldi   ZL,      lo8(v_spoff)
	ldi   ZH,      hi8(v_spoff)
	ldi   r18,     20      ; (  7)
sp1_ypr_l:
	ld    r16,     Y
	ld    r17,     X
	sub   r17,     r16
	sub   r17,     r16
	sub   r17,     r16
	subi  r17,     3
	st    Z+,      r17
	adiw  YL,      8
	adiw  XL,      8
	dec   r18
	brne  sp1_ypr_l        ; (346)

	in    XH,      STACKH
	ldi   XL,      LB_SPR_A
	ldi   r18,     hi8(pm(m72_sp1_a))
	st    X+,      r18
	ldi   r18,     lo8(pm(m72_sp1_a))
	st    X+,      r18
	ldi   r18,     hi8(pm(m72_sp1_b))
	st    X+,      r18
	ldi   r18,     lo8(pm(m72_sp1_b))
	st    X+,      r18     ; (360)

	WAIT  r18,     36
	ret                    ; (400)



;
; Entry point A
;
; Uses r15 & r16 which it reloads from palette + 13 & 14 upon return
;
m72_sp1_a:

	ldi   ZL,      LB_STACK - 1 ; Back to video stack (at the end of the line buffer)
	out   STACKL,  ZL
	mov   r1,      r18
	lsl   r1
	add   r1,      r18          ; 3 x Phys. scanline for offsets


	; (1638) Preload

	lds   r15,     sprites + ( 2 * 8) + SP_YPOS
	lds   r16,     v_sphgt + ( 2)
	sub   r15,     r18
	lds   r0,      sprites + ( 3 * 8) + SP_YPOS
	clr   r20

	; (1646) Sprites 0/1

	lds   XL,      sprites + ( 0 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 0)
	sub   XL,      r18
	add   XL,      YL
	lds   XL,      sprites + ( 1 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 1)
	brcs  sp1_a_00act      ; (11 / 12) Sprite 0 has priority over Sprite 1
	sub   XL,      r18
	add   XL,      YL
	brcc  sp1_a_01ina      ; (14 / 15)

	; Sprite 1 renders

	lds   YL,      v_spoff + ( 1)
	lds   YH,      sprites + ( 1 * 8) + SP_BANK
	lds   XL,      sprites + ( 1 * 8) + SP_XPOS
	lds   r21,     sprites + ( 1 * 8) + SP_COL1
	lds   r22,     sprites + ( 1 * 8) + SP_COL2
	lds   r23,     sprites + ( 1 * 8) + SP_COL3
	add   YL,      r1      ; (27)
	sbrc  r24,     1       ; (28 / 29)
	rjmp  sp1_a_00mir      ; (30)

sp1_a_00nor:

	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	ldd   ZL,      Y + 0   ; (32)
	icall                  ; (49)
	ldd   ZL,      Y + 1   ; (51)
	; --- (Display) ---
	out   PIXOUT,  r20     ; (1698) Black border
	; -----------------
	icall                  ; (68)
	ldd   ZL,      Y + 2   ; (70)
	rjmp  sp1_a_00mie      ; (72)

sp1_a_01ina:

	WAIT  YL,      36
	; --- (Display) ---
	out   PIXOUT,  r20     ; (1698) Black border
	; -----------------
	WAIT  YL,      36
	rjmp  sp1_a_00end      ; (89)

sp1_a_00act:

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
	rjmp  sp1_a_00nor      ; (29)
	rjmp  sp1_a_00mir      ; (30)

sp1_a_00mir:

	nop
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	ldd   ZL,      Y + 2   ; (34)
	icall                  ; (51)
	; --- (Display) ---
	out   PIXOUT,  r20     ; (1698) Black border
	; -----------------
	ldd   ZL,      Y + 1   ; (53)
	icall                  ; (70)
	ldd   ZL,      Y + 0   ; (72)

sp1_a_00mie:

	icall                  ; (89)

sp1_a_00end:


	; (1736) Sprites 2/3 (-7 cy)

	add   r15,     r16
	lds   YL,      v_sphgt + ( 3)
	brcs  sp1_a_02act      ; (11 / 12) Sprite 2 has priority over Sprite 3
	sub   r0,      r18
	add   r0,      YL
	brcc  sp1_a_03ina      ; (14 / 15)

	; Sprite 3 renders

	lds   YL,      v_spoff + ( 3)
	lds   YH,      sprites + ( 3 * 8) + SP_BANK
	lds   XL,      sprites + ( 3 * 8) + SP_XPOS
	lds   r21,     sprites + ( 3 * 8) + SP_COL1
	lds   r22,     sprites + ( 3 * 8) + SP_COL2
	lds   r23,     sprites + ( 3 * 8) + SP_COL3
	add   YL,      r1      ; (27)
	sbrc  r24,     3       ; (28 / 29)
	rjmp  sp1_a_02mir      ; (30)

sp1_a_02nor:

	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	ldd   ZL,      Y + 0   ; (32)
	icall                  ; (49)
	ldd   ZL,      Y + 1   ; (51)
	icall                  ; (68)
	ldd   ZL,      Y + 2   ; (70)
	rjmp  sp1_a_02mie      ; (72)

sp1_a_03ina:

	WAIT  YL,      72
	rjmp  sp1_a_02end      ; (89)

sp1_a_02act:

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
	rjmp  sp1_a_02nor      ; (29)
	rjmp  sp1_a_02mir      ; (30)

sp1_a_02mir:

	nop
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	ldd   ZL,      Y + 2   ; (34)
	icall                  ; (51)
	ldd   ZL,      Y + 1   ; (53)
	icall                  ; (70)
	ldd   ZL,      Y + 0   ; (72)

sp1_a_02mie:

	icall                  ; (89)

sp1_a_02end:


	; (1818) Sprites 4/5

	lds   XL,      sprites + ( 4 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 4)
	sub   XL,      r18
	; --- (Display) ---
	cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
	; -----------------
	add   XL,      YL
	lds   XL,      sprites + ( 5 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 5)
	brcs  sp1_a_04act      ; (11 / 12) Sprite 4 has priority over Sprite 5
	sub   XL,      r18
	add   XL,      YL
	brcc  sp1_a_05ina      ; (14 / 15)

	; Sprite 5 renders

	lds   YL,      v_spoff + ( 5)
	lds   YH,      sprites + ( 5 * 8) + SP_BANK
	lds   XL,      sprites + ( 5 * 8) + SP_XPOS
	lds   r21,     sprites + ( 5 * 8) + SP_COL1
	lds   r22,     sprites + ( 5 * 8) + SP_COL2
	lds   r23,     sprites + ( 5 * 8) + SP_COL3
	add   YL,      r1      ; (27)
	sbrc  r24,     5       ; (28 / 29)
	rjmp  sp1_a_04mir      ; (30)

sp1_a_04nor:

	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	ldd   ZL,      Y + 0   ; (32)
	icall                  ; (49)
	ldd   ZL,      Y + 1   ; (51)
	icall                  ; (68)
	ldd   ZL,      Y + 2   ; (70)
	rjmp  sp1_a_04mie      ; (72)

sp1_a_05ina:

	WAIT  YL,      72
	rjmp  sp1_a_04end      ; (89)

sp1_a_04act:

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
	rjmp  sp1_a_04nor      ; (29)
	rjmp  sp1_a_04mir      ; (30)

sp1_a_04mir:

	nop
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	ldd   ZL,      Y + 2   ; (34)
	icall                  ; (51)
	ldd   ZL,      Y + 1   ; (53)
	icall                  ; (70)
	ldd   ZL,      Y + 0   ; (72)

sp1_a_04mie:

	icall                  ; (89)

sp1_a_04end:


	; (  89) Sprites 6/7

	lds   XL,      sprites + ( 6 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 6)
	sub   XL,      r18
	add   XL,      YL
	lds   XL,      sprites + ( 7 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 7)
	brcs  sp1_a_06act      ; (11 / 12) Sprite 6 has priority over Sprite 7
	sub   XL,      r18
	add   XL,      YL
	brcc  sp1_a_07ina      ; (14 / 15)

	; Sprite 7 renders

	lds   YL,      v_spoff + ( 7)
	lds   YH,      sprites + ( 7 * 8) + SP_BANK
	lds   XL,      sprites + ( 7 * 8) + SP_XPOS
	lds   r21,     sprites + ( 7 * 8) + SP_COL1
	lds   r22,     sprites + ( 7 * 8) + SP_COL2
	lds   r23,     sprites + ( 7 * 8) + SP_COL3
	add   YL,      r1      ; (27)
	sbrc  r24,     7       ; (28 / 29)
	rjmp  sp1_a_06mir      ; (30)

sp1_a_06nor:

	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	ldd   ZL,      Y + 0   ; (32)
	icall                  ; (49)
	; --- (Display) ---
	nop
	sbi   SYNC,    SYNC_P  ; ( 141) Sync pulse goes high
	; -----------------
	ldd   ZL,      Y + 1   ; (51)
	icall                  ; (68)
	ldd   ZL,      Y + 2   ; (70)
	rjmp  sp1_a_06mie      ; (72)

sp1_a_07ina:

	WAIT  YL,      34
	; --- (Display) ---
	nop
	sbi   SYNC,    SYNC_P  ; ( 141) Sync pulse goes high
	; -----------------
	WAIT  YL,      38
	rjmp  sp1_a_06end      ; (89)

sp1_a_06act:

	; Sprite 6 renders, Sprite 7 skips

	lds   YL,      v_spoff + ( 6)
	lds   YH,      sprites + ( 6 * 8) + SP_BANK
	lds   XL,      sprites + ( 6 * 8) + SP_XPOS
	lds   r21,     sprites + ( 6 * 8) + SP_COL1
	lds   r22,     sprites + ( 6 * 8) + SP_COL2
	lds   r23,     sprites + ( 6 * 8) + SP_COL3
	add   YL,      r1      ; (25)
	sbrc  r24,     6       ; (26 / 27)
	rjmp  .+2              ; (28)
	rjmp  sp1_a_06nor      ; (29)
	rjmp  sp1_a_06mir      ; (30)

sp1_a_06mir:

	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	ldd   ZL,      Y + 2   ; (34 - 1)
	icall                  ; (51 - 1)
	; --- (Display) ---
	sbi   SYNC,    SYNC_P  ; ( 141) Sync pulse goes high
	nop
	; -----------------
	nop
	ldd   ZL,      Y + 1   ; (53)
	icall                  ; (70)
	ldd   ZL,      Y + 0   ; (72)

sp1_a_06mie:

	icall                  ; (89)

sp1_a_06end:


	; ( 181) Sprites 8/9

	lds   XL,      sprites + ( 8 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 8)
	sub   XL,      r18
	add   XL,      YL
	lds   XL,      sprites + ( 9 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 9)
	brcs  sp1_a_08act      ; (11 / 12) Sprite 8 has priority over Sprite 9
	sub   XL,      r18
	add   XL,      YL
	brcc  sp1_a_09ina      ; (14 / 15)

	; Sprite 9 renders

	lds   YL,      v_spoff + ( 9)
	lds   YH,      sprites + ( 9 * 8) + SP_BANK
	lds   XL,      sprites + ( 9 * 8) + SP_XPOS
	lds   r21,     sprites + ( 9 * 8) + SP_COL1
	lds   r22,     sprites + ( 9 * 8) + SP_COL2
	lds   r23,     sprites + ( 9 * 8) + SP_COL3
	add   YL,      r1      ; (27)
	sbrc  r25,     1       ; (28 / 29)
	rjmp  sp1_a_08mir      ; (30)

sp1_a_08nor:

	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	ldd   ZL,      Y + 0   ; (32)
	icall                  ; (49)
	ldd   ZL,      Y + 1   ; (51)
	icall                  ; (68)
	ldd   ZL,      Y + 2   ; (70)
	rjmp  sp1_a_08mie      ; (72)

sp1_a_09ina:

	WAIT  YL,      72
	rjmp  sp1_a_08end      ; (89)

sp1_a_08act:

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
	rjmp  sp1_a_08nor      ; (29)
	rjmp  sp1_a_08mir      ; (30)

sp1_a_08mir:

	nop
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	ldd   ZL,      Y + 2   ; (34)
	icall                  ; (51)
	ldd   ZL,      Y + 1   ; (53)
	icall                  ; (70)
	ldd   ZL,      Y + 0   ; (72)

sp1_a_08mie:

	icall                  ; (89)

sp1_a_08end:


	; ( 270) Preload

	lds   r15,     sprites + (12 * 8) + SP_YPOS
	lds   r16,     v_sphgt + (12)
	sub   r15,     r18
	lds   r0,      sprites + (13 * 8) + SP_YPOS
	lds   r20,     v_sphgt + (13)
	sub   r0,      r18
	nop

	; ( 281) Sprites 10/11

	lds   XL,      sprites + (10 * 8) + SP_YPOS
	lds   YL,      v_sphgt + (10)
	sub   XL,      r18
	add   XL,      YL
	lds   XL,      sprites + (11 * 8) + SP_YPOS
	lds   YL,      v_sphgt + (11)
	brcs  sp1_a_10act      ; (11 / 12) Sprite 10 has priority over Sprite 11
	sub   XL,      r18
	add   XL,      YL
	brcc  sp1_a_11ina      ; (14 / 15)

	; Sprite 11 renders

	lds   YL,      v_spoff + (11)
	lds   YH,      sprites + (11 * 8) + SP_BANK
	lds   XL,      sprites + (11 * 8) + SP_XPOS
	lds   r21,     sprites + (11 * 8) + SP_COL1
	lds   r22,     sprites + (11 * 8) + SP_COL2
	lds   r23,     sprites + (11 * 8) + SP_COL3
	add   YL,      r1      ; (27)
	sbrc  r25,     3       ; (28 / 29)
	rjmp  sp1_a_10mir      ; (30)

sp1_a_10nor:

	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	ldd   ZL,      Y + 0   ; (32)
	icall                  ; (49)
	ldd   ZL,      Y + 1   ; (51)
	icall                  ; (68)
	ldd   ZL,      Y + 2   ; (70)
	rjmp  sp1_a_10mie      ; (72)

sp1_a_11ina:

	WAIT  YL,      57
	; --- (Display) ---
	out   PIXOUT,  r17     ; ( 354) Next scanline colored border begins
	; -----------------
	WAIT  YL,      15
	rjmp  sp1_a_10end      ; (89)

sp1_a_10act:

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
	rjmp  sp1_a_10nor      ; (29)
	rjmp  sp1_a_10mir      ; (30)

sp1_a_10mir:

	nop
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	ldd   ZL,      Y + 2   ; (34)
	icall                  ; (51)
	ldd   ZL,      Y + 1   ; (53)
	icall                  ; (70)
	ldd   ZL,      Y + 0   ; (72)

sp1_a_10mie:

	; --- (Display) ---
	out   PIXOUT,  r17     ; ( 354) Next scanline colored border begins
	; -----------------
	icall                  ; (89)

sp1_a_10end:


	; ( 371) Sprites 12/13 (-10 cy)

	add   r15,     r16
	brcs  sp1_a_12act      ; (11 + 1 / 12 + 1) Sprite 12 has priority over Sprite 13
	add   r0,      r20
	brcc  sp1_a_13ina      ; (14 / 15)

	; Sprite 13 renders

	lds   YL,      v_spoff + (13)
	lds   YH,      sprites + (13 * 8) + SP_BANK
	lds   XL,      sprites + (13 * 8) + SP_XPOS
	lds   r21,     sprites + (13 * 8) + SP_COL1
	lds   r22,     sprites + (13 * 8) + SP_COL2
	lds   r23,     sprites + (13 * 8) + SP_COL3
	add   YL,      r1      ; (27)
	sbrc  r25,     5       ; (28 / 29)
	rjmp  sp1_a_12mir      ; (30)

sp1_a_12nor:

	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	ldd   ZL,      Y + 0   ; (32)
	icall                  ; (49)
	ldd   ZL,      Y + 1   ; (51)
	icall                  ; (68)
	ldd   ZL,      Y + 2   ; (70)
	rjmp  sp1_a_12mie      ; (72)

sp1_a_13ina:

	WAIT  YL,      72
	rjmp  sp1_a_12end      ; (89)

sp1_a_12act:

	; Sprite 12 renders, Sprite 13 skips

	lds   YL,      v_spoff + (12)
	lds   YH,      sprites + (12 * 8) + SP_BANK
	lds   XL,      sprites + (12 * 8) + SP_XPOS
	lds   r21,     sprites + (12 * 8) + SP_COL1
	lds   r22,     sprites + (12 * 8) + SP_COL2
	lds   r23,     sprites + (12 * 8) + SP_COL3
	add   YL,      r1      ; (25 + 1)
	sbrs  r25,     4       ; (26 + 1 / 27 + 1)
	rjmp  sp1_a_12nor      ; (29)
	rjmp  sp1_a_12mir      ; (30)

sp1_a_12mir:

	nop
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	ldd   ZL,      Y + 2   ; (34)
	icall                  ; (51)
	ldd   ZL,      Y + 1   ; (53)
	icall                  ; (70)
	ldd   ZL,      Y + 0   ; (72)

sp1_a_12mie:

	icall                  ; (89)

sp1_a_12end:


	; ( 450) End

	rjmp  .
	rjmp  .
	rjmp  .
	nop

	; ( 457) Restore used color registers

	lds   r15,     palette + 13
	lds   r16,     palette + 14

	; ( 461) Go on to next line

	ldi   ZL,      31
	out   STACKL,  ZL
	pop   r0
	out   PIXOUT,  r0      ; ( 466) Pixel 0
	jmp   m72_graf_scan_b



;
; Entry point B
;
; Uses r15 & r16 which it reloads from palette + 13 & 14 upon return
;
m72_sp1_b:

	ldi   ZL,      LB_STACK - 1 ; Back to video stack (at the end of the line buffer)
	out   STACKL,  ZL
	mov   r1,      r18
	lsl   r1
	add   r1,      r18          ; 3 x Phys. scanline for offsets


	; (1638) Preload

	lds   r15,     sprites + ( 3 * 8) + SP_YPOS
	lds   r16,     v_sphgt + ( 3)
	sub   r15,     r18
	lds   r0,      sprites + ( 2 * 8) + SP_YPOS
	clr   r20

	; (1646) Sprites 0/1

	lds   XL,      sprites + ( 1 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 1)
	sub   XL,      r18
	add   XL,      YL
	lds   XL,      sprites + ( 0 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 0)
	brcs  sp1_b_00act      ; (11 / 12) Sprite 0 has priority over Sprite 1
	sub   XL,      r18
	add   XL,      YL
	brcc  sp1_b_01ina      ; (14 / 15)

	; Sprite 1 renders

	lds   YL,      v_spoff + ( 0)
	lds   YH,      sprites + ( 0 * 8) + SP_BANK
	lds   XL,      sprites + ( 0 * 8) + SP_XPOS
	lds   r21,     sprites + ( 0 * 8) + SP_COL1
	lds   r22,     sprites + ( 0 * 8) + SP_COL2
	lds   r23,     sprites + ( 0 * 8) + SP_COL3
	add   YL,      r1      ; (27)
	sbrc  r24,     0       ; (28 / 29)
	rjmp  sp1_b_00mir      ; (30)

sp1_b_00nor:

	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	ldd   ZL,      Y + 0   ; (32)
	icall                  ; (49)
	ldd   ZL,      Y + 1   ; (51)
	; --- (Display) ---
	out   PIXOUT,  r20     ; (1698) Black border
	; -----------------
	icall                  ; (68)
	ldd   ZL,      Y + 2   ; (70)
	rjmp  sp1_b_00mie      ; (72)

sp1_b_01ina:

	WAIT  YL,      36
	; --- (Display) ---
	out   PIXOUT,  r20     ; (1698) Black border
	; -----------------
	WAIT  YL,      36
	rjmp  sp1_b_00end      ; (89)

sp1_b_00act:

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
	rjmp  sp1_b_00nor      ; (29)
	rjmp  sp1_b_00mir      ; (30)

sp1_b_00mir:

	nop
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	ldd   ZL,      Y + 2   ; (34)
	icall                  ; (51)
	; --- (Display) ---
	out   PIXOUT,  r20     ; (1698) Black border
	; -----------------
	ldd   ZL,      Y + 1   ; (53)
	icall                  ; (70)
	ldd   ZL,      Y + 0   ; (72)

sp1_b_00mie:

	icall                  ; (89)

sp1_b_00end:


	; (1736) Sprites 2/3 (-7 cy)

	add   r15,     r16
	lds   YL,      v_sphgt + ( 2)
	brcs  sp1_b_02act      ; (11 / 12) Sprite 2 has priority over Sprite 3
	sub   r0,      r18
	add   r0,      YL
	brcc  sp1_b_03ina      ; (14 / 15)

	; Sprite 3 renders

	lds   YL,      v_spoff + ( 2)
	lds   YH,      sprites + ( 2 * 8) + SP_BANK
	lds   XL,      sprites + ( 2 * 8) + SP_XPOS
	lds   r21,     sprites + ( 2 * 8) + SP_COL1
	lds   r22,     sprites + ( 2 * 8) + SP_COL2
	lds   r23,     sprites + ( 2 * 8) + SP_COL3
	add   YL,      r1      ; (27)
	sbrc  r24,     2       ; (28 / 29)
	rjmp  sp1_b_02mir      ; (30)

sp1_b_02nor:

	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	ldd   ZL,      Y + 0   ; (32)
	icall                  ; (49)
	ldd   ZL,      Y + 1   ; (51)
	icall                  ; (68)
	ldd   ZL,      Y + 2   ; (70)
	rjmp  sp1_b_02mie      ; (72)

sp1_b_03ina:

	WAIT  YL,      72
	rjmp  sp1_b_02end      ; (89)

sp1_b_02act:

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
	rjmp  sp1_b_02nor      ; (29)
	rjmp  sp1_b_02mir      ; (30)

sp1_b_02mir:

	nop
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	ldd   ZL,      Y + 2   ; (34)
	icall                  ; (51)
	ldd   ZL,      Y + 1   ; (53)
	icall                  ; (70)
	ldd   ZL,      Y + 0   ; (72)

sp1_b_02mie:

	icall                  ; (89)

sp1_b_02end:


	; (1818) Sprites 4/5

	lds   XL,      sprites + ( 5 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 5)
	sub   XL,      r18
	; --- (Display) ---
	cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
	; -----------------
	add   XL,      YL
	lds   XL,      sprites + ( 4 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 4)
	brcs  sp1_b_04act      ; (11 / 12) Sprite 4 has priority over Sprite 5
	sub   XL,      r18
	add   XL,      YL
	brcc  sp1_b_05ina      ; (14 / 15)

	; Sprite 5 renders

	lds   YL,      v_spoff + ( 4)
	lds   YH,      sprites + ( 4 * 8) + SP_BANK
	lds   XL,      sprites + ( 4 * 8) + SP_XPOS
	lds   r21,     sprites + ( 4 * 8) + SP_COL1
	lds   r22,     sprites + ( 4 * 8) + SP_COL2
	lds   r23,     sprites + ( 4 * 8) + SP_COL3
	add   YL,      r1      ; (27)
	sbrc  r24,     4       ; (28 / 29)
	rjmp  sp1_b_04mir      ; (30)

sp1_b_04nor:

	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	ldd   ZL,      Y + 0   ; (32)
	icall                  ; (49)
	ldd   ZL,      Y + 1   ; (51)
	icall                  ; (68)
	ldd   ZL,      Y + 2   ; (70)
	rjmp  sp1_b_04mie      ; (72)

sp1_b_05ina:

	WAIT  YL,      72
	rjmp  sp1_b_04end      ; (89)

sp1_b_04act:

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
	rjmp  sp1_b_04nor      ; (29)
	rjmp  sp1_b_04mir      ; (30)

sp1_b_04mir:

	nop
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	ldd   ZL,      Y + 2   ; (34)
	icall                  ; (51)
	ldd   ZL,      Y + 1   ; (53)
	icall                  ; (70)
	ldd   ZL,      Y + 0   ; (72)

sp1_b_04mie:

	icall                  ; (89)

sp1_b_04end:


	; (  89) Sprites 6/7

	lds   XL,      sprites + ( 7 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 7)
	sub   XL,      r18
	add   XL,      YL
	lds   XL,      sprites + ( 6 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 6)
	brcs  sp1_b_06act      ; (11 / 12) Sprite 6 has priority over Sprite 7
	sub   XL,      r18
	add   XL,      YL
	brcc  sp1_b_07ina      ; (14 / 15)

	; Sprite 7 renders

	lds   YL,      v_spoff + ( 6)
	lds   YH,      sprites + ( 6 * 8) + SP_BANK
	lds   XL,      sprites + ( 6 * 8) + SP_XPOS
	lds   r21,     sprites + ( 6 * 8) + SP_COL1
	lds   r22,     sprites + ( 6 * 8) + SP_COL2
	lds   r23,     sprites + ( 6 * 8) + SP_COL3
	add   YL,      r1      ; (27)
	sbrc  r24,     6       ; (28 / 29)
	rjmp  sp1_b_06mir      ; (30)

sp1_b_06nor:

	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	ldd   ZL,      Y + 0   ; (32)
	icall                  ; (49)
	; --- (Display) ---
	nop
	sbi   SYNC,    SYNC_P  ; ( 141) Sync pulse goes high
	; -----------------
	ldd   ZL,      Y + 1   ; (51)
	icall                  ; (68)
	ldd   ZL,      Y + 2   ; (70)
	rjmp  sp1_b_06mie      ; (72)

sp1_b_07ina:

	WAIT  YL,      34
	; --- (Display) ---
	nop
	sbi   SYNC,    SYNC_P  ; ( 141) Sync pulse goes high
	; -----------------
	WAIT  YL,      38
	rjmp  sp1_b_06end      ; (89)

sp1_b_06act:

	; Sprite 6 renders, Sprite 7 skips

	lds   YL,      v_spoff + ( 7)
	lds   YH,      sprites + ( 7 * 8) + SP_BANK
	lds   XL,      sprites + ( 7 * 8) + SP_XPOS
	lds   r21,     sprites + ( 7 * 8) + SP_COL1
	lds   r22,     sprites + ( 7 * 8) + SP_COL2
	lds   r23,     sprites + ( 7 * 8) + SP_COL3
	add   YL,      r1      ; (25)
	sbrc  r24,     7       ; (26 / 27)
	rjmp  .+2              ; (28)
	rjmp  sp1_b_06nor      ; (29)
	rjmp  sp1_b_06mir      ; (30)

sp1_b_06mir:

	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	ldd   ZL,      Y + 2   ; (34 - 1)
	icall                  ; (51 - 1)
	; --- (Display) ---
	sbi   SYNC,    SYNC_P  ; ( 141) Sync pulse goes high
	nop
	; -----------------
	nop
	ldd   ZL,      Y + 1   ; (53)
	icall                  ; (70)
	ldd   ZL,      Y + 0   ; (72)

sp1_b_06mie:

	icall                  ; (89)

sp1_b_06end:


	; ( 181) Sprites 8/9

	lds   XL,      sprites + ( 9 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 9)
	sub   XL,      r18
	add   XL,      YL
	lds   XL,      sprites + ( 8 * 8) + SP_YPOS
	lds   YL,      v_sphgt + ( 8)
	brcs  sp1_b_08act      ; (11 / 12) Sprite 8 has priority over Sprite 9
	sub   XL,      r18
	add   XL,      YL
	brcc  sp1_b_09ina      ; (14 / 15)

	; Sprite 9 renders

	lds   YL,      v_spoff + ( 8)
	lds   YH,      sprites + ( 8 * 8) + SP_BANK
	lds   XL,      sprites + ( 8 * 8) + SP_XPOS
	lds   r21,     sprites + ( 8 * 8) + SP_COL1
	lds   r22,     sprites + ( 8 * 8) + SP_COL2
	lds   r23,     sprites + ( 8 * 8) + SP_COL3
	add   YL,      r1      ; (27)
	sbrc  r25,     0       ; (28 / 29)
	rjmp  sp1_b_08mir      ; (30)

sp1_b_08nor:

	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	ldd   ZL,      Y + 0   ; (32)
	icall                  ; (49)
	ldd   ZL,      Y + 1   ; (51)
	icall                  ; (68)
	ldd   ZL,      Y + 2   ; (70)
	rjmp  sp1_b_08mie      ; (72)

sp1_b_09ina:

	WAIT  YL,      72
	rjmp  sp1_b_08end      ; (89)

sp1_b_08act:

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
	rjmp  sp1_b_08nor      ; (29)
	rjmp  sp1_b_08mir      ; (30)

sp1_b_08mir:

	nop
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	ldd   ZL,      Y + 2   ; (34)
	icall                  ; (51)
	ldd   ZL,      Y + 1   ; (53)
	icall                  ; (70)
	ldd   ZL,      Y + 0   ; (72)

sp1_b_08mie:

	icall                  ; (89)

sp1_b_08end:


	; ( 270) Preload

	lds   r15,     sprites + (13 * 8) + SP_YPOS
	lds   r16,     v_sphgt + (13)
	sub   r15,     r18
	lds   r0,      sprites + (12 * 8) + SP_YPOS
	lds   r20,     v_sphgt + (12)
	sub   r0,      r18
	nop

	; ( 281) Sprites 10/11

	lds   XL,      sprites + (11 * 8) + SP_YPOS
	lds   YL,      v_sphgt + (11)
	sub   XL,      r18
	add   XL,      YL
	lds   XL,      sprites + (10 * 8) + SP_YPOS
	lds   YL,      v_sphgt + (10)
	brcs  sp1_b_10act      ; (11 / 12) Sprite 10 has priority over Sprite 11
	sub   XL,      r18
	add   XL,      YL
	brcc  sp1_b_11ina      ; (14 / 15)

	; Sprite 11 renders

	lds   YL,      v_spoff + (10)
	lds   YH,      sprites + (10 * 8) + SP_BANK
	lds   XL,      sprites + (10 * 8) + SP_XPOS
	lds   r21,     sprites + (10 * 8) + SP_COL1
	lds   r22,     sprites + (10 * 8) + SP_COL2
	lds   r23,     sprites + (10 * 8) + SP_COL3
	add   YL,      r1      ; (27)
	sbrc  r25,     2       ; (28 / 29)
	rjmp  sp1_b_10mir      ; (30)

sp1_b_10nor:

	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	ldd   ZL,      Y + 0   ; (32)
	icall                  ; (49)
	ldd   ZL,      Y + 1   ; (51)
	icall                  ; (68)
	ldd   ZL,      Y + 2   ; (70)
	rjmp  sp1_b_10mie      ; (72)

sp1_b_11ina:

	WAIT  YL,      57
	; --- (Display) ---
	out   PIXOUT,  r17     ; ( 354) Next scanline colored border begins
	; -----------------
	WAIT  YL,      15
	rjmp  sp1_b_10end      ; (89)

sp1_b_10act:

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
	rjmp  sp1_b_10nor      ; (29)
	rjmp  sp1_b_10mir      ; (30)

sp1_b_10mir:

	nop
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	ldd   ZL,      Y + 2   ; (34)
	icall                  ; (51)
	ldd   ZL,      Y + 1   ; (53)
	icall                  ; (70)
	ldd   ZL,      Y + 0   ; (72)

sp1_b_10mie:

	; --- (Display) ---
	out   PIXOUT,  r17     ; ( 354) Next scanline colored border begins
	; -----------------
	icall                  ; (89)

sp1_b_10end:


	; ( 371) Sprites 12/13 (-10 cy)

	add   r15,     r16
	brcs  sp1_b_12act      ; (11 + 1 / 12 + 1) Sprite 12 has priority over Sprite 13
	add   r0,      r20
	brcc  sp1_b_13ina      ; (14 / 15)

	; Sprite 13 renders

	lds   YL,      v_spoff + (12)
	lds   YH,      sprites + (12 * 8) + SP_BANK
	lds   XL,      sprites + (12 * 8) + SP_XPOS
	lds   r21,     sprites + (12 * 8) + SP_COL1
	lds   r22,     sprites + (12 * 8) + SP_COL2
	lds   r23,     sprites + (12 * 8) + SP_COL3
	add   YL,      r1      ; (27)
	sbrc  r25,     4       ; (28 / 29)
	rjmp  sp1_b_12mir      ; (30)

sp1_b_12nor:

	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	ldd   ZL,      Y + 0   ; (32)
	icall                  ; (49)
	ldd   ZL,      Y + 1   ; (51)
	icall                  ; (68)
	ldd   ZL,      Y + 2   ; (70)
	rjmp  sp1_b_12mie      ; (72)

sp1_b_13ina:

	WAIT  YL,      72
	rjmp  sp1_b_12end      ; (89)

sp1_b_12act:

	; Sprite 12 renders, Sprite 13 skips

	lds   YL,      v_spoff + (13)
	lds   YH,      sprites + (13 * 8) + SP_BANK
	lds   XL,      sprites + (13 * 8) + SP_XPOS
	lds   r21,     sprites + (13 * 8) + SP_COL1
	lds   r22,     sprites + (13 * 8) + SP_COL2
	lds   r23,     sprites + (13 * 8) + SP_COL3
	add   YL,      r1      ; (25 + 1)
	sbrs  r25,     5       ; (26 + 1 / 27 + 1)
	rjmp  sp1_b_12nor      ; (29)
	rjmp  sp1_b_12mir      ; (30)

sp1_b_12mir:

	nop
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	ldd   ZL,      Y + 2   ; (34)
	icall                  ; (51)
	ldd   ZL,      Y + 1   ; (53)
	icall                  ; (70)
	ldd   ZL,      Y + 0   ; (72)

sp1_b_12mie:

	icall                  ; (89)

sp1_b_12end:


	; ( 450) End

	rjmp  .
	rjmp  .
	rjmp  .
	nop

	; ( 457) Restore used color registers

	lds   r15,     palette + 13
	lds   r16,     palette + 14

	; ( 461) Go on to next line

	ldi   ZL,      31
	out   STACKL,  ZL
	pop   r0
	out   PIXOUT,  r0      ; ( 466) Pixel 0
	jmp   m72_graf_scan_b
