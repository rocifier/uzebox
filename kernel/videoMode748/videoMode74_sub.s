;
; Uzebox Kernel - Video Mode 748 renderer sub
; Copyright (C) 2017 Sandor Zsuga (Jubatian)
;
; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License
; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;
; Uzebox is a reserved trade mark
;



.section .text



sub_video_mode74:

;
; Entry happens in cycle 467.
;



;
; Check for display enable
;
; If no display, then just consume the configured height without any of
; Mode 74's features
;

	lds   r19,     m74_config     ; ( 469)
	sbrs  r19,     7       ; ( 470 /  471)
	rjmp  ddis             ; ( 472) Display disabled



;
; Disable SPI RAM's Chip Select. This is done to cancel any ongoing SPI RAM
; operation if the video frame interrupted one.
;
; Cycles:  2
; Ends:    473
;
	sbi   SR_PORT, SR_PIN  ; ( 2)



;
; Set up video frame stack
;
; Cycles:  10
; Ends:    483
;

	in    r24,     STACKL  ; ( 1) Load stack address for restoration before return
	in    r25,     STACKH  ; ( 2) (Only actually used unless reset was enabled)
	sts   v_reset_lo, r24  ; ( 4) Save restore address
	sts   v_reset_hi, r25  ; ( 6)
	ldi   r24,     lo8(M74_VIDEO_STACK + 15) ; ( 7)
	ldi   r25,     hi8(M74_VIDEO_STACK + 15) ; ( 8)
	out   STACKL,  r24     ; ( 9) Init the empty Video stack
	out   STACKH,  r25     ; (10)



;
; Initialize SPI RAM
;
; Cycles:  76
; Ends:    559
;
	cbi   SR_PORT, SR_PIN  ; ( 2)
	ldi   r25,     0x03    ; ( 3) Read from SPI RAM
	out   SR_DR,   r25     ; ( 4)
	ldi   r25,     0x00    ; ( 5)
	sbrc  r19,     0       ; ( 6 /  7) SPI RAM bank select
	ldi   r25,     0x01    ; ( 7)
	M74WT_R24      14      ; (21)
	out   SR_DR,   r25     ; (22)
	lds   r22,     m74_saddr_lo ; (24)
	lds   r23,     m74_saddr_hi ; (26)
	M74WT_R24      13      ; (39)
	out   SR_DR,   r23     ; (40)
	M74WT_R24      17      ; (57)
	out   SR_DR,   r22     ; (58)
	M74WT_R24      17      ; (75)
	out   SR_DR,   r22     ; (76) Dummy byte for first fetch


;
; Load palette (m74_config is loaded into r19)
;
; Cycles: 773
; Ends:   1332
;

	ldi   YH,      hi8(M74_PALBUF)  ; ( 1)
#if (M74_PAL_PTRE != 0)
	lds   ZL,      m74_pal_lo   ; ( 3)
	lds   ZH,      m74_pal_hi   ; ( 5)
#else
	ldi   ZL,      lo8(M74_PAL_OFF) ; ( 2)
	ldi   ZH,      hi8(M74_PAL_OFF) ; ( 3)
	rjmp  .                ; ( 5)
#endif
#if (M74_COL0_DISABLE != 0)
	ldi   YL,      16      ; ( 6) Color 0 disabled: skip it
	adiw  ZL,      1       ; ( 8)
	M74WT_R24      46      ; (54)
#else
	clr   YL               ; ( 6)
#endif
lcloop:
	sbrs  r19,     3       ; ( 1) RAM / ROM palette
	rjmp  .+4              ; ( 3)
	ld    r24,     Z+      ; ( 4)
	rjmp  .+2              ; ( 6)
	lpm   r24,     Z+      ; ( 6)
	rcall m74_setpalcol    ; (45) (3 + 36 cycles)
	inc   YL               ; (46)
	brne  lcloop           ; (47 / 48) (767 cy total for the loop)



;
; Initialize scanline counters
; (m74_config is loaded into r19)
;
; Cycles: 10
; Ends:   1342
;

	clr   r16              ; ( 1) Scanline counter
#if (M74_ROWS_PTRE != 0)
	lds   ZL,      m74_rows_lo  ; ( 3)
	lds   ZH,      m74_rows_hi  ; ( 5)
#else
	ldi   ZL,      lo8(M74_ROWS_OFF) ; ( 2)
	ldi   ZH,      hi8(M74_ROWS_OFF) ; ( 3)
	rjmp  .                ; ( 5)
#endif
	; Load the first two values to get the initial scanline.
	ld    r17,     Z+      ; ( 7) Load first logical row counter
	adiw  ZL,      1       ; ( 9)
	movw  r14,     ZL      ; (10)



;
; Prepare for frame render loop
;
; Cycles: 6
; Ends:   1348
;

	lds   r25,     render_lines_count ; ( 2)
	lds   r22,     m74_tdesc_lo ; ( 4)
	lds   r23,     m74_tdesc_hi ; ( 6)



;
; Frame render loop
;
; Sandwiched between waits so it is simpler to shift it a bit around
; when tweaking the scanline loop.
;

	M74WT_R24      348     ; (1696)
	rjmp  m74_scloop       ; (1703)
