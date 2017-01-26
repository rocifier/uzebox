/*
 *  Uzebox Kernel - Mode 72, Text mode
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



.section .text



;
; Code block macro
;
; Register usage:
;
;  r3: r2: Color0:Color0
;  r5: r4: Color0:Color1
;  r7: r6: Color1:Color0
;  r9: r8: Color1:Color1
;
; A code block looks like as follows
;
;	out   PIXOUT,  r5/r4   ; Pixel 0 of tile
;	movw  r10,     r2/r4/r6/r8
;	movw  r12,     r2/r4/r6/r8
;	movw  r14,     r2/r4/r6/r8
;	out   PIXOUT,  r5/r4   ; Pixel 1 of tile
;	rjmp  m72_txt_common
;
.macro TXTBLK c0, c1, c2, c3, c4, c5, c6, c7
.if     ((\c0) == 0)
	out   PIXOUT,  r5
.else
	out   PIXOUT,  r4
.endif
.if     (((\c2) == 0) && ((\c3 == 0)))
	movw  r10,     r2
.elseif (((\c2) == 0) && ((\c3 != 0)))
	movw  r10,     r6
.elseif (((\c2) != 0) && ((\c3 == 0)))
	movw  r10,     r4
.else
	movw  r10,     r8
.endif
.if     (((\c4) == 0) && ((\c5 == 0)))
	movw  r12,     r2
.elseif (((\c4) == 0) && ((\c5 != 0)))
	movw  r12,     r6
.elseif (((\c4) != 0) && ((\c5 == 0)))
	movw  r12,     r4
.else
	movw  r12,     r8
.endif
.if     (((\c6) == 0) && ((\c7 == 0)))
	movw  r14,     r2
.elseif (((\c6) == 0) && ((\c7 != 0)))
	movw  r14,     r6
.elseif (((\c6) != 0) && ((\c7 == 0)))
	movw  r14,     r4
.else
	movw  r14,     r8
.endif
.if     ((\c1) == 0)
	out   PIXOUT,  r5
.else
	out   PIXOUT,  r4
.endif
	rjmp  m72_txt_common
.endm



;
; 3Kbytes Code block table (unaligned)
;
m72_txt_cblock:
	TXTBLK 0,0,0,0,0,0,0,0
	TXTBLK 0,0,0,0,0,0,0,1
	TXTBLK 0,0,0,0,0,0,1,0
	TXTBLK 0,0,0,0,0,0,1,1
	TXTBLK 0,0,0,0,0,1,0,0
	TXTBLK 0,0,0,0,0,1,0,1
	TXTBLK 0,0,0,0,0,1,1,0
	TXTBLK 0,0,0,0,0,1,1,1
	TXTBLK 0,0,0,0,1,0,0,0
	TXTBLK 0,0,0,0,1,0,0,1
	TXTBLK 0,0,0,0,1,0,1,0
	TXTBLK 0,0,0,0,1,0,1,1
	TXTBLK 0,0,0,0,1,1,0,0
	TXTBLK 0,0,0,0,1,1,0,1
	TXTBLK 0,0,0,0,1,1,1,0
	TXTBLK 0,0,0,0,1,1,1,1
	TXTBLK 0,0,0,1,0,0,0,0
	TXTBLK 0,0,0,1,0,0,0,1
	TXTBLK 0,0,0,1,0,0,1,0
	TXTBLK 0,0,0,1,0,0,1,1
	TXTBLK 0,0,0,1,0,1,0,0
	TXTBLK 0,0,0,1,0,1,0,1
	TXTBLK 0,0,0,1,0,1,1,0
	TXTBLK 0,0,0,1,0,1,1,1
	TXTBLK 0,0,0,1,1,0,0,0
	TXTBLK 0,0,0,1,1,0,0,1
	TXTBLK 0,0,0,1,1,0,1,0
	TXTBLK 0,0,0,1,1,0,1,1
	TXTBLK 0,0,0,1,1,1,0,0
	TXTBLK 0,0,0,1,1,1,0,1
	TXTBLK 0,0,0,1,1,1,1,0
	TXTBLK 0,0,0,1,1,1,1,1
	TXTBLK 0,0,1,0,0,0,0,0
	TXTBLK 0,0,1,0,0,0,0,1
	TXTBLK 0,0,1,0,0,0,1,0
	TXTBLK 0,0,1,0,0,0,1,1
	TXTBLK 0,0,1,0,0,1,0,0
	TXTBLK 0,0,1,0,0,1,0,1
	TXTBLK 0,0,1,0,0,1,1,0
	TXTBLK 0,0,1,0,0,1,1,1
	TXTBLK 0,0,1,0,1,0,0,0
	TXTBLK 0,0,1,0,1,0,0,1
	TXTBLK 0,0,1,0,1,0,1,0
	TXTBLK 0,0,1,0,1,0,1,1
	TXTBLK 0,0,1,0,1,1,0,0
	TXTBLK 0,0,1,0,1,1,0,1
	TXTBLK 0,0,1,0,1,1,1,0
	TXTBLK 0,0,1,0,1,1,1,1
	TXTBLK 0,0,1,1,0,0,0,0
	TXTBLK 0,0,1,1,0,0,0,1
	TXTBLK 0,0,1,1,0,0,1,0
	TXTBLK 0,0,1,1,0,0,1,1
	TXTBLK 0,0,1,1,0,1,0,0
	TXTBLK 0,0,1,1,0,1,0,1
	TXTBLK 0,0,1,1,0,1,1,0
	TXTBLK 0,0,1,1,0,1,1,1
	TXTBLK 0,0,1,1,1,0,0,0
	TXTBLK 0,0,1,1,1,0,0,1
	TXTBLK 0,0,1,1,1,0,1,0
	TXTBLK 0,0,1,1,1,0,1,1
	TXTBLK 0,0,1,1,1,1,0,0
	TXTBLK 0,0,1,1,1,1,0,1
	TXTBLK 0,0,1,1,1,1,1,0
	TXTBLK 0,0,1,1,1,1,1,1
	TXTBLK 0,1,0,0,0,0,0,0
	TXTBLK 0,1,0,0,0,0,0,1
	TXTBLK 0,1,0,0,0,0,1,0
	TXTBLK 0,1,0,0,0,0,1,1
	TXTBLK 0,1,0,0,0,1,0,0
	TXTBLK 0,1,0,0,0,1,0,1
	TXTBLK 0,1,0,0,0,1,1,0
	TXTBLK 0,1,0,0,0,1,1,1
	TXTBLK 0,1,0,0,1,0,0,0
	TXTBLK 0,1,0,0,1,0,0,1
	TXTBLK 0,1,0,0,1,0,1,0
	TXTBLK 0,1,0,0,1,0,1,1
	TXTBLK 0,1,0,0,1,1,0,0
	TXTBLK 0,1,0,0,1,1,0,1
	TXTBLK 0,1,0,0,1,1,1,0
	TXTBLK 0,1,0,0,1,1,1,1
	TXTBLK 0,1,0,1,0,0,0,0
	TXTBLK 0,1,0,1,0,0,0,1
	TXTBLK 0,1,0,1,0,0,1,0
	TXTBLK 0,1,0,1,0,0,1,1
	TXTBLK 0,1,0,1,0,1,0,0
	TXTBLK 0,1,0,1,0,1,0,1
	TXTBLK 0,1,0,1,0,1,1,0
	TXTBLK 0,1,0,1,0,1,1,1
	TXTBLK 0,1,0,1,1,0,0,0
	TXTBLK 0,1,0,1,1,0,0,1
	TXTBLK 0,1,0,1,1,0,1,0
	TXTBLK 0,1,0,1,1,0,1,1
	TXTBLK 0,1,0,1,1,1,0,0
	TXTBLK 0,1,0,1,1,1,0,1
	TXTBLK 0,1,0,1,1,1,1,0
	TXTBLK 0,1,0,1,1,1,1,1
	TXTBLK 0,1,1,0,0,0,0,0
	TXTBLK 0,1,1,0,0,0,0,1
	TXTBLK 0,1,1,0,0,0,1,0
	TXTBLK 0,1,1,0,0,0,1,1
	TXTBLK 0,1,1,0,0,1,0,0
	TXTBLK 0,1,1,0,0,1,0,1
	TXTBLK 0,1,1,0,0,1,1,0
	TXTBLK 0,1,1,0,0,1,1,1
	TXTBLK 0,1,1,0,1,0,0,0
	TXTBLK 0,1,1,0,1,0,0,1
	TXTBLK 0,1,1,0,1,0,1,0
	TXTBLK 0,1,1,0,1,0,1,1
	TXTBLK 0,1,1,0,1,1,0,0
	TXTBLK 0,1,1,0,1,1,0,1
	TXTBLK 0,1,1,0,1,1,1,0
	TXTBLK 0,1,1,0,1,1,1,1
	TXTBLK 0,1,1,1,0,0,0,0
	TXTBLK 0,1,1,1,0,0,0,1
	TXTBLK 0,1,1,1,0,0,1,0
	TXTBLK 0,1,1,1,0,0,1,1
	TXTBLK 0,1,1,1,0,1,0,0
	TXTBLK 0,1,1,1,0,1,0,1
	TXTBLK 0,1,1,1,0,1,1,0
	TXTBLK 0,1,1,1,0,1,1,1
	TXTBLK 0,1,1,1,1,0,0,0
	TXTBLK 0,1,1,1,1,0,0,1
	TXTBLK 0,1,1,1,1,0,1,0
	TXTBLK 0,1,1,1,1,0,1,1
	TXTBLK 0,1,1,1,1,1,0,0
	TXTBLK 0,1,1,1,1,1,0,1
	TXTBLK 0,1,1,1,1,1,1,0
	TXTBLK 0,1,1,1,1,1,1,1
	TXTBLK 1,0,0,0,0,0,0,0
	TXTBLK 1,0,0,0,0,0,0,1
	TXTBLK 1,0,0,0,0,0,1,0
	TXTBLK 1,0,0,0,0,0,1,1
	TXTBLK 1,0,0,0,0,1,0,0
	TXTBLK 1,0,0,0,0,1,0,1
	TXTBLK 1,0,0,0,0,1,1,0
	TXTBLK 1,0,0,0,0,1,1,1
	TXTBLK 1,0,0,0,1,0,0,0
	TXTBLK 1,0,0,0,1,0,0,1
	TXTBLK 1,0,0,0,1,0,1,0
	TXTBLK 1,0,0,0,1,0,1,1
	TXTBLK 1,0,0,0,1,1,0,0
	TXTBLK 1,0,0,0,1,1,0,1
	TXTBLK 1,0,0,0,1,1,1,0
	TXTBLK 1,0,0,0,1,1,1,1
	TXTBLK 1,0,0,1,0,0,0,0
	TXTBLK 1,0,0,1,0,0,0,1
	TXTBLK 1,0,0,1,0,0,1,0
	TXTBLK 1,0,0,1,0,0,1,1
	TXTBLK 1,0,0,1,0,1,0,0
	TXTBLK 1,0,0,1,0,1,0,1
	TXTBLK 1,0,0,1,0,1,1,0
	TXTBLK 1,0,0,1,0,1,1,1
	TXTBLK 1,0,0,1,1,0,0,0
	TXTBLK 1,0,0,1,1,0,0,1
	TXTBLK 1,0,0,1,1,0,1,0
	TXTBLK 1,0,0,1,1,0,1,1
	TXTBLK 1,0,0,1,1,1,0,0
	TXTBLK 1,0,0,1,1,1,0,1
	TXTBLK 1,0,0,1,1,1,1,0
	TXTBLK 1,0,0,1,1,1,1,1
	TXTBLK 1,0,1,0,0,0,0,0
	TXTBLK 1,0,1,0,0,0,0,1
	TXTBLK 1,0,1,0,0,0,1,0
	TXTBLK 1,0,1,0,0,0,1,1
	TXTBLK 1,0,1,0,0,1,0,0
	TXTBLK 1,0,1,0,0,1,0,1
	TXTBLK 1,0,1,0,0,1,1,0
	TXTBLK 1,0,1,0,0,1,1,1
	TXTBLK 1,0,1,0,1,0,0,0
	TXTBLK 1,0,1,0,1,0,0,1
	TXTBLK 1,0,1,0,1,0,1,0
	TXTBLK 1,0,1,0,1,0,1,1
	TXTBLK 1,0,1,0,1,1,0,0
	TXTBLK 1,0,1,0,1,1,0,1
	TXTBLK 1,0,1,0,1,1,1,0
	TXTBLK 1,0,1,0,1,1,1,1
	TXTBLK 1,0,1,1,0,0,0,0
	TXTBLK 1,0,1,1,0,0,0,1
	TXTBLK 1,0,1,1,0,0,1,0
	TXTBLK 1,0,1,1,0,0,1,1
	TXTBLK 1,0,1,1,0,1,0,0
	TXTBLK 1,0,1,1,0,1,0,1
	TXTBLK 1,0,1,1,0,1,1,0
	TXTBLK 1,0,1,1,0,1,1,1
	TXTBLK 1,0,1,1,1,0,0,0
	TXTBLK 1,0,1,1,1,0,0,1
	TXTBLK 1,0,1,1,1,0,1,0
	TXTBLK 1,0,1,1,1,0,1,1
	TXTBLK 1,0,1,1,1,1,0,0
	TXTBLK 1,0,1,1,1,1,0,1
	TXTBLK 1,0,1,1,1,1,1,0
	TXTBLK 1,0,1,1,1,1,1,1
	TXTBLK 1,1,0,0,0,0,0,0
	TXTBLK 1,1,0,0,0,0,0,1
	TXTBLK 1,1,0,0,0,0,1,0
	TXTBLK 1,1,0,0,0,0,1,1
	TXTBLK 1,1,0,0,0,1,0,0
	TXTBLK 1,1,0,0,0,1,0,1
	TXTBLK 1,1,0,0,0,1,1,0
	TXTBLK 1,1,0,0,0,1,1,1
	TXTBLK 1,1,0,0,1,0,0,0
	TXTBLK 1,1,0,0,1,0,0,1
	TXTBLK 1,1,0,0,1,0,1,0
	TXTBLK 1,1,0,0,1,0,1,1
	TXTBLK 1,1,0,0,1,1,0,0
	TXTBLK 1,1,0,0,1,1,0,1
	TXTBLK 1,1,0,0,1,1,1,0
	TXTBLK 1,1,0,0,1,1,1,1
	TXTBLK 1,1,0,1,0,0,0,0
	TXTBLK 1,1,0,1,0,0,0,1
	TXTBLK 1,1,0,1,0,0,1,0
	TXTBLK 1,1,0,1,0,0,1,1
	TXTBLK 1,1,0,1,0,1,0,0
	TXTBLK 1,1,0,1,0,1,0,1
	TXTBLK 1,1,0,1,0,1,1,0
	TXTBLK 1,1,0,1,0,1,1,1
	TXTBLK 1,1,0,1,1,0,0,0
	TXTBLK 1,1,0,1,1,0,0,1
	TXTBLK 1,1,0,1,1,0,1,0
	TXTBLK 1,1,0,1,1,0,1,1
	TXTBLK 1,1,0,1,1,1,0,0
	TXTBLK 1,1,0,1,1,1,0,1
	TXTBLK 1,1,0,1,1,1,1,0
	TXTBLK 1,1,0,1,1,1,1,1
	TXTBLK 1,1,1,0,0,0,0,0
	TXTBLK 1,1,1,0,0,0,0,1
	TXTBLK 1,1,1,0,0,0,1,0
	TXTBLK 1,1,1,0,0,0,1,1
	TXTBLK 1,1,1,0,0,1,0,0
	TXTBLK 1,1,1,0,0,1,0,1
	TXTBLK 1,1,1,0,0,1,1,0
	TXTBLK 1,1,1,0,0,1,1,1
	TXTBLK 1,1,1,0,1,0,0,0
	TXTBLK 1,1,1,0,1,0,0,1
	TXTBLK 1,1,1,0,1,0,1,0
	TXTBLK 1,1,1,0,1,0,1,1
	TXTBLK 1,1,1,0,1,1,0,0
	TXTBLK 1,1,1,0,1,1,0,1
	TXTBLK 1,1,1,0,1,1,1,0
	TXTBLK 1,1,1,0,1,1,1,1
	TXTBLK 1,1,1,1,0,0,0,0
	TXTBLK 1,1,1,1,0,0,0,1
	TXTBLK 1,1,1,1,0,0,1,0
	TXTBLK 1,1,1,1,0,0,1,1
	TXTBLK 1,1,1,1,0,1,0,0
	TXTBLK 1,1,1,1,0,1,0,1
	TXTBLK 1,1,1,1,0,1,1,0
	TXTBLK 1,1,1,1,0,1,1,1
	TXTBLK 1,1,1,1,1,0,0,0
	TXTBLK 1,1,1,1,1,0,0,1
	TXTBLK 1,1,1,1,1,0,1,0
	TXTBLK 1,1,1,1,1,0,1,1
	TXTBLK 1,1,1,1,1,1,0,0
	TXTBLK 1,1,1,1,1,1,0,1
	TXTBLK 1,1,1,1,1,1,1,0
	TXTBLK 1,1,1,1,1,1,1,1



;
; Common processing code
;
;  r0: r1: Temp
;  r2- r9: Filled with colors as described at the code block macro
; r10-r15: Temp (colors to out)
;     r17: Border color
;     r19: Row counter (only to be incremented upon return)
;     r20: Tile counter
;     r22: Preloaded with 6 (code block size in words)
;     r23: Tile row select in ROM
;       Y: VRAM pointer
;       Z: Temp
;
; Enter in cycle 447 with r10-r15 set to border color (r17), r20 set to 40.
;
m72_txt_common:
	out   PIXOUT,  r10     ; Pixel 2 of tile
	dec   r20              ; Remaining tiles
	breq  txt_exit
txt_entry:
	mov   ZH,      r23     ; Tile row to use
	out   PIXOUT,  r11     ; Pixel 3 of tile
	ld    ZL,      Y+
	out   PIXOUT,  r12     ; Pixel 4 of tile
	lpm   r0,      Z       ; Tile row pixel data
	out   PIXOUT,  r13     ; Pixel 5 of tile
	mul   r0,      r22     ; r22 = 6, size of code blocks (words)
	out   PIXOUT,  r14     ; Pixel 6 of tile
	movw  ZL,      r0
	subi  ZL,      lo8(-(pm(m72_txt_cblock)))
	sbci  ZH,      hi8(-(pm(m72_txt_cblock)))
	out   PIXOUT,  r15     ; Pixel 7 of tile
	ijmp
txt_exit:
	out   PIXOUT,  r11     ; Pixel 3 of tile
	rjmp  .
	out   PIXOUT,  r12     ; Pixel 4 of tile
	lpm   r0,      Z       ; Dummy load (nop)
	out   PIXOUT,  r13     ; Pixel 5 of tile
	rjmp  .
	out   PIXOUT,  r14     ; Pixel 6 of tile
	lpm   r0,      Z       ; Dummy load (nop)
	out   PIXOUT,  r15     ; Pixel 7 of tile
	inc   r19              ; Row counter increment
	andi  r19,     0x07
	out   PIXOUT,  r17     ; (1586) Colored border begins
	brne  .+2
	rjmp  .
	breq  .+2
	sbiw  YL,      40      ; (1591) Only increment VRAM if at end of tile row
	ret                    ; (1595)



;
; Text mode row entry point
;
;  r0: r1: Temp
;  r2- r3: Temp (will be used as described in Common proc. code)
;      r4: Foreground (1) color
;      r5: Background (0) color
;  r5- r9: Temp (will be used as described in Common proc. code)
; r10-r15: Temp (will be used as described in Common proc. code)
;     r17: Border color
;     r19: Row to render (low 3 bits used, incremented)
;     r20: Temp (will be used as described in Common proc. code)
; r22-r23: Temp (will be used as described in Common proc. code)
;       Y: VRAM pointer (increments by 40 at end of tile rows)
;       Z: Temp
;
; Enter in cycle 429.
;
m72_txt_row:

	lds   r23,     m72_charrom
	andi  r19,     0x07
	add   r23,     r19     ; Tile row select
	ldi   r20,     40      ; Count of tiles to render
	ldi   r22,     6       ; Code block size
	mov   r10,     r17
	mov   r11,     r17
	movw  r12,     r10
	movw  r14,     r10     ; Initializing to border color for warm-up tile
	mov   r2,      r5
	mov   r3,      r5
	mov   r6,      r5
	mov   r7,      r4
	mov   r8,      r4
	mov   r9,      r4      ; Initialize FG / BG color pairs
	rjmp  txt_entry        ; ( 447)
