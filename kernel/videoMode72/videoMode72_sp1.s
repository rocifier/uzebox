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
; 16 pixels wide ROM (0x8000 - 0xEFFF) / RAM sprites
;
; Sprites are available in the following manner:
;
; +--------------+--------------+--------------+
; | m72_bull_cnt | Main sprites | Bullets      |
; +==============+==============+==============+
; |        0 - 1 |    5 (0 - 4) |    1 (0    ) |
; +--------------+--------------+--------------+
; |        2 - 3 |    4 (0 - 3) |    4 (0 - 3) |
; +--------------+--------------+--------------+
; |        4 -   |    3 (0 - 2) |    7 (0 - 6) |
; +--------------+--------------+--------------+
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
; Entry:                 ; (1631)
; out   PIXOUT,  (zero)  ; (1698) Black border begins
; cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
; sbi   SYNC,    SYNC_P  ; ( 141) Sync pulse goes high
; out   PIXOUT,  r17     ; ( 354) Next scanline colored border begins
; Last cycle:            ; ( 461)
;
; Registers:
;
;  r1: r0: Temp
;  r2:     Background color
;  r3- r5: Temp (Could be sprite colors)
;  r6-r16: Background colors
; r17:     Border color
; r18:     Physical scanline (use to check sprite Y)
; r19:     Log. scanline (no usage)
; r20:     Temp, starts out being Zero (can be used for black border)
; r21:     Temp, usually used by sp_next
; r22-r24: Temp
; r25:     Temp, starts out being Bullet count
;  ZH: ZL: Work pointer (code tiling etc.)
;  YH: YL: Work pointer (for sprite data access)
;  XH: XL: Line buffer access
;
; Return sequence (after last cycle):
;
; ldi   ZL,      15
; out   STACKL,  ZL
; pop   r0
; out   PIXOUT,  r0      ; ( 466) Pixel 0
; jmp   m72_graf_scan_b
;
; Video stack top = LB_STACK - 1 may be used
;



sp1_bdec0:
	WAIT  YL,      10
	rjmp  sp1_bdec1        ; (1693) Bullet decision jump



;
; Entry point
;
m72_sp1:

	ldi   ZL,      LB_STACK - 1 ; Back to video stack (at the end of the line buffer)
	out   STACKL,  ZL
	ldi   r24,     4            ; (1634) 16px wide sprites

	ldi   YL,      lo8(V_BUPT)
	ldi   YH,      hi8(V_BUPT)


	; (1636) Bullet 0 (42)

	rcall sp_bullet


	; (1678) Sprite / Bullet decision

	cpi   r25,     2
	brcs  sp1_bdec0        ; (1680 / 1681) 0 - 1 bullets


	; (1680) Bullet 1 (36 + 1)

	ld    ZL,      Y
	ldd   ZH,      Y + 1
	ld    r4,      Z+      ; ( 6) YPos
	add   r4,      r18     ; ( 7) Line within sprite acquired
	ld    XL,      Z+      ; ( 9) Xpos
	cpi   XL,      176
	brcs  .+2
	ldi   XL,      176     ; (12) Limit Xpos
	ld    r3,      Z+      ; (14) Color
	ld    r5,      Z+      ; (16) Height (bits 2-7) & Width (bits 0-1)
	; --- (Display) ---
	out   PIXOUT,  r20     ; (1698) Black border
	; -----------------
	lsr   r5               ; (17)
	brcc  sp1_b1_13        ; (18 / 19)
	lsr   r5               ; (19)
	brcc  sp1_b1_2         ; (20 / 21)
	cp    r5,      r4      ; (21)
	brcs  sp1_b1_i0        ; (22 / 23)
	st    X+,      r3      ; (24) 1st pixel
	st    X+,      r3      ; (26) 2nd pixel
	st    X+,      r3      ; (28) 3rd pixel
sp1_b1_1e:
	st    X+,      r3      ; (30) 4th pixel
	breq  sp1_b1_x1        ; (31 / 32) At last px of sprite: Load next sprite
	nop
sp1_b1_ni:
	adiw  YL,      2       ; (34)
	rjmp  sp1_b1end        ; (36)
sp1_b1_13:
	lsr   r5               ; (20)
	brcc  sp1_b1_1         ; (21 / 22)
	cp    r5,      r4      ; (22)
	brcs  sp1_b1_i1        ; (23 / 24)
	st    X+,      r3      ; (25) 1st pixel
