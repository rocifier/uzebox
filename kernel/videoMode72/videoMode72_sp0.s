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
; 8 pixels wide ROM (0x8000 - 0xEFFF) / RAM sprites
;
; Sprites are available in the following manner:
;
; +--------------+--------------+--------------+
; | m72_bull_cnt | Main sprites | Bullets      |
; +==============+==============+==============+
; |        0 - 1 |    8 (0 - 7) |    1 (0    ) |
; +--------------+--------------+--------------+
; |        2 -   |    6 (0 - 5) |    5 (0 - 4) |
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



;
; Entry point A
;
m72_sp0:

	ldi   ZL,      LB_STACK - 1 ; Back to video stack (at the end of the line buffer)
	out   STACKL,  ZL
	ldi   r24,     2            ; (1634) 8px wide sprites

	ldi   YL,      lo8(V_BUPT)
	ldi   YH,      hi8(V_BUPT)


	; (1636) Bullet 0 (36)

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
	brcc  sp0_b0_13        ; (18 / 19)
	lsr   r5               ; (19)
	brcc  sp0_b0_2         ; (20 / 21)
	cp    r5,      r4      ; (21)
	brcs  sp0_b0_i0        ; (22 / 23)
	st    X+,      r3      ; (24) 1st pixel
	st    X+,      r3      ; (26) 2nd pixel
	st    X+,      r3      ; (28) 3rd pixel
sp0_b0_1e:
	st    X+,      r3      ; (30) 4th pixel
	breq  sp0_b0_x1        ; (31 / 32) At last px of sprite: Load next sprite
	nop
sp0_b0_ni:
	adiw  YL,      2       ; (34)
	rjmp  sp0_b0end        ; (36)
sp0_b0_13:
	lsr   r5               ; (20)
	brcc  sp0_b0_1         ; (21 / 22)
	cp    r5,      r4      ; (22)
	brcs  sp0_b0_i1        ; (23 / 24)
	st    X+,      r3      ; (25) 1st pixel
sp0_b0_2e:
	st    X+,      r3      ; (27) 2nd pixel
	st    X+,      r3      ; (29) 3rd pixel
	breq  sp0_b0_x0        ; (30 / 31) At last px of sprite: Load next sprite
	rjmp  sp0_b0_ni        ; (32)
sp0_b0_2:
	cp    r5,      r4      ; (22)
	brcs  sp0_b0_i1        ; (23 / 24)
	rjmp  sp0_b0_2e        ; (25)
sp0_b0_1:
	cp    r5,      r4      ; (23)
	brcs  sp0_b0_i2        ; (24 / 25)
	rjmp  .                ; (26)
	rjmp  sp0_b0_1e        ; (28)
sp0_b0_i0:
	nop                    ; (24)
sp0_b0_i1:
	nop                    ; (25)
sp0_b0_i2:
	lpm   XL,      Z       ; (28)
	rjmp  .
	rjmp  sp0_b0_ni        ; (32)

sp0_bdec0:
	rjmp  sp0_bdec1        ; Bullet decision jump

sp0_b0_x0:
	nop
sp0_b0_x1:
	st    Y+,      ZL
	st    Y+,      ZH      ; (36)
sp0_b0end:


	; (1672) Sprite / Bullet decision

	cpi   r25,     2
	brcc  sp0_bdec0        ; 2 or more bullets


	; (1674) Sprite 7 (74 + 1)

	ldi   ZL,      lo8(v_sprd + (10 * 7))
	ldi   ZH,      hi8(v_sprd + (10 * 7))
	ld    r0,      Z+      ; ( 4) YPos
	add   r0,      r18     ; ( 5) Line within sprite acquired
	ld    XL,      Z+      ; ( 7) Height
	cp    r0,      XL
	brcc  sp0_7ina         ; ( 9 / 10)
	mul   r0,      r24     ; (11) r24 = 2; 8px wide sprites
	ld    YL,      Z+      ; (13) OffLo
	add   YL,      r0
	ld    YH,      Z+      ; (16) OffHi + Mirror on bit 7
	adc   YH,      r1
	ld    XL,      Z+      ; (19) XPos
	ld    r3,      Z+      ; (21) Color 1
	ld    r4,      Z+      ; (23) Color 2
	; --- (Display) ---
	out   PIXOUT,  r20     ; (1698) Black border
	; -----------------
	ld    r5,      Z+      ; (25) Color 3
	brpl  sp0_7nor         ; (26 / 27) Mirroring flag
	cpi   YH,      0xF1    ; (27)
	brcc  sp0_7mra         ; (28 / 29)
	movw  ZL,      YL      ; (29)
	lpm   r1,      Z+      ; (32)
	lpm   r0,      Z+      ; (35)
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	rjmp  sp0_7mie         ; (38)
sp0_7mra:
	subi  YH,      0xF0    ; (30)
	ld    r1,      Y+      ; (32)
	ld    r0,      Y+      ; (34)
	nop                    ; (35)
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	rjmp  sp0_7mie         ; (38)
sp0_7ina:
	brne  sp0_7nnx         ; (11 / 12)
	rcall sp0_7next        ; (69)
	WAIT  YL,      3 - 1   ; (72) (-1 for compensating padding in sp0_7next)
	rjmp  sp0_7end         ; (74)