m74_scloopr:
	M74WT_R24      110     ; (1813)



;
; Frame lead-out
;

	sbi   SR_PORT, SR_PIN  ; (1815) End SPI RAM access

	; Update the sync_pulse variable which was neglected during the loop
	; In r16 the scanline counter now equals render_lines_count, ready to
	; be subtracted.

	lds   r0,      sync_pulse ; (1817)
	sub   r0,      r16     ; (1818)
	sts   sync_pulse, r0   ; (1820 = 0)
	rcall hsync_pulse      ; Last hsync, from now cycle precise part over.

	; Set vsync flag & flip field

	lds   ZL,      sync_flags
	ldi   r20,     SYNC_FLAG_FIELD
	eor   ZL,      r20
	ori   ZL,      SYNC_FLAG_VSYNC
	sts   sync_flags, ZL

	; Clear any pending timer interrupt

	ldi   ZL,      (1<<OCF1A)
	sts   _SFR_MEM_ADDR(TIFR1), ZL



;
; Finalize, restoring stack as necessary
;
; (Not in cycle-synced part any more)
;

#if (M74_RESET_ENABLE != 0)
	lds   r24,     m74_reset_lo
	lds   r25,     m74_reset_hi
	mov   r1,      r24
	or    r1,      r25
	brne  lares            ; Zero: No reset, perform a normal return
#endif
	lds   r24,     v_reset_lo ; Normal return with no reset: restore original stack
	lds   r25,     v_reset_hi
	out   STACKL,  r24
	out   STACKH,  r25
	ret
#if (M74_RESET_ENABLE != 0)
lares:
	ldi   r22,     lo8(M74_MAIN_STACK - 1) ; Set up main program stack
	ldi   r23,     hi8(M74_MAIN_STACK - 1)
	out   STACKL,  r22
	out   STACKH,  r23
	clr   r1               ; For C language routines, r1 is zero
	push  r24              ; Return address is the reset vector
	push  r25
	reti
#endif



;
; Display Disabled frame. It still consumes the height set up by the kernel as
; the kernel requires that for proper function.
;

ddis:

	M74WT_R24      1814 - 472
	clr   r16              ; (1815) Scanline counter
ddisl:
	lds   r23,     render_lines_count ; (1817)
	cp    r23,     r16     ; (1818)
	breq  ddise            ; (1819 / 1820)
	inc   r16              ; (1820)
	rcall hsync_pulse      ; (21 + AUDIO)
	M74WT_R24      1813 - 21 - AUDIO_OUT_HSYNC_CYCLES
	rjmp  ddisl            ; (1815)

ddise:
	rcall hsync_pulse      ; Last hsync, from now cycle precise part over.

	; Set vsync flag & flip field

	lds   ZL,      sync_flags
	ldi   r20,     SYNC_FLAG_FIELD
	eor   ZL,      r20
	ori   ZL,      SYNC_FLAG_VSYNC
	sts   sync_flags, ZL

	; Clear any pending timer interrupt

	ldi   ZL,      (1<<OCF1A)
	sts   _SFR_MEM_ADDR(TIFR1), ZL

	ret                    ; All done






;
; Sets a color in the palette.
;
; YL:  The color index to set * 16
; r24: The color value to set
; YH:  Points at the palette buffer
;
m74_setpalcol:
	st    Y+,      r24     ; ( 2)
	st    Y+,      r24     ; ( 4)
	st    Y+,      r24     ; ( 6)
	st    Y+,      r24     ; ( 8)
	st    Y+,      r24     ; (10)
	st    Y+,      r24     ; (12)
	st    Y+,      r24     ; (14)
	st    Y+,      r24     ; (16)
	st    Y+,      r24     ; (18)
	st    Y+,      r24     ; (20)
	st    Y+,      r24     ; (22)
	st    Y+,      r24     ; (24)
	st    Y+,      r24     ; (26)
	st    Y+,      r24     ; (28)
	st    Y+,      r24     ; (30)
	st    Y,       r24     ; (32)
	ret                    ; (36)



;
; Waits the given amount of cycles, assuming calling with "rcall".
;
; This routine is used to reduce the size of the video mode, these waits
; taking only two words (ldi + rcall), yet having the same effect like the
; WAIT macro.
;
; r24: Number of cycles to wait - 11 (not including the "ldi r24, ...").
;      Must be at least 4.
;
m74_wait:
	lsr   r24
	brcs  .                ; +1 if bit0 was set
	lsr   r24
	brcs  .                ; +1 if bit1 was set
	brcs  .                ; +1 if bit1 was set
	dec   r24
	nop
	brne  .-6              ; 4 cycle loop
	ret

m74_wait_15:
	nop
m74_wait_14:
	nop
m74_wait_13:
	nop
m74_wait_12:
	nop
m74_wait_11:
	nop
m74_wait_10:
	nop
m74_wait_9:
	nop
m74_wait_8:
	nop
m74_wait_7:
	ret



;
; unsigned char M74_Finish(void);
;
; Always returns zero.
;
; Returns:
; r25:r24: 0 if succeed
;
M74_Finish:
	clr   r25
	clr   r24
	ret