sp1_b1_2e:
	st    X+,      r3      ; (27) 2nd pixel
	st    X+,      r3      ; (29) 3rd pixel
	breq  sp1_b1_x0        ; (30 / 31) At last px of sprite: Load next sprite
	rjmp  sp1_b1_ni        ; (32)
sp1_b1_2:
	cp    r5,      r4      ; (22)
	brcs  sp1_b1_i1        ; (23 / 24)
	rjmp  sp1_b1_2e        ; (25)
sp1_b1_1:
	cp    r5,      r4      ; (23)
	brcs  sp1_b1_i2        ; (24 / 25)
	rjmp  .                ; (26)
	rjmp  sp1_b1_1e        ; (28)
sp1_b1_i0:
	nop                    ; (24)
sp1_b1_i1:
	nop                    ; (25)
sp1_b1_i2:
	lpm   XL,      Z       ; (28)
	rjmp  .
	rjmp  sp1_b1_ni        ; (32)
sp1_b1_x0:
	nop
sp1_b1_x1:
	st    Y+,      ZL
	st    Y+,      ZH      ; (36)
sp1_b1end:


	; (1717) Bullet 2 (42)

	rcall sp_bullet


	; (1759) Bullet 3 (42)

	rcall sp_bullet


	; (1801) Sprite / Bullet decision

	cpi   r25,     5
	brcc  sp1_bdec2        ; (1803 / 1804)
	lpm   YL,      Z
	rjmp  .
	rjmp  sp1_bdec3        ; (1810)
sp1_bdec2:


	; (1804) Bullet 4 (36 + 3)

	ld    ZL,      Y
	ldd   ZH,      Y + 1
	ld    r4,      Z+      ; ( 6) YPos
	add   r4,      r18     ; ( 7) Line within sprite acquired
	ld    XL,      Z+      ; ( 9) Xpos
	cpi   XL,      176
	brcs  .+2
	ldi   XL,      176     ; (12) Limit Xpos
	ld    r3,      Z+      ; (14) Color
	ld    r5,      Z+      ; (16) Height (bits 2-7) & Width (bits 0-1)
	lsr   r5               ; (17)
	brcc  sp1_b4_13        ; (18 / 19)
	; --- (Display) ---
	nop
	cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
	; -----------------
	lsr   r5               ; (19)
	brcc  sp1_b4_2         ; (20 / 21)
	cp    r5,      r4      ; (21)
	brcs  sp1_b4_i0        ; (22 / 23)
	st    X+,      r3      ; (24) 1st pixel
	st    X+,      r3      ; (26) 2nd pixel
	st    X+,      r3      ; (28) 3rd pixel
sp1_b4_1e:
	st    X+,      r3      ; (30) 4th pixel
	breq  sp1_b4_x1        ; (31 / 32) At last px of sprite: Load next sprite
	nop
sp1_b4_ni:
	adiw  YL,      2       ; (34)
	rjmp  sp1_b4end        ; (36)
sp1_b4_13:
	; --- (Display) ---
	cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
	nop
	; -----------------
	lsr   r5               ; (20)
	brcc  sp1_b4_1         ; (21 / 22)
	cp    r5,      r4      ; (22)
	brcs  sp1_b4_i1        ; (23 / 24)
	st    X+,      r3      ; (25) 1st pixel
sp1_b4_2e:
	st    X+,      r3      ; (27) 2nd pixel
	st    X+,      r3      ; (29) 3rd pixel
	breq  sp1_b4_x0        ; (30 / 31) At last px of sprite: Load next sprite
	rjmp  sp1_b4_ni        ; (32)
sp1_b4_2:
	cp    r5,      r4      ; (22)
	brcs  sp1_b4_i1        ; (23 / 24)
	rjmp  sp1_b4_2e        ; (25)
sp1_b4_1:
	cp    r5,      r4      ; (23)
	brcs  sp1_b4_i2        ; (24 / 25)
	rjmp  .                ; (26)
	rjmp  sp1_b4_1e        ; (28)
sp1_b4_i0:
	nop                    ; (24)
sp1_b4_i1:
	nop                    ; (25)
sp1_b4_i2:
	lpm   XL,      Z       ; (28)
	rjmp  .
	rjmp  sp1_b4_ni        ; (32)
sp1_b4_x0:
	nop
sp1_b4_x1:
	st    Y+,      ZL
	st    Y+,      ZH      ; (36)