sp0_7nnx:
	WAIT  YL,      11
	; --- (Display) ---
	out   PIXOUT,  r20     ; (1698) Black border
	; -----------------
	WAIT  YL,      49
	rjmp  sp0_7end         ; (74)
sp0_7nra:
	subi  YH,      0x70    ; (31)
	ld    r0,      Y+      ; (33)
	ld    r1,      Y+      ; (35)
	rjmp  sp0_7nre         ; (37)
sp0_7nor:
	cpi   YH,      0x71    ; (28)
	brcc  sp0_7nra         ; (29 / 30)
	ori   YH,      0x80    ; (30)
	movw  ZL,      YL      ; (31)
	lpm   r0,      Z+      ; (34)
	lpm   r1,      Z+      ; (37)
sp0_7nre:
	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
sp0_7mie:
	mov   ZL,      r0      ; (39)
	icall                  ; (56)
	mov   ZL,      r1      ; (57)
	icall                  ; (74)
sp0_7end:


	; (1749) Sprite 6 (74 + 2 + 4)

	ldi   ZL,      lo8(v_sprd + (10 * 6))
	ldi   ZH,      hi8(v_sprd + (10 * 6))
	ld    r0,      Z+      ; ( 4) YPos
	add   r0,      r18     ; ( 5) Line within sprite acquired
	ld    XL,      Z+      ; ( 7) Height
	cp    r0,      XL
	brcc  sp0_6ina         ; ( 9 / 10)
	mul   r0,      r24     ; (11) r24 = 2; 8px wide sprites
	ld    YL,      Z+      ; (13) OffLo
	add   YL,      r0
	ld    YH,      Z+      ; (16) OffHi + Mirror on bit 7
	adc   YH,      r1
	ld    XL,      Z+      ; (19) XPos
	ld    r3,      Z+      ; (21) Color 1
	ld    r4,      Z+      ; (23) Color 2
	ld    r5,      Z+      ; (25) Color 3
	brpl  sp0_6nor         ; (26 / 27) Mirroring flag
	cpi   YH,      0xF1    ; (27)
	brcc  sp0_6mra         ; (28 / 29)
	movw  ZL,      YL      ; (29)
	lpm   r1,      Z+      ; (32)
	lpm   r0,      Z+      ; (35)
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	rjmp  sp0_6mie         ; (38)
sp0_6mra:
	subi  YH,      0xF0    ; (30)
	ld    r1,      Y+      ; (32)
	ld    r0,      Y+      ; (34)
	nop                    ; (35)
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	rjmp  sp0_6mie         ; (38)
sp0_6ina:
	brne  sp0_6nnx         ; (11 / 12)
	rcall sp_next          ; (69)
	WAIT  YL,      3
	rjmp  sp0_6end         ; (74)
sp0_6nnx:
	WAIT  YL,      60
	rjmp  sp0_6end         ; (74)
sp0_6nra:
	subi  YH,      0x70    ; (31)
	ld    r0,      Y+      ; (33)
	ld    r1,      Y+      ; (35)
	rjmp  sp0_6nre         ; (37)
sp0_6nor:
	cpi   YH,      0x71    ; (28)
	brcc  sp0_6nra         ; (29 / 30)
	ori   YH,      0x80    ; (30)
	movw  ZL,      YL      ; (31)
	lpm   r0,      Z+      ; (34)
	lpm   r1,      Z+      ; (37)
sp0_6nre:
	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
sp0_6mie:
	mov   ZL,      r0      ; (39)
	icall                  ; (56)
	mov   ZL,      r1      ; (57)
	icall                  ; (74)
sp0_6end:
	; --- (Display) ---
	cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
	; --- (Padding) ---
	rjmp  .
	rjmp  sp0_6endx
	; -----------------


sp0_bdec1:

	; (1677) Sprite / Bullet decision

	lpm   ZL,      Z


	; (1681) Bullet 1 (36 + 2)

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
	nop
	; -----------------
	lsr   r5               ; (17)
	brcc  sp0_b1_13        ; (18 / 19)
	lsr   r5               ; (19)
	brcc  sp0_b1_2         ; (20 / 21)
	cp    r5,      r4      ; (21)
	brcs  sp0_b1_i0        ; (22 / 23)
	st    X+,      r3      ; (24) 1st pixel
	st    X+,      r3      ; (26) 2nd pixel
	st    X+,      r3      ; (28) 3rd pixel
