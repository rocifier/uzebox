/*
 *  Uzebox Kernel - Mode 72, Sprite mode 2
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
; Video mode 72, Sprite mode 2
;
; 12 pixels wide ROM (0x0000 - 0x6FFF) / RAM sprites
;
; Sprites are available in the following manner:
;
; +--------------+--------------+--------------+
; | m72_bull_cnt | Main sprites | Bullets      |
; +==============+==============+==============+
; |        0 - 1 |    6 (0 - 5) |    1 (0    ) |
; +--------------+--------------+--------------+
; |        2 - 3 |    5 (0 - 3) |    4 (0 - 3) |
; +--------------+--------------+--------------+
; |        4 -   |    4 (0 - 2) |    6 (0 - 5) |
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



sp2_bdec0:
	WAIT  YL,      16
	; --- (Display) ---
	out   PIXOUT,  r20     ; (1698) Black border
	; -----------------
	lpm   YL,      Z
	lpm   YL,      Z
	rjmp  sp2_bdec1        ; (1706) Bullet decision jump



;
; Entry point
;
m72_sp2:

	ldi   ZL,      LB_STACK - 1 ; Back to video stack (at the end of the line buffer)
	out   STACKL,  ZL
	ldi   r24,     3            ; (1634) 12px wide sprites

	ldi   YL,      lo8(V_BUPT)
	ldi   YH,      hi8(V_BUPT)


	; (1636) Bullet 0 (42)

	rcall sp_bullet


	; (1678) Sprite / Bullet decision

	cpi   r25,     2
	brcs  sp2_bdec0        ; (1680 / 1681) 0 - 1 bullets


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
	brcc  sp2_b1_13        ; (18 / 19)
	lsr   r5               ; (19)
	brcc  sp2_b1_2         ; (20 / 21)
	cp    r5,      r4      ; (21)
	brcs  sp2_b1_i0        ; (22 / 23)
	st    X+,      r3      ; (24) 1st pixel
	st    X+,      r3      ; (26) 2nd pixel
	st    X+,      r3      ; (28) 3rd pixel
sp2_b1_1e:
	st    X+,      r3      ; (30) 4th pixel
	breq  sp2_b1_x1        ; (31 / 32) At last px of sprite: Load next sprite
	nop
sp2_b1_ni:
	adiw  YL,      2       ; (34)
	rjmp  sp2_b1end        ; (36)
sp2_b1_13:
	lsr   r5               ; (20)
	brcc  sp2_b1_1         ; (21 / 22)
	cp    r5,      r4      ; (22)
	brcs  sp2_b1_i1        ; (23 / 24)
	st    X+,      r3      ; (25) 1st pixel
sp2_b1_2e:
	st    X+,      r3      ; (27) 2nd pixel
	st    X+,      r3      ; (29) 3rd pixel
	breq  sp2_b1_x0        ; (30 / 31) At last px of sprite: Load next sprite
	rjmp  sp2_b1_ni        ; (32)
sp2_b1_2:
	cp    r5,      r4      ; (22)
	brcs  sp2_b1_i1        ; (23 / 24)
	rjmp  sp2_b1_2e        ; (25)
sp2_b1_1:
	cp    r5,      r4      ; (23)
	brcs  sp2_b1_i2        ; (24 / 25)
	rjmp  .                ; (26)
	rjmp  sp2_b1_1e        ; (28)
sp2_b1_i0:
	nop                    ; (24)
sp2_b1_i1:
	nop                    ; (25)
sp2_b1_i2:
	lpm   XL,      Z       ; (28)
	rjmp  .
	rjmp  sp2_b1_ni        ; (32)
sp2_b1_x0:
	nop
sp2_b1_x1:
	st    Y+,      ZL
	st    Y+,      ZH      ; (36)
sp2_b1end:


	; (1717) Bullet 2 (42)

	rcall sp_bullet


	; (1759) Bullet 3 (36)

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
	brcc  sp2_b3_13        ; (18 / 19)
	lsr   r5               ; (19)
	brcc  sp2_b3_2         ; (20 / 21)
	cp    r5,      r4      ; (21)
	brcs  sp2_b3_i0        ; (22 / 23)
	st    X+,      r3      ; (24) 1st pixel
	st    X+,      r3      ; (26) 2nd pixel
	st    X+,      r3      ; (28) 3rd pixel
sp2_b3_1e:
	st    X+,      r3      ; (30) 4th pixel
	breq  sp2_b3_x1        ; (31 / 32) At last px of sprite: Load next sprite
	nop
sp2_b3_ni:
	adiw  YL,      2       ; (34)
	rjmp  sp2_b3end        ; (36)
sp2_b3_13:
	lsr   r5               ; (20)
	brcc  sp2_b3_1         ; (21 / 22)
	cp    r5,      r4      ; (22)
	brcs  sp2_b3_i1        ; (23 / 24)
	st    X+,      r3      ; (25) 1st pixel
sp2_b3_2e:
	st    X+,      r3      ; (27) 2nd pixel
	st    X+,      r3      ; (29) 3rd pixel
	breq  sp2_b3_x0        ; (30 / 31) At last px of sprite: Load next sprite
	rjmp  sp2_b3_ni        ; (32)
sp2_b3_2:
	cp    r5,      r4      ; (22)
	brcs  sp2_b3_i1        ; (23 / 24)
	rjmp  sp2_b3_2e        ; (25)
sp2_b3_1:
	cp    r5,      r4      ; (23)
	brcs  sp2_b3_i2        ; (24 / 25)
	rjmp  .                ; (26)
	rjmp  sp2_b3_1e        ; (28)
sp2_b3_i0:
	nop                    ; (24)
sp2_b3_i1:
	nop                    ; (25)
sp2_b3_i2:
	lpm   XL,      Z       ; (28)
	rjmp  .
	rjmp  sp2_b3_ni        ; (32)
sp2_b3_x0:
	nop
sp2_b3_x1:
	st    Y+,      ZL
	st    Y+,      ZH      ; (36)
sp2_b3end:


	; (1795) Sprite / Bullet decision

	cpi   r25,     5
	brcc  sp2_bdec2        ; (1797 / 1798)
	rjmp  .
	rjmp  sp2_bdec3        ; (1801)
sp2_bdec2:
	WAIT  ZL,      18


	; (1816) Bullet 4 (36 + 2)

	ld    ZL,      Y
	ldd   ZH,      Y + 1
	ld    r4,      Z+      ; ( 6) YPos
	add   r4,      r18     ; ( 7) Line within sprite acquired
	; --- (Display) ---
	cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
	; -----------------
	ld    XL,      Z+      ; ( 9) Xpos
	cpi   XL,      176
	brcs  .+2
	ldi   XL,      176     ; (12) Limit Xpos
	ld    r3,      Z+      ; (14) Color
	ld    r5,      Z+      ; (16) Height (bits 2-7) & Width (bits 0-1)
	lsr   r5               ; (17)
	brcc  sp2_b4_13        ; (18 / 19)
	lsr   r5               ; (19)
	brcc  sp2_b4_2         ; (20 / 21)
	cp    r5,      r4      ; (21)
	brcs  sp2_b4_i0        ; (22 / 23)
	st    X+,      r3      ; (24) 1st pixel
	st    X+,      r3      ; (26) 2nd pixel
	st    X+,      r3      ; (28) 3rd pixel
sp2_b4_1e:
	st    X+,      r3      ; (30) 4th pixel
	breq  sp2_b4_x1        ; (31 / 32) At last px of sprite: Load next sprite
	nop
sp2_b4_ni:
	adiw  YL,      2       ; (34)
	rjmp  sp2_b4end        ; (36)
sp2_b4_13:
	lsr   r5               ; (20)
	brcc  sp2_b4_1         ; (21 / 22)
	cp    r5,      r4      ; (22)
	brcs  sp2_b4_i1        ; (23 / 24)
	st    X+,      r3      ; (25) 1st pixel
sp2_b4_2e:
	st    X+,      r3      ; (27) 2nd pixel
	st    X+,      r3      ; (29) 3rd pixel
	breq  sp2_b4_x0        ; (30 / 31) At last px of sprite: Load next sprite
	rjmp  sp2_b4_ni        ; (32)
sp2_b4_2:
	cp    r5,      r4      ; (22)
	brcs  sp2_b4_i1        ; (23 / 24)
	rjmp  sp2_b4_2e        ; (25)
sp2_b4_1:
	cp    r5,      r4      ; (23)
	brcs  sp2_b4_i2        ; (24 / 25)
	rjmp  .                ; (26)
	rjmp  sp2_b4_1e        ; (28)
sp2_b4_i0:
	nop                    ; (24)
sp2_b4_i1:
	nop                    ; (25)
sp2_b4_i2:
	lpm   XL,      Z       ; (28)
	rjmp  .
	rjmp  sp2_b4_ni        ; (32)
sp2_b4_x0:
	nop
sp2_b4_x1:
	st    Y+,      ZL
	st    Y+,      ZH      ; (36)
sp2_b4end:


	; (  34) Bullet 5 (42)

	rcall sp_bullet


	; (  76) Bullets done, transfer

	rjmp  sp2_bdec5

sp2_bdec1:


	; (1706) Sprite 5 (95)

	ldi   ZL,      lo8(v_sprd + (10 * 5))
	ldi   ZH,      hi8(v_sprd + (10 * 5))
	ld    r0,      Z+      ; ( 4) YPos
	add   r0,      r18     ; ( 5) Line within sprite acquired
	ld    XL,      Z+      ; ( 7) Height
	cp    r0,      XL
	brcc  sp2_5ina         ; ( 9 / 10)
	mul   r0,      r24     ; (11) r24 = 3; 12px wide sprites
	ld    YL,      Z+      ; (13) OffLo
	add   YL,      r0
	ld    YH,      Z+      ; (16) OffHi + Mirror on bit 7
	adc   YH,      r1
	ld    XL,      Z+      ; (19) XPos
	ld    r3,      Z+      ; (21) Color 1
	ld    r4,      Z+      ; (23) Color 2
	ld    r5,      Z+      ; (25) Color 3
	brmi  sp2_5mir         ; (26 / 27) Mirroring flag
	cpi   YH,      0x71    ; (27)
	brcc  sp2_5mra         ; (28 / 29)
	movw  ZL,      YL      ; (29)
	lpm   r21,     Z+      ; (32)
	lpm   r1,      Z+      ; (35)
	lpm   r0,      Z+      ; (38)
sp2_5mre:
	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	rjmp  sp2_5mie         ; (41)
sp2_5mra:
	subi  YH,      0x70    ; (30)
	ld    r21,     Y+      ; (32)
	ld    r1,      Y+      ; (34)
	ld    r0,      Y+      ; (36)
	rjmp  sp2_5mre         ; (38)
sp2_5ina:
	brne  sp2_5nnx         ; (11 / 12)
	rcall sp_next          ; (69)
	WAIT  YL,      24
	rjmp  sp2_5end         ; (95)
sp2_5nnx:
	WAIT  YL,      81
	rjmp  sp2_5end         ; (95)
sp2_5nra:
	subi  YH,      0xF0    ; (31)
	ld    r0,      Y+      ; (33)
	ld    r1,      Y+      ; (35)
	ld    r21,     Y+      ; (37)
	nop
	rjmp  sp2_5nre         ; (40)
sp2_5mir:
	cpi   YH,      0xF1    ; (28)
	brcc  sp2_5nra         ; (29 / 30)
	andi  YH,      0x7F    ; (30)
	movw  ZL,      YL      ; (31)
	lpm   r0,      Z+      ; (34)
	lpm   r1,      Z+      ; (37)
	lpm   r21,     Z+      ; (40)
sp2_5nre:
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
sp2_5mie:
	mov   ZL,      r21     ; (42)
	icall                  ; (59)
	mov   ZL,      r1      ; (60)
	icall                  ; (77)
	mov   ZL,      r0      ; (78)
	icall                  ; (95)
sp2_5end:

sp2_bdec3:


	; (1801) Sprite 4 (95 + 2)

	ldi   ZL,      lo8(v_sprd + (10 * 4))
	ldi   ZH,      hi8(v_sprd + (10 * 4))
	ld    r0,      Z+      ; ( 4) YPos
	add   r0,      r18     ; ( 5) Line within sprite acquired
	ld    XL,      Z+      ; ( 7) Height
	cp    r0,      XL
	brcc  sp2_4ina         ; ( 9 / 10)
	mul   r0,      r24     ; (11) r24 = 3; 12px wide sprites
	ld    YL,      Z+      ; (13) OffLo
	add   YL,      r0
	ld    YH,      Z+      ; (16) OffHi + Mirror on bit 7
	ld    XL,      Z+      ; (18) XPos
	ld    r3,      Z+      ; (20) Color 1
	ld    r4,      Z+      ; (22) Color 2
	; --- (Display) ---
	cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
	; -----------------
	adc   YH,      r1
	ld    r5,      Z+      ; (25) Color 3
	brmi  sp2_4mir         ; (26 / 27) Mirroring flag
	cpi   YH,      0x71    ; (27)
	brcc  sp2_4mra         ; (28 / 29)
	movw  ZL,      YL      ; (29)
	lpm   r21,     Z+      ; (32)
	lpm   r1,      Z+      ; (35)
	lpm   r0,      Z+      ; (38)
sp2_4mre:
	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	rjmp  sp2_4mie         ; (41)
sp2_4mra:
	subi  YH,      0x70    ; (30)
	ld    r21,     Y+      ; (32)
	ld    r1,      Y+      ; (34)
	ld    r0,      Y+      ; (36)
	rjmp  sp2_4mre         ; (38)
sp2_4ina:
	lpm   YL,      Z       ; (13)
	lpm   YL,      Z       ; (16)
	lpm   YL,      Z       ; (19)
	lpm   YL,      Z       ; (22)
	; --- (Display) ---
	cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
	; -----------------
	brne  sp2_4nnx         ; (23 / 24)
	rcall sp_next          ; (81)
	WAIT  YL,      12
	rjmp  sp2_4end         ; (95)
sp2_4nnx:
	WAIT  YL,      69
	rjmp  sp2_4end         ; (95)
sp2_4nra:
	subi  YH,      0xF0    ; (31)
	ld    r0,      Y+      ; (33)
	ld    r1,      Y+      ; (35)
	ld    r21,     Y+      ; (37)
	nop
	rjmp  sp2_4nre         ; (40)
sp2_4mir:
	cpi   YH,      0xF1    ; (28)
	brcc  sp2_4nra         ; (29 / 30)
	andi  YH,      0x7F    ; (30)
	movw  ZL,      YL      ; (31)
	lpm   r0,      Z+      ; (34)
	lpm   r1,      Z+      ; (37)
	lpm   r21,     Z+      ; (40)
sp2_4nre:
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
sp2_4mie:
	mov   ZL,      r21     ; (42)
	icall                  ; (59)
	mov   ZL,      r1      ; (60)
	icall                  ; (77)
	mov   ZL,      r0      ; (78)
	icall                  ; (95)
sp2_4end:

sp2_bdec5:


	; (  78) Sprite 3 (95 + 2 + 2)

	; --- (Preload) ---
	lds   r22,     (v_sprd + (10 * 2) + 0) ; YPos
	; -----------------
	ldi   ZL,      lo8(v_sprd + (10 * 3))
	ldi   ZH,      hi8(v_sprd + (10 * 3))
	ld    r0,      Z+      ; ( 4) YPos
	add   r0,      r18     ; ( 5) Line within sprite acquired
	ld    XL,      Z+      ; ( 7) Height
	cp    r0,      XL
	brcc  sp2_3ina         ; ( 9 / 10)
	mul   r0,      r24     ; (11) r24 = 3; 12px wide sprites
	ld    YL,      Z+      ; (13) OffLo
	add   YL,      r0
	ld    YH,      Z+      ; (16) OffHi + Mirror on bit 7
	adc   YH,      r1
	ld    XL,      Z+      ; (19) XPos
	ld    r3,      Z+      ; (21) Color 1
	ld    r4,      Z+      ; (23) Color 2
	ld    r5,      Z+      ; (25) Color 3
	brmi  sp2_3mir         ; (26 / 27) Mirroring flag
	cpi   YH,      0x71    ; (27)
	brcc  sp2_3mra         ; (28 / 29)
	movw  ZL,      YL      ; (29)
	lpm   r21,     Z+      ; (32)
	lpm   r1,      Z+      ; (35)
	lpm   r0,      Z+      ; (38)
sp2_3mre:
	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	rjmp  sp2_3mie         ; (41)
sp2_3mra:
	subi  YH,      0x70    ; (30)
	ld    r21,     Y+      ; (32)
	ld    r1,      Y+      ; (34)
	ld    r0,      Y+      ; (36)
	rjmp  sp2_3mre         ; (38)
sp2_3ina:
	brne  sp2_3nnx         ; (11 / 12)
	rcall sp2_3next        ; (69)
	WAIT  YL,      24
	rjmp  sp2_3end         ; (95)
sp2_3nnx:
	WAIT  YL,      47      ; (59)
	; --- (Display) ---
	sbi   SYNC,    SYNC_P  ; ( 141) Sync pulse goes high
	; -----------------
	WAIT  YL,      34
	rjmp  sp2_3end         ; (95)
sp2_3nra:
	subi  YH,      0xF0    ; (31)
	ld    r0,      Y+      ; (33)
	ld    r1,      Y+      ; (35)
	ld    r21,     Y+      ; (37)
	nop
	rjmp  sp2_3nre         ; (40)
sp2_3mir:
	cpi   YH,      0xF1    ; (28)
	brcc  sp2_3nra         ; (29 / 30)
	andi  YH,      0x7F    ; (30)
	movw  ZL,      YL      ; (31)
	lpm   r0,      Z+      ; (34)
	lpm   r1,      Z+      ; (37)
	lpm   r21,     Z+      ; (40)
sp2_3nre:
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
sp2_3mie:
	mov   ZL,      r21     ; (42)
	icall                  ; (59)
	; --- (Display) ---
	sbi   SYNC,    SYNC_P  ; ( 141) Sync pulse goes high
	; -----------------
	mov   ZL,      r1      ; (60)
	icall                  ; (77)
	mov   ZL,      r0      ; (78)
	icall                  ; (95)
sp2_3end:


	; ( 177) Sprite 2 (95 - 2)

	ldi   ZL,      lo8(v_sprd + (10 * 2) + 1)
	ldi   ZH,      hi8(v_sprd + (10 * 2) + 1)
	add   r22,     r18     ; ( 5) Line within sprite acquired
	ld    XL,      Z+      ; ( 7) Height
	cp    r22,     XL
	brcc  sp2_2ina         ; ( 9 / 10)
	mul   r22,     r24     ; (11) r24 = 3; 12px wide sprites
	ld    YL,      Z+      ; (13) OffLo
	add   YL,      r0
	ld    YH,      Z+      ; (16) OffHi + Mirror on bit 7
	adc   YH,      r1
	ld    XL,      Z+      ; (19) XPos
	ld    r3,      Z+      ; (21) Color 1
	ld    r4,      Z+      ; (23) Color 2
	ld    r5,      Z+      ; (25) Color 3
	brmi  sp2_2mir         ; (26 / 27) Mirroring flag
	cpi   YH,      0x71    ; (27)
	brcc  sp2_2mra         ; (28 / 29)
	movw  ZL,      YL      ; (29)
	lpm   r21,     Z+      ; (32)
	lpm   r1,      Z+      ; (35)
	lpm   r0,      Z+      ; (38)
sp2_2mre:
	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	rjmp  sp2_2mie         ; (41)
sp2_2mra:
	subi  YH,      0x70    ; (30)
	ld    r21,     Y+      ; (32)
	ld    r1,      Y+      ; (34)
	ld    r0,      Y+      ; (36)
	rjmp  sp2_2mre         ; (38)
sp2_2ina:
	brne  sp2_2nnx         ; (11 / 12)
	rcall sp_next          ; (69)
	WAIT  YL,      24
	rjmp  sp2_2end         ; (95)
sp2_2nnx:
	WAIT  YL,      81
	rjmp  sp2_2end         ; (95)
sp2_2nra:
	subi  YH,      0xF0    ; (31)
	ld    r0,      Y+      ; (33)
	ld    r1,      Y+      ; (35)
	ld    r21,     Y+      ; (37)
	nop
	rjmp  sp2_2nre         ; (40)
sp2_2mir:
	cpi   YH,      0xF1    ; (28)
	brcc  sp2_2nra         ; (29 / 30)
	andi  YH,      0x7F    ; (30)
	movw  ZL,      YL      ; (31)
	lpm   r0,      Z+      ; (34)
	lpm   r1,      Z+      ; (37)
	lpm   r21,     Z+      ; (40)
sp2_2nre:
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
sp2_2mie:
	mov   ZL,      r21     ; (42)
	icall                  ; (59)
	mov   ZL,      r1      ; (60)
	icall                  ; (77)
	mov   ZL,      r0      ; (78)
	icall                  ; (95)
sp2_2end:


	; ( 270) Sprite 1 (95 + 6)

	; --- (Preload) ---
	lds   r22,     (v_sprd + (10 * 0) + 0) ; YPos
	add   r22,     r18     ; Line within sprite acquired
	lds   r23,     (v_sprd + (10 * 0) + 1) ; Height
	; -----------------
	ldi   ZL,      lo8(v_sprd + (10 * 1))
	ldi   ZH,      hi8(v_sprd + (10 * 1))
	ld    r0,      Z+      ; ( 4) YPos
	add   r0,      r18     ; ( 5) Line within sprite acquired
	ld    XL,      Z+      ; ( 7) Height
	cp    r0,      XL
	brcc  sp2_1ina         ; ( 9 / 10)
	mul   r0,      r24     ; (11) r24 = 3; 12px wide sprites
	ld    YL,      Z+      ; (13) OffLo
	add   YL,      r0
	ld    YH,      Z+      ; (16) OffHi + Mirror on bit 7
	adc   YH,      r1
	ld    XL,      Z+      ; (19) XPos
	ld    r3,      Z+      ; (21) Color 1
	ld    r4,      Z+      ; (23) Color 2
	ld    r5,      Z+      ; (25) Color 3
	brmi  sp2_1mir         ; (26 / 27) Mirroring flag
	cpi   YH,      0x71    ; (27)
	brcc  sp2_1mra         ; (28 / 29)
	movw  ZL,      YL      ; (29)
	lpm   r21,     Z+      ; (32)
	lpm   r1,      Z+      ; (35)
	lpm   r0,      Z+      ; (38)
sp2_1mre:
	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	rjmp  sp2_1mie         ; (41)
sp2_1mra:
	subi  YH,      0x70    ; (30)
	ld    r21,     Y+      ; (32)
	ld    r1,      Y+      ; (34)
	ld    r0,      Y+      ; (36)
	rjmp  sp2_1mre         ; (38)
sp2_1ina:
	brne  sp2_1nnx         ; (11 / 12)
	rcall sp_next          ; (69)
	WAIT  YL,      7
	rjmp  sp2_1nne         ; (78)
sp2_1nnx:
	WAIT  YL,      66
sp2_1nne:
	; --- (Display) ---
	out   PIXOUT,  r17     ; ( 354) Next scanline colored border begins
	; -----------------
	WAIT  YL,      15
	rjmp  sp2_1end         ; (95)
sp2_1nra:
	subi  YH,      0xF0    ; (31)
	ld    r0,      Y+      ; (33)
	ld    r1,      Y+      ; (35)
	ld    r21,     Y+      ; (37)
	nop
	rjmp  sp2_1nre         ; (40)
sp2_1mir:
	cpi   YH,      0xF1    ; (28)
	brcc  sp2_1nra         ; (29 / 30)
	andi  YH,      0x7F    ; (30)
	movw  ZL,      YL      ; (31)
	lpm   r0,      Z+      ; (34)
	lpm   r1,      Z+      ; (37)
	lpm   r21,     Z+      ; (40)
sp2_1nre:
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
sp2_1mie:
	mov   ZL,      r21     ; (42)
	icall                  ; (59)
	mov   ZL,      r1      ; (60)
	icall                  ; (77)
	mov   ZL,      r0      ; (78)
	; --- (Display) ---
	out   PIXOUT,  r17     ; ( 354) Next scanline colored border begins
	; -----------------
	icall                  ; (95)
sp2_1end:


	; ( 371) Sprite 0 (95 - 5)

	ldi   ZL,      lo8(v_sprd + (10 * 0) + 2)
	ldi   ZH,      hi8(v_sprd + (10 * 0) + 2)
	cp    r22,     r23
	brcc  sp2_0ina         ; ( 9 / 10)
	mul   r22,     r24     ; (11) r24 = 3; 12px wide sprites
	ld    YL,      Z+      ; (13) OffLo
	add   YL,      r0
	ld    YH,      Z+      ; (16) OffHi + Mirror on bit 7
	adc   YH,      r1
	ld    XL,      Z+      ; (19) XPos
	ld    r3,      Z+      ; (21) Color 1
	ld    r4,      Z+      ; (23) Color 2
	ld    r5,      Z+      ; (25) Color 3
	brmi  sp2_0mir         ; (26 / 27) Mirroring flag
	cpi   YH,      0x71    ; (27)
	brcc  sp2_0mra         ; (28 / 29)
	movw  ZL,      YL      ; (29)
	lpm   r21,     Z+      ; (32)
	lpm   r1,      Z+      ; (35)
	lpm   r0,      Z+      ; (38)
sp2_0mre:
	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
	rjmp  sp2_0mie         ; (41)
sp2_0mra:
	subi  YH,      0x70    ; (30)
	ld    r21,     Y+      ; (32)
	ld    r1,      Y+      ; (34)
	ld    r0,      Y+      ; (36)
	rjmp  sp2_0mre         ; (38)
sp2_0ina:
	brne  sp2_0nnx         ; (11 / 12)
	rcall sp_next          ; (69)
	WAIT  YL,      24
	rjmp  sp2_0end         ; (95)
sp2_0nnx:
	WAIT  YL,      81
	rjmp  sp2_0end         ; (95)
sp2_0nra:
	subi  YH,      0xF0    ; (31)
	ld    r0,      Y+      ; (33)
	ld    r1,      Y+      ; (35)
	ld    r21,     Y+      ; (37)
	nop
	rjmp  sp2_0nre         ; (40)
sp2_0mir:
	cpi   YH,      0xF1    ; (28)
	brcc  sp2_0nra         ; (29 / 30)
	andi  YH,      0x7F    ; (30)
	movw  ZL,      YL      ; (31)
	lpm   r0,      Z+      ; (34)
	lpm   r1,      Z+      ; (37)
	lpm   r21,     Z+      ; (40)
sp2_0nre:
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
sp2_0mie:
	mov   ZL,      r21     ; (42)
	icall                  ; (59)
	mov   ZL,      r1      ; (60)
	icall                  ; (77)
	mov   ZL,      r0      ; (78)
	icall                  ; (95)
sp2_0end:


	; ( 461) Go on to next line

	ldi   ZL,      15
	out   STACKL,  ZL
	pop   r0
	out   PIXOUT,  r0      ; ( 466) Pixel 0
	jmp   m72_graf_scan_b



;
; Routine sp_next for sprite 3
;
sp2_3next:

	ldd   YL,      Z + 6   ; ( 5) NextLo
	ldd   YH,      Z + 7   ; ( 7) NextHi
	sbiw  Z,       2
	cpi   YH,      0
	breq  sp2_3next_lie    ; (11 / 12)
	ld    r21,     Y+
	st    Z+,      r21     ; (15) YPos
	ld    r21,     Y+
	st    Z+,      r21     ; (19) Height
	ld    r21,     Y+
	st    Z+,      r21     ; (23) OffLo
	ld    r21,     Y+
	st    Z+,      r21     ; (27) OffHi
	ld    r21,     Y+
	cpi   r21,     176
	brcs  .+2
	ldi   r21,     176
	st    Z+,      r21     ; (34) XPos
	ld    r21,     Y+
	st    Z+,      r21     ; (38) Col0
	ld    r21,     Y+
	st    Z+,      r21     ; (42) Col1
	ld    r21,     Y+
	st    Z+,      r21     ; (46) Col2
	ld    r21,     Y+
	; --- (Display) ---
	sbi   SYNC,    SYNC_P  ; ( 141) Sync pulse goes high
	; -----------------
	st    Z+,      r21     ; (50) NextLo
	ld    r21,     Y+
	st    Z+,      r21     ; (54) NextHi
	ret                    ; (58)
sp2_3next_lie:
	st    Z+,      YH
	st    Z+,      YH      ; (16)
	adiw  Z,       8       ; (18)
	WAIT  r21,     30      ; (48)
	; --- (Display) ---
	sbi   SYNC,    SYNC_P  ; ( 141) Sync pulse goes high
	; -----------------
	WAIT  r21,     6       ; (54)
	ret                    ; (58)