sp1_b4end:


	; (  23) Bullet 5 (42)

	rcall sp_bullet


	; (  65) Bullet 6 (42)

	rcall sp_bullet


	; ( 107) Bullets done, transfer

	rjmp  sp1_bdec5


sp1_bdec1:



	; (1693) Sprite 4 (116 + 1)

	ldi   ZL,      lo8(v_sprd + (10 * 4))
	ldi   ZH,      hi8(v_sprd + (10 * 4))
	ld    r0,      Z+      ; ( 4) YPos
	; --- (Display) ---
	out   PIXOUT,  r20     ; (1698) Black border
	; -----------------
	add   r0,      r18     ; ( 5) Line within sprite acquired
	ld    XL,      Z+      ; ( 7) Height
	cp    r0,      XL
	brcc  sp1_4ina         ; ( 9 / 10)
	mul   r0,      r24     ; (11) r24 = 4; 16px wide sprites
	ld    YL,      Z+      ; (13) OffLo
	add   YL,      r0
	ld    YH,      Z+      ; (16) OffHi + Mirror on bit 7
	adc   YH,      r1
	ld    XL,      Z+      ; (19) XPos
	ld    r3,      Z+      ; (21) Color 1
	ld    r4,      Z+      ; (23) Color 2
	ld    r5,      Z+      ; (25) Color 3
	brpl  sp1_4nor         ; (26 / 27) Mirroring flag
	cpi   YH,      0xF1    ; (27)
	brcc  sp1_4mra         ; (28 / 29)
	movw  ZL,      YL      ; (29)
	lpm   r22,     Z+      ; (32)
	lpm   r21,     Z+      ; (35)
	lpm   r1,      Z+      ; (38)
	lpm   r0,      Z+      ; (41)
sp1_4mre:
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	rjmp  sp1_4mie         ; (44)
sp1_4mra:
	subi  YH,      0xF0    ; (30)
	ld    r22,     Y+      ; (32)
	ld    r21,     Y+      ; (34)
	ld    r1,      Y+      ; (36)
	ld    r0,      Y+      ; (38)
	nop                    ; (39)
	rjmp  sp1_4mre         ; (41)
sp1_4ina:
	brne  sp1_4nnx         ; (11 / 12)
	rcall sp_next          ; (69)
	WAIT  YL,      45
	rjmp  sp1_4end         ; (116)
sp1_4nnx:
	WAIT  YL,      102
	rjmp  sp1_4end         ; (116)
sp1_4nra:
	subi  YH,      0x70    ; (31)
	ld    r0,      Y+      ; (33)
	ld    r1,      Y+      ; (35)
	ld    r21,     Y+      ; (37)
	ld    r22,     Y+      ; (39)
	rjmp  .
	rjmp  sp1_4nre         ; (43)
sp1_4nor:
	cpi   YH,      0x71    ; (28)
	brcc  sp1_4nra         ; (29 / 30)
	ori   YH,      0x80    ; (30)
	movw  ZL,      YL      ; (31)
	lpm   r0,      Z+      ; (34)
	lpm   r1,      Z+      ; (37)
	lpm   r21,     Z+      ; (40)
	lpm   r22,     Z+      ; (43)
sp1_4nre:
	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
sp1_4mie:
	mov   ZL,      r0      ; (45)
	icall                  ; (62)
	mov   ZL,      r1      ; (63)
	icall                  ; (80)
	mov   ZL,      r21     ; (81)
	icall                  ; (98)
	mov   ZL,      r22     ; (99)
	icall                  ; (116)
sp1_4end:

sp1_bdec3:


	; (1810) Sprite 3 (116 + 3)

	ldi   ZL,      lo8(v_sprd + (10 * 3))
	ldi   ZH,      hi8(v_sprd + (10 * 3))
	ld    r0,      Z+      ; ( 4) YPos
	add   r0,      r18     ; ( 5) Line within sprite acquired
	ld    XL,      Z+      ; ( 7) Height
	cp    r0,      XL
	brcc  sp1_3ina         ; ( 9 / 10)
	mul   r0,      r24     ; (11) r24 = 4; 16px wide sprites
	ld    YL,      Z+      ; (13) OffLo
	; --- (Display) ---
	cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
	nop
	; -----------------
	add   YL,      r0
	ld    YH,      Z+      ; (16) OffHi + Mirror on bit 7
	adc   YH,      r1
	ld    XL,      Z+      ; (19) XPos
	ld    r3,      Z+      ; (21) Color 1
	ld    r4,      Z+      ; (23) Color 2
	ld    r5,      Z+      ; (25) Color 3
	brpl  sp1_3nor         ; (26 / 27) Mirroring flag
	cpi   YH,      0xF1    ; (27)
	brcc  sp1_3mra         ; (28 / 29)
	movw  ZL,      YL      ; (29)
	lpm   r22,     Z+      ; (32)
	lpm   r21,     Z+      ; (35)
	lpm   r1,      Z+      ; (38)
	lpm   r0,      Z+      ; (41)