sp0_b1_1e:
	st    X+,      r3      ; (30) 4th pixel
	breq  sp0_b1_x1        ; (31 / 32) At last px of sprite: Load next sprite
	nop
sp0_b1_ni:
	adiw  YL,      2       ; (34)
	rjmp  sp0_b1end        ; (36)
sp0_b1_13:
	lsr   r5               ; (20)
	brcc  sp0_b1_1         ; (21 / 22)
	cp    r5,      r4      ; (22)
	brcs  sp0_b1_i1        ; (23 / 24)
	st    X+,      r3      ; (25) 1st pixel
sp0_b1_2e:
	st    X+,      r3      ; (27) 2nd pixel
	st    X+,      r3      ; (29) 3rd pixel
	breq  sp0_b1_x0        ; (30 / 31) At last px of sprite: Load next sprite
	rjmp  sp0_b1_ni        ; (32)
sp0_b1_2:
	cp    r5,      r4      ; (22)
	brcs  sp0_b1_i1        ; (23 / 24)
	rjmp  sp0_b1_2e        ; (25)
sp0_b1_1:
	cp    r5,      r4      ; (23)
	brcs  sp0_b1_i2        ; (24 / 25)
	rjmp  .                ; (26)
	rjmp  sp0_b1_1e        ; (28)
sp0_b1_i0:
	nop                    ; (24)
sp0_b1_i1:
	nop                    ; (25)
sp0_b1_i2:
	lpm   XL,      Z       ; (28)
	rjmp  .
	rjmp  sp0_b1_ni        ; (32)
sp0_b1_x0:
	nop
sp0_b1_x1:
	st    Y+,      ZL
	st    Y+,      ZH      ; (36)
sp0_b1end:


	; (1719) Bullet 2 (36)

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
	brcc  sp0_b2_13        ; (18 / 19)
	lsr   r5               ; (19)
	brcc  sp0_b2_2         ; (20 / 21)
	cp    r5,      r4      ; (21)
	brcs  sp0_b2_i0        ; (22 / 23)
	st    X+,      r3      ; (24) 1st pixel
	st    X+,      r3      ; (26) 2nd pixel
	st    X+,      r3      ; (28) 3rd pixel
sp0_b2_1e:
	st    X+,      r3      ; (30) 4th pixel
	breq  sp0_b2_x1        ; (31 / 32) At last px of sprite: Load next sprite
	nop
sp0_b2_ni:
	adiw  YL,      2       ; (34)
	rjmp  sp0_b2end        ; (36)
sp0_b2_13:
	lsr   r5               ; (20)
	brcc  sp0_b2_1         ; (21 / 22)
	cp    r5,      r4      ; (22)
	brcs  sp0_b2_i1        ; (23 / 24)
	st    X+,      r3      ; (25) 1st pixel
sp0_b2_2e:
	st    X+,      r3      ; (27) 2nd pixel
	st    X+,      r3      ; (29) 3rd pixel
	breq  sp0_b2_x0        ; (30 / 31) At last px of sprite: Load next sprite
	rjmp  sp0_b2_ni        ; (32)
sp0_b2_2:
	cp    r5,      r4      ; (22)
	brcs  sp0_b2_i1        ; (23 / 24)
	rjmp  sp0_b2_2e        ; (25)
sp0_b2_1:
	cp    r5,      r4      ; (23)
	brcs  sp0_b2_i2        ; (24 / 25)
	rjmp  .                ; (26)
	rjmp  sp0_b2_1e        ; (28)
sp0_b2_i0:
	nop                    ; (24)
sp0_b2_i1:
	nop                    ; (25)
sp0_b2_i2:
	lpm   XL,      Z       ; (28)
	rjmp  .
	rjmp  sp0_b2_ni        ; (32)
sp0_b2_x0:
	nop
sp0_b2_x1:
	st    Y+,      ZL
	st    Y+,      ZH      ; (36)
sp0_b2end:


	; (1755) Bullet 3 (36)

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
	brcc  sp0_b3_13        ; (18 / 19)
	lsr   r5               ; (19)
	brcc  sp0_b3_2         ; (20 / 21)
	cp    r5,      r4      ; (21)
	brcs  sp0_b3_i0        ; (22 / 23)
	st    X+,      r3      ; (24) 1st pixel
	st    X+,      r3      ; (26) 2nd pixel
	st    X+,      r3      ; (28) 3rd pixel
sp0_b3_1e:
	st    X+,      r3      ; (30) 4th pixel
	breq  sp0_b3_x1        ; (31 / 32) At last px of sprite: Load next sprite
	nop
sp0_b3_ni:
	adiw  YL,      2       ; (34)
	rjmp  sp0_b3end        ; (36)