sp1_3mre:
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	rjmp  sp1_3mie         ; (44)
sp1_3mra:
	subi  YH,      0xF0    ; (30)
	ld    r22,     Y+      ; (32)
	ld    r21,     Y+      ; (34)
	ld    r1,      Y+      ; (36)
	ld    r0,      Y+      ; (38)
	nop                    ; (39)
	rjmp  sp1_3mre         ; (41)
sp1_3ina:
	lpm   YL,      Z       ; (12 + 1)
	; --- (Display) ---
	cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
	; -----------------
	brne  sp1_3nnx         ; (13 / 14)
	rcall sp_next          ; (71)
	WAIT  YL,      43
	rjmp  sp1_3end         ; (116)
sp1_3nnx:
	WAIT  YL,      100
	rjmp  sp1_3end         ; (116)
sp1_3nra:
	subi  YH,      0x70    ; (31)
	ld    r0,      Y+      ; (33)
	ld    r1,      Y+      ; (35)
	ld    r21,     Y+      ; (37)
	ld    r22,     Y+      ; (39)
	rjmp  .
	rjmp  sp1_3nre         ; (43)
sp1_3nor:
	cpi   YH,      0x71    ; (28)
	brcc  sp1_3nra         ; (29 / 30)
	ori   YH,      0x80    ; (30)
	movw  ZL,      YL      ; (31)
	lpm   r0,      Z+      ; (34)
	lpm   r1,      Z+      ; (37)
	lpm   r21,     Z+      ; (40)
	lpm   r22,     Z+      ; (43)
sp1_3nre:
	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
sp1_3mie:
	mov   ZL,      r0      ; (45)
	icall                  ; (62)
	mov   ZL,      r1      ; (63)
	icall                  ; (80)
	mov   ZL,      r21     ; (81)
	icall                  ; (98)
	mov   ZL,      r22     ; (99)
	icall                  ; (116)
sp1_3end:

sp1_bdec5:


	; ( 109) Sprite 2 (116 + 2 + 5)

	; --- (Preload) ---
	lds   r20,     (v_sprd + (10 * 1) + 0) ; YPos
	add   r20,     r18     ; Line within sprite acquired
	lds   r23,     (v_sprd + (10 * 1) + 1) ; Height
	; -----------------
	ldi   ZL,      lo8(v_sprd + (10 * 2))
	ldi   ZH,      hi8(v_sprd + (10 * 2))
	ld    r0,      Z+      ; ( 4) YPos
	add   r0,      r18     ; ( 5) Line within sprite acquired
	ld    XL,      Z+      ; ( 7) Height
	cp    r0,      XL
	brcc  sp1_2ina         ; ( 9 / 10)
	mul   r0,      r24     ; (11) r24 = 4; 16px wide sprites
	ld    YL,      Z+      ; (13) OffLo
	add   YL,      r0
	ld    YH,      Z+      ; (16) OffHi + Mirror on bit 7
	adc   YH,      r1
	ld    XL,      Z+      ; (19) XPos
	ld    r3,      Z+      ; (21) Color 1
	ld    r4,      Z+      ; (23) Color 2
	ld    r5,      Z+      ; (25) Color 3
	; --- (Display) ---
	sbi   SYNC,    SYNC_P  ; ( 141) Sync pulse goes high
	; -----------------
	brpl  sp1_2nor         ; (26 / 27) Mirroring flag
	cpi   YH,      0xF1    ; (27)
	brcc  sp1_2mra         ; (28 / 29)
	movw  ZL,      YL      ; (29)
	lpm   r22,     Z+      ; (32)
	lpm   r21,     Z+      ; (35)
	lpm   r1,      Z+      ; (38)
	lpm   r0,      Z+      ; (41)