sp0_b3_13:
	lsr   r5               ; (20)
	brcc  sp0_b3_1         ; (21 / 22)
	cp    r5,      r4      ; (22)
	brcs  sp0_b3_i1        ; (23 / 24)
	st    X+,      r3      ; (25) 1st pixel
sp0_b3_2e:
	st    X+,      r3      ; (27) 2nd pixel
	st    X+,      r3      ; (29) 3rd pixel
	breq  sp0_b3_x0        ; (30 / 31) At last px of sprite: Load next sprite
	rjmp  sp0_b3_ni        ; (32)
sp0_b3_2:
	cp    r5,      r4      ; (22)
	brcs  sp0_b3_i1        ; (23 / 24)
	rjmp  sp0_b3_2e        ; (25)
sp0_b3_1:
	cp    r5,      r4      ; (23)
	brcs  sp0_b3_i2        ; (24 / 25)
	rjmp  .                ; (26)
	rjmp  sp0_b3_1e        ; (28)
sp0_b3_i0:
	nop                    ; (24)
sp0_b3_i1:
	nop                    ; (25)
sp0_b3_i2:
	lpm   XL,      Z       ; (28)
	rjmp  .
	rjmp  sp0_b3_ni        ; (32)
sp0_b3_x0:
	nop
sp0_b3_x1:
	st    Y+,      ZL
	st    Y+,      ZH      ; (36)
sp0_b3end:


	; (1791) Bullet 4 (36 + 2)

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
	brcc  sp0_b4_13        ; (18 / 19)
	lsr   r5               ; (19)
	brcc  sp0_b4_2         ; (20 / 21)
	cp    r5,      r4      ; (21)
	brcs  sp0_b4_i0        ; (22 / 23)
	st    X+,      r3      ; (24) 1st pixel
	st    X+,      r3      ; (26) 2nd pixel
	st    X+,      r3      ; (28) 3rd pixel
sp0_b4_1e:
	st    X+,      r3      ; (30) 4th pixel
	breq  sp0_b4_x1        ; (31 / 32) At last px of sprite: Load next sprite
	nop
sp0_b4_ni:
	; --- (Display) ---
	cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
	; -----------------
	adiw  YL,      2       ; (34)
	rjmp  sp0_b4end        ; (36)
sp0_b4_13:
	lsr   r5               ; (20)
	brcc  sp0_b4_1         ; (21 / 22)
	cp    r5,      r4      ; (22)
	brcs  sp0_b4_i1        ; (23 / 24)
	st    X+,      r3      ; (25) 1st pixel
sp0_b4_2e:
	st    X+,      r3      ; (27) 2nd pixel
	st    X+,      r3      ; (29) 3rd pixel
	breq  sp0_b4_x0        ; (30 / 31) At last px of sprite: Load next sprite
	rjmp  sp0_b4_ni        ; (32)
sp0_b4_2:
	cp    r5,      r4      ; (22)
	brcs  sp0_b4_i1        ; (23 / 24)
	rjmp  sp0_b4_2e        ; (25)
sp0_b4_1:
	cp    r5,      r4      ; (23)
	brcs  sp0_b4_i2        ; (24 / 25)
	rjmp  .                ; (26)
	rjmp  sp0_b4_1e        ; (28)
sp0_b4_i0:
	nop                    ; (24)
sp0_b4_i1:
	nop                    ; (25)
sp0_b4_i2:
	lpm   XL,      Z       ; (28)
	rjmp  .
	rjmp  sp0_b4_ni        ; (32)
sp0_b4_x0:
	nop
sp0_b4_x1:
	; --- (Display) ---
	cbi   SYNC,    SYNC_P  ; (   5) Sync pulse goes low
	; -----------------
	st    Y+,      ZL
	st    Y+,      ZH      ; (36)
sp0_b4end:

sp0_6endx:


	; (   9) Sprite 5 (74)

	ldi   ZL,      lo8(v_sprd + (10 * 5))
	ldi   ZH,      hi8(v_sprd + (10 * 5))
	ld    r0,      Z+      ; ( 4) YPos
	add   r0,      r18     ; ( 5) Line within sprite acquired
	ld    XL,      Z+      ; ( 7) Height
	cp    r0,      XL
	brcc  sp0_5ina         ; ( 9 / 10)
	mul   r0,      r24     ; (11) r24 = 2; 8px wide sprites
	ld    YL,      Z+      ; (13) OffLo
	add   YL,      r0
	ld    YH,      Z+      ; (16) OffHi + Mirror on bit 7
	adc   YH,      r1
	ld    XL,      Z+      ; (19) XPos
	ld    r3,      Z+      ; (21) Color 1
	ld    r4,      Z+      ; (23) Color 2
	ld    r5,      Z+      ; (25) Color 3
	brpl  sp0_5nor         ; (26 / 27) Mirroring flag
	cpi   YH,      0xF1    ; (27)
	brcc  sp0_5mra         ; (28 / 29)
	movw  ZL,      YL      ; (29)
	lpm   r1,      Z+      ; (32)
	lpm   r0,      Z+      ; (35)
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	rjmp  sp0_5mie         ; (38)
sp0_5mra:
	subi  YH,      0xF0    ; (30)
	ld    r1,      Y+      ; (32)
	ld    r0,      Y+      ; (34)
	nop                    ; (35)
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	rjmp  sp0_5mie         ; (38)
sp0_5ina:
	brne  sp0_5nnx         ; (11 / 12)
	rcall sp_next          ; (69)
	WAIT  YL,      3
	rjmp  sp0_5end         ; (74)
sp0_5nnx:
	WAIT  YL,      60
	rjmp  sp0_5end         ; (74)
sp0_5nra:
	subi  YH,      0x70    ; (31)
	ld    r0,      Y+      ; (33)
	ld    r1,      Y+      ; (35)
	rjmp  sp0_5nre         ; (38)
sp0_5nor:
	cpi   YH,      0x71    ; (28)
	brcc  sp0_5nra         ; (29 / 30)
	ori   YH,      0x80    ; (30)
	movw  ZL,      YL      ; (31)
	lpm   r0,      Z+      ; (34)
	lpm   r1,      Z+      ; (37)
sp0_5nre:
	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
sp0_5mie:
	mov   ZL,      r0      ; (39)
	icall                  ; (56)
	mov   ZL,      r1      ; (57)
	icall                  ; (74)
sp0_5end:


	; (  83) Sprite 4 (74 + 2 + 4)

	ldi   ZL,      lo8(v_sprd + (10 * 4))
	ldi   ZH,      hi8(v_sprd + (10 * 4))
	ld    r0,      Z+      ; ( 4) YPos
	add   r0,      r18     ; ( 5) Line within sprite acquired
	ld    XL,      Z+      ; ( 7) Height
	cp    r0,      XL
	brcc  sp0_4ina         ; ( 9 / 10)
	mul   r0,      r24     ; (11) r24 = 2; 8px wide sprites
	ld    YL,      Z+      ; (13) OffLo
	add   YL,      r0
	ld    YH,      Z+      ; (16) OffHi + Mirror on bit 7
	adc   YH,      r1
	ld    XL,      Z+      ; (19) XPos
	ld    r3,      Z+      ; (21) Color 1
	ld    r4,      Z+      ; (23) Color 2
	ld    r5,      Z+      ; (25) Color 3
	brpl  sp0_4nor         ; (26 / 27) Mirroring flag
	cpi   YH,      0xF1    ; (27)
	brcc  sp0_4mra         ; (28 / 29)
	movw  ZL,      YL      ; (29)
	lpm   r1,      Z+      ; (32)
	lpm   r0,      Z+      ; (35)
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	rjmp  sp0_4mie         ; (38)
sp0_4mra:
	subi  YH,      0xF0    ; (30)
	ld    r1,      Y+      ; (32)
	ld    r0,      Y+      ; (34)
	nop                    ; (35)
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	rjmp  sp0_4mie         ; (38)
sp0_4ina:
	brne  sp0_4nnx         ; (11 / 12)
	rcall sp0_4next        ; (69)
	WAIT  YL,      3 - 1   ; (72) (-1 for compensating padding in sp0_4next)
	rjmp  sp0_4end         ; (74)
sp0_4nnx:
	WAIT  YL,      44
	; --- (Display) ---
	sbi   SYNC,    SYNC_P  ; ( 141) Sync pulse goes high
	; -----------------
	WAIT  YL,      16
	rjmp  sp0_4end         ; (74)
sp0_4nra:
	subi  YH,      0x70    ; (31)
	ld    r0,      Y+      ; (33)
	ld    r1,      Y+      ; (35)
	rjmp  sp0_4nre         ; (37)
sp0_4nor:
	cpi   YH,      0x71    ; (28)
	brcc  sp0_4nra         ; (29 / 30)
	ori   YH,      0x80    ; (30)
	movw  ZL,      YL      ; (31)
	lpm   r0,      Z+      ; (34)
	lpm   r1,      Z+      ; (37)
sp0_4nre:
	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
sp0_4mie:
	mov   ZL,      r0      ; (39)
	icall                  ; (56)
	; --- (Display) ---
	sbi   SYNC,    SYNC_P  ; ( 141) Sync pulse goes high
	; -----------------
	mov   ZL,      r1      ; (57)
	icall                  ; (74)