sp1_2mre:
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	rjmp  sp1_2mie         ; (44)
sp1_2mra:
	subi  YH,      0xF0    ; (30)
	ld    r22,     Y+      ; (32)
	ld    r21,     Y+      ; (34)
	ld    r1,      Y+      ; (36)
	ld    r0,      Y+      ; (38)
	nop                    ; (39)
	rjmp  sp1_2mre         ; (41)
sp1_2ina:
	lpm   YL,      Z       ; (13)
	lpm   YL,      Z       ; (16)
	lpm   YL,      Z       ; (19)
	lpm   YL,      Z       ; (22)
	lpm   YL,      Z       ; (25)
	; --- (Display) ---
	sbi   SYNC,    SYNC_P  ; ( 141) Sync pulse goes high
	; -----------------
	brne  sp1_2nnx         ; (26 / 27)
	rcall sp_next          ; (84)
	WAIT  YL,      30
	rjmp  sp1_2end         ; (116)
sp1_2nnx:
	WAIT  YL,      87
	rjmp  sp1_2end         ; (116)
sp1_2nra:
	subi  YH,      0x70    ; (31)
	ld    r0,      Y+      ; (33)
	ld    r1,      Y+      ; (35)
	ld    r21,     Y+      ; (37)
	ld    r22,     Y+      ; (39)
	rjmp  .
	rjmp  sp1_2nre         ; (43)
sp1_2nor:
	cpi   YH,      0x71    ; (28)
	brcc  sp1_2nra         ; (29 / 30)
	ori   YH,      0x80    ; (30)
	movw  ZL,      YL      ; (31)
	lpm   r0,      Z+      ; (34)
	lpm   r1,      Z+      ; (37)
	lpm   r21,     Z+      ; (40)
	lpm   r22,     Z+      ; (43)
sp1_2nre:
	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
sp1_2mie:
	mov   ZL,      r0      ; (45)
	icall                  ; (62)
	mov   ZL,      r1      ; (63)
	icall                  ; (80)
	mov   ZL,      r21     ; (81)
	icall                  ; (98)
	mov   ZL,      r22     ; (99)
	icall                  ; (116)
sp1_2end:


	; ( 232) Sprite 1 (116 - 5)

	ldi   ZL,      lo8(v_sprd + (10 * 1) + 2)
	ldi   ZH,      hi8(v_sprd + (10 * 1) + 2)
	cp    r20,     r23
	brcc  sp1_1ina         ; ( 9 / 10)
	mul   r20,     r24     ; (11) r24 = 4; 16px wide sprites
	ld    YL,      Z+      ; (13) OffLo
	add   YL,      r0
	ld    YH,      Z+      ; (16) OffHi + Mirror on bit 7
	adc   YH,      r1
	ld    XL,      Z+      ; (19) XPos
	ld    r3,      Z+      ; (21) Color 1
	ld    r4,      Z+      ; (23) Color 2
	ld    r5,      Z+      ; (25) Color 3
	brpl  sp1_1nor         ; (26 / 27) Mirroring flag
	cpi   YH,      0xF1    ; (27)
	brcc  sp1_1mra         ; (28 / 29)
	movw  ZL,      YL      ; (29)
	lpm   r22,     Z+      ; (32)
	lpm   r21,     Z+      ; (35)
	lpm   r1,      Z+      ; (38)
	lpm   r0,      Z+      ; (41)
sp1_1mre:
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	rjmp  sp1_1mie         ; (44)
sp1_1mra:
	subi  YH,      0xF0    ; (30)
	ld    r22,     Y+      ; (32)
	ld    r21,     Y+      ; (34)
	ld    r1,      Y+      ; (36)
	ld    r0,      Y+      ; (38)
	nop                    ; (39)
	rjmp  sp1_1mre         ; (41)
sp1_1ina:
	brne  sp1_1nnx         ; (11 / 12)
	rcall sp_next          ; (69)
	WAIT  YL,      45
	rjmp  sp1_1end         ; (116)
sp1_1nnx:
	WAIT  YL,      102
	rjmp  sp1_1end         ; (116)
sp1_1nra:
	subi  YH,      0x70    ; (31)
	ld    r0,      Y+      ; (33)
	ld    r1,      Y+      ; (35)
	ld    r21,     Y+      ; (37)
	ld    r22,     Y+      ; (39)
	rjmp  .
	rjmp  sp1_1nre         ; (43)