sp0_4end:
	; --- (Padding) ---
	rjmp  .
	rjmp  .
	; -----------------


	; ( 163) Sprite 3 (74)

	ldi   ZL,      lo8(v_sprd + (10 * 3))
	ldi   ZH,      hi8(v_sprd + (10 * 3))
	ld    r0,      Z+      ; ( 4) YPos
	add   r0,      r18     ; ( 5) Line within sprite acquired
	ld    XL,      Z+      ; ( 7) Height
	cp    r0,      XL
	brcc  sp0_3ina         ; ( 9 / 10)
	mul   r0,      r24     ; (11) r24 = 2; 8px wide sprites
	ld    YL,      Z+      ; (13) OffLo
	add   YL,      r0
	ld    YH,      Z+      ; (16) OffHi + Mirror on bit 7
	adc   YH,      r1
	ld    XL,      Z+      ; (19) XPos
	ld    r3,      Z+      ; (21) Color 1
	ld    r4,      Z+      ; (23) Color 2
	ld    r5,      Z+      ; (25) Color 3
	brpl  sp0_3nor         ; (26 / 27) Mirroring flag
	cpi   YH,      0xF1    ; (27)
	brcc  sp0_3mra         ; (28 / 29)
	movw  ZL,      YL      ; (29)
	lpm   r1,      Z+      ; (32)
	lpm   r0,      Z+      ; (35)
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	rjmp  sp0_3mie         ; (38)
sp0_3mra:
	subi  YH,      0xF0    ; (30)
	ld    r1,      Y+      ; (32)
	ld    r0,      Y+      ; (34)
	nop                    ; (35)
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	rjmp  sp0_3mie         ; (38)
sp0_3ina:
	brne  sp0_3nnx         ; (11 / 12)
	rcall sp_next          ; (69)
	WAIT  YL,      3
	rjmp  sp0_3end         ; (74)
sp0_3nnx:
	WAIT  YL,      60
	rjmp  sp0_3end         ; (74)
sp0_3nra:
	subi  YH,      0x70    ; (31)
	ld    r0,      Y+      ; (33)
	ld    r1,      Y+      ; (35)
	rjmp  sp0_3nre         ; (37)
sp0_3nor:
	cpi   YH,      0x71    ; (28)
	brcc  sp0_3nra         ; (29 / 30)
	ori   YH,      0x80    ; (30)
	movw  ZL,      YL      ; (31)
	lpm   r0,      Z+      ; (34)
	lpm   r1,      Z+      ; (37)
sp0_3nre:
	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
sp0_3mie:
	mov   ZL,      r0      ; (39)
	icall                  ; (56)
	mov   ZL,      r1      ; (57)
	icall                  ; (74)
sp0_3end:


	; ( 237) Sprite 2 (74)

	ldi   ZL,      lo8(v_sprd + (10 * 2))
	ldi   ZH,      hi8(v_sprd + (10 * 2))
	ld    r0,      Z+      ; ( 4) YPos
	add   r0,      r18     ; ( 5) Line within sprite acquired
	ld    XL,      Z+      ; ( 7) Height
	cp    r0,      XL
	brcc  sp0_2ina         ; ( 9 / 10)
	mul   r0,      r24     ; (11) r24 = 2; 8px wide sprites
	ld    YL,      Z+      ; (13) OffLo
	add   YL,      r0
	ld    YH,      Z+      ; (16) OffHi + Mirror on bit 7
	adc   YH,      r1
	ld    XL,      Z+      ; (19) XPos
	ld    r3,      Z+      ; (21) Color 1
	ld    r4,      Z+      ; (23) Color 2
	ld    r5,      Z+      ; (25) Color 3
	brpl  sp0_2nor         ; (26 / 27) Mirroring flag
	cpi   YH,      0xF1    ; (27)
	brcc  sp0_2mra         ; (28 / 29)
	movw  ZL,      YL      ; (29)
	lpm   r1,      Z+      ; (32)
	lpm   r0,      Z+      ; (35)
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	rjmp  sp0_2mie         ; (38)
sp0_2mra:
	subi  YH,      0xF0    ; (30)
	ld    r1,      Y+      ; (32)
	ld    r0,      Y+      ; (34)
	nop                    ; (35)
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	rjmp  sp0_2mie         ; (38)
sp0_2ina:
	brne  sp0_2nnx         ; (11 / 12)
	rcall sp_next          ; (69)
	WAIT  YL,      3
	rjmp  sp0_2end         ; (74)
sp0_2nnx:
	WAIT  YL,      60
	rjmp  sp0_2end         ; (74)
sp0_2nra:
	subi  YH,      0x70    ; (31)
	ld    r0,      Y+      ; (33)
	ld    r1,      Y+      ; (35)
	rjmp  sp0_2nre         ; (37)
sp0_2nor:
	cpi   YH,      0x71    ; (28)
	brcc  sp0_2nra         ; (29 / 30)
	ori   YH,      0x80    ; (30)
	movw  ZL,      YL      ; (31)
	lpm   r0,      Z+      ; (34)
	lpm   r1,      Z+      ; (37)
sp0_2nre:
	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
sp0_2mie:
	mov   ZL,      r0      ; (39)
	icall                  ; (56)
	mov   ZL,      r1      ; (57)
	icall                  ; (74)
sp0_2end:


	; ( 311) Sprite 1 (74 + 3 + 1)

	; --- (Preload) ---
	lds   r20,     (v_sprd + (10 * 0) + 0) ; YPos
	add   r20,     r18     ; Line within sprite acquired
	; -----------------
	ldi   ZL,      lo8(v_sprd + (10 * 1))
	ldi   ZH,      hi8(v_sprd + (10 * 1))
	ld    r0,      Z+      ; ( 4) YPos
	add   r0,      r18     ; ( 5) Line within sprite acquired
	ld    XL,      Z+      ; ( 7) Height
	cp    r0,      XL
	brcc  sp0_1ina         ; ( 9 / 10)
	mul   r0,      r24     ; (11) r24 = 2; 8px wide sprites
	ld    YL,      Z+      ; (13) OffLo
	add   YL,      r0
	ld    YH,      Z+      ; (16) OffHi + Mirror on bit 7
	adc   YH,      r1
	ld    XL,      Z+      ; (19) XPos
	ld    r3,      Z+      ; (21) Color 1
	ld    r4,      Z+      ; (23) Color 2
	ld    r5,      Z+      ; (25) Color 3
	brpl  sp0_1nor         ; (26 / 27) Mirroring flag
	cpi   YH,      0xF1    ; (27)
	brcc  sp0_1mra         ; (28 / 29)
	movw  ZL,      YL      ; (29)
	lpm   r1,      Z+      ; (32)
	lpm   r0,      Z+      ; (35)
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	rjmp  sp0_1mie         ; (38)
sp0_1mra:
	subi  YH,      0xF0    ; (30)
	ld    r1,      Y+      ; (32)
	ld    r0,      Y+      ; (34)
	nop                    ; (35)
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	rjmp  sp0_1mie         ; (38)
sp0_1ina:
	brne  sp0_1nnx         ; (11 / 12)
	rcall sp0_1next        ; (69)
	WAIT  YL,      3 - 1   ; (72) (-1 for compensating padding in sp0_1next)
	rjmp  sp0_1end         ; (74)
sp0_1nnx:
	WAIT  YL,      27
	; --- (Display) ---
	out   PIXOUT,  r17     ; ( 354) Next scanline colored border begins
	; -----------------
	WAIT  YL,      33
	rjmp  sp0_1end         ; (74)
sp0_1nra:
	subi  YH,      0x70    ; (31)
	ld    r0,      Y+      ; (33)
	ld    r1,      Y+      ; (35)
	rjmp  sp0_1nre         ; (37)
sp0_1nor:
	cpi   YH,      0x71    ; (28)
	brcc  sp0_1nra         ; (29 / 30)
	ori   YH,      0x80    ; (30)
	movw  ZL,      YL      ; (31)
	lpm   r0,      Z+      ; (34)
	lpm   r1,      Z+      ; (37)
sp0_1nre:
	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
sp0_1mie:
	mov   ZL,      r0      ; (39)
	; --- (Display) ---
	out   PIXOUT,  r17     ; ( 354) Next scanline colored border begins
	; -----------------
	icall                  ; (56)
	mov   ZL,      r1      ; (57)
	icall                  ; (74)
sp0_1end:


	; ( 389) Sprite 0 (74 - 3)

	ldi   ZL,      lo8(v_sprd + (10 * 0) + 1)
	ldi   ZH,      hi8(v_sprd + (10 * 0) + 1)
	ld    XL,      Z+      ; ( 7) Height
	cp    r20,     XL
	brcc  sp0_0ina         ; ( 9 / 10)
	mul   r20,     r24     ; (11) r24 = 2; 8px wide sprites
	ld    YL,      Z+      ; (13) OffLo
	add   YL,      r0
	ld    YH,      Z+      ; (16) OffHi + Mirror on bit 7
	adc   YH,      r1
	ld    XL,      Z+      ; (19) XPos
	ld    r3,      Z+      ; (21) Color 1
	ld    r4,      Z+      ; (23) Color 2
	ld    r5,      Z+      ; (25) Color 3
	brpl  sp0_0nor         ; (26 / 27) Mirroring flag
	cpi   YH,      0xF1    ; (27)
	brcc  sp0_0mra         ; (28 / 29)
	movw  ZL,      YL      ; (29)
	lpm   r1,      Z+      ; (32)
	lpm   r0,      Z+      ; (35)
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	rjmp  sp0_0mie         ; (38)
sp0_0mra:
	subi  YH,      0xF0    ; (30)
	ld    r1,      Y+      ; (32)
	ld    r0,      Y+      ; (34)
	nop                    ; (35)
	ldi   ZH,      hi8(pm(m72_sp2bpp_mir))
	rjmp  sp0_0mie         ; (38)