sp1_1nor:
	cpi   YH,      0x71    ; (28)
	brcc  sp1_1nra         ; (29 / 30)
	ori   YH,      0x80    ; (30)
	movw  ZL,      YL      ; (31)
	lpm   r0,      Z+      ; (34)
	lpm   r1,      Z+      ; (37)
	lpm   r21,     Z+      ; (40)
	lpm   r22,     Z+      ; (43)
sp1_1nre:
	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
sp1_1mie:
	mov   ZL,      r0      ; (45)
	icall                  ; (62)
	mov   ZL,      r1      ; (63)
	icall                  ; (80)
	mov   ZL,      r21     ; (81)
	icall                  ; (98)
	mov   ZL,      r22     ; (99)
	icall                  ; (116)
sp1_1end:


	; ( 343) Sprite 0 (116 + 2)

	ldi   ZL,      lo8(v_sprd + (10 * 0))
	ldi   ZH,      hi8(v_sprd + (10 * 0))
	ld    r0,      Z+      ; ( 4) YPos
	add   r0,      r18     ; ( 5) Line within sprite acquired
	ld    XL,      Z+      ; ( 7) Height
	cp    r0,      XL
	brcc  sp1_0ina         ; ( 9 / 10)
	; --- (Display) ---
	nop
	out   PIXOUT,  r17     ; ( 354) Next scanline colored border begins
	; -----------------
	mul   r0,      r24     ; (11) r24 = 4; 16px wide sprites
	ld    YL,      Z+      ; (13) OffLo
	add   YL,      r0
	ld    YH,      Z+      ; (16) OffHi + Mirror on bit 7
	adc   YH,      r1
	ld    XL,      Z+      ; (19) XPos
	ld    r3,      Z+      ; (21) Color 1
	ld    r4,      Z+      ; (23) Color 2
	ld    r5,      Z+      ; (25) Color 3
	brpl  sp1_0nor         ; (26 / 27) Mirroring flag
	cpi   YH,      0xF1    ; (27)
	brcc  sp1_0mra         ; (28 / 29)
	movw  ZL,      YL      ; (29)
	lpm   r22,     Z+      ; (32)
	lpm   r21,     Z+      ; (35)
	lpm   r1,      Z+      ; (38)
	lpm   r0,      Z+      ; (41)
sp1_0mre:
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	rjmp  sp1_0mie         ; (44)
sp1_0mra:
	subi  YH,      0xF0    ; (30)
	ld    r22,     Y+      ; (32)
	ld    r21,     Y+      ; (34)
	ld    r1,      Y+      ; (36)
	ld    r0,      Y+      ; (38)
	nop                    ; (39)
	rjmp  sp1_0mre         ; (41)
sp1_0ina:
	; --- (Display) ---
	out   PIXOUT,  r17     ; ( 354) Next scanline colored border begins
	nop
	; -----------------
	brne  sp1_0nnx         ; (11 / 12)
	rcall sp_next          ; (69)
	WAIT  YL,      45
	rjmp  sp1_0end         ; (116)
sp1_0nnx:
	WAIT  YL,      102
	rjmp  sp1_0end         ; (116)
sp1_0nra:
	subi  YH,      0x70    ; (31)
	ld    r0,      Y+      ; (33)
	ld    r1,      Y+      ; (35)
	ld    r21,     Y+      ; (37)
	ld    r22,     Y+      ; (39)
	rjmp  .
	rjmp  sp1_0nre         ; (43)
sp1_0nor:
	cpi   YH,      0x71    ; (28)
	brcc  sp1_0nra         ; (29 / 30)
	ori   YH,      0x80    ; (30)
	movw  ZL,      YL      ; (31)
	lpm   r0,      Z+      ; (34)
	lpm   r1,      Z+      ; (37)
	lpm   r21,     Z+      ; (40)
	lpm   r22,     Z+      ; (43)
sp1_0nre:
	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
sp1_0mie:
	mov   ZL,      r0      ; (45)
	icall                  ; (62)
	mov   ZL,      r1      ; (63)
	icall                  ; (80)
	mov   ZL,      r21     ; (81)
	icall                  ; (98)
	mov   ZL,      r22     ; (99)
	icall                  ; (116)
sp1_0end:


	; ( 461) Go on to next line

	ldi   ZL,      15
	out   STACKL,  ZL
	pop   r0
	out   PIXOUT,  r0      ; ( 466) Pixel 0
	jmp   m72_graf_scan_b