sp0_0ina:
	brne  sp0_0nnx         ; (11 / 12)
	rcall sp_next          ; (69)
	WAIT  YL,      3
	rjmp  sp0_0end         ; (74)
sp0_0nnx:
	WAIT  YL,      60
	rjmp  sp0_0end         ; (74)
sp0_0nra:
	subi  YH,      0x70    ; (31)
	ld    r0,      Y+      ; (33)
	ld    r1,      Y+      ; (35)
	rjmp  sp0_0nre         ; (37)
sp0_0nor:
	cpi   YH,      0x71    ; (28)
	brcc  sp0_0nra         ; (29 / 30)
	ori   YH,      0x80    ; (30)
	movw  ZL,      YL      ; (31)
	lpm   r0,      Z+      ; (34)
	lpm   r1,      Z+      ; (37)
sp0_0nre:
	ldi   ZH,      hi8(pm(m72_sp2bpp_nor))
sp0_0mie:
	mov   ZL,      r0      ; (39)
	icall                  ; (56)
	mov   ZL,      r1      ; (57)
	icall                  ; (74)
sp0_0end:


	; ( 460) Padding

	nop

	; ( 461) Go on to next line

	ldi   ZL,      15
	out   STACKL,  ZL
	pop   r0
	out   PIXOUT,  r0      ; ( 466) Pixel 0
	jmp   m72_graf_scan_b



;
; Routine sp_next for sprite 6
;
sp0_1next:

	ldd   YL,      Z + 6   ; ( 5) NextLo
	ldd   YH,      Z + 7   ; ( 7) NextHi
	sbiw  Z,       2
	cpi   YH,      0
	breq  sp0_1next_lie    ; (11 / 12)
	ld    r21,     Y+
	st    Z+,      r21     ; (15) YPos
	ld    r21,     Y+
	st    Z+,      r21     ; (19) Height
	ld    r21,     Y+
	st    Z+,      r21     ; (23) OffLo
	ld    r21,     Y+
	st    Z+,      r21     ; (27) OffHi
	; --- (Display) ---
	nop
	out   PIXOUT,  r17     ; ( 354) Next scanline colored border begins
	; -----------------
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
	st    Z+,      r21     ; (50) NextLo
	ld    r21,     Y+
	st    Z+,      r21     ; (54) NextHi
	ret                    ; (58)
sp0_1next_lie:
	st    Z+,      YH
	st    Z+,      YH      ; (16)
	adiw  Z,       8       ; (18)
	WAIT  r21,     9 + 1   ; (27 + 1)
	; --- (Display) ---
	out   PIXOUT,  r17     ; ( 354) Next scanline colored border begins
	; -----------------
	WAIT  r21,     27      ; (54)
	ret                    ; (58)

;
; Routine sp_next for sprite 3
;
sp0_4next:

	ldd   YL,      Z + 6   ; ( 5) NextLo
	ldd   YH,      Z + 7   ; ( 7) NextHi
	sbiw  Z,       2
	cpi   YH,      0
	breq  sp0_4next_lie    ; (11 / 12)
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
	; --- (Display) ---
	nop
	sbi   SYNC,    SYNC_P  ; ( 141) Sync pulse goes high
	; -----------------
	st    Z+,      r21     ; (46) Col2
	ld    r21,     Y+
	st    Z+,      r21     ; (50) NextLo
	ld    r21,     Y+
	st    Z+,      r21     ; (54) NextHi
	ret                    ; (58)
sp0_4next_lie:
	st    Z+,      YH
	st    Z+,      YH      ; (16)
	adiw  Z,       8       ; (18)
	WAIT  r21,     26 + 1  ; (44 + 1)
	; --- (Display) ---
	sbi   SYNC,    SYNC_P  ; ( 141) Sync pulse goes high
	; -----------------
	WAIT  r21,     10      ; (54)
	ret                    ; (58)

;
; Routine sp_next for sprite 0
;
sp0_7next:

	ldd   YL,      Z + 6   ; ( 5) NextLo
	ldd   YH,      Z + 7   ; ( 7) NextHi
	sbiw  Z,       2
	cpi   YH,      0
	breq  sp0_7next_lie    ; (11 / 12)
	; --- (Display) ---
	nop
	out   PIXOUT,  r20     ; (1698) Black border
	; -----------------
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
	st    Z+,      r21     ; (50) NextLo
	ld    r21,     Y+
	st    Z+,      r21     ; (54) NextHi
	ret                    ; (58)
sp0_7next_lie:
	; --- (Display) ---
	out   PIXOUT,  r20     ; (1698) Black border
	nop
	; -----------------
	st    Z+,      YH
	st    Z+,      YH      ; (16)
	adiw  Z,       8       ; (18)
	WAIT  r21,     36      ; (54)
	ret                    ; (58)
