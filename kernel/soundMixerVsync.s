/*
 *  Uzebox Kernel
 *  Copyright (C) 2008 - 2009 Alec Bourque
 *                2018 Sandor Zsuga (Jubatian)
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

/*
 * Audio mixer than mixes the sound channels to a circular buffer during VSYNC.
 *
 */

#include <avr/io.h>
#include <defines.h>

.global update_sound_buffer
.global process_music
.global waves
.global mix_pos
.global mix_wpos
.global mix_buf
.global mix_bank
#if ((USER_AUDIO == 0) && (ENABLE_MIXER != 0))
.global mix_scnt
#endif
.global tr4_barrel_lo
.global tr4_barrel_hi
.global tr4_params
.global sound_enabled
.global update_sound

; Public variables
.global mixer



; For uzeboxSoundEngineCore.s

#define vol            0
#define step_lo        1
#define step_hi        2
#define samplepos_frac 3
#define samplepos_lo   4
#define samplepos_hi   5




.section .bss

mix_buf:          .space MIX_BUF_SIZE
mix_pos:          .space 2
mix_wpos:         .space 2
#if (MIX_BUF_SIZE == (2 * MIX_BANK_SIZE))
mix_bank:         .space 1
#endif
sound_enabled:    .space 1



#if (USER_AUDIO == 0)

	; struct MixerStruct -> soundEngine.h

mixer:
mixerStruct:

	tr1_vol:       .space 1
	tr1_step_lo:   .space 1
	tr1_step_hi:   .space 1
	tr1_pos_frac:  .space 1
	tr1_pos_lo:    .space 1
	tr1_pos_hi:    .space 1

	tr2_vol:       .space 1
	tr2_step_lo:   .space 1
	tr2_step_hi:   .space 1
	tr2_pos_frac:  .space 1
	tr2_pos_lo:    .space 1
	tr2_pos_hi:    .space 1

	tr3_vol:       .space 1
	tr3_step_lo:   .space 1
	tr3_step_hi:   .space 1
	tr3_pos_frac:  .space 1
	tr3_pos_lo:    .space 1
	tr3_pos_hi:    .space 1

#if (MIXER_CHAN4_TYPE == 0)
	tr4_vol:       .space 1
	tr4_params:    .space 1 ; bit0=>0=7,1=15 bits lfsr, b1:6=divider
	tr4_barrel_lo: .space 1
	tr4_barrel_hi: .space 1
	tr4_divider:   .space 1 ; current divider accumulator
	tr4_reserved1: .space 1
#else
	tr4_vol:       .space 1
	tr4_step_lo:   .space 1
	tr4_step_hi:   .space 1
	tr4_pos_frac:  .space 1
	tr4_pos_lo:    .space 1
	tr4_pos_hi:    .space 1
	tr4_loop_len_lo: .space 1
	tr4_loop_len_hi: .space 1
	tr4_loop_end_lo: .space 1
	tr4_loop_end_hi: .space 1
#endif

#endif

#if ((USER_AUDIO == 0) && (ENABLE_MIXER != 0))

mix_scnt:         .space 2     ; Sample counter for the mixer

#endif


.section .text



#if ((USER_AUDIO == 0) && (ENABLE_MIXER != 0))
;***********************
; Generates a MIX_SEGMENT_SIZE byte segment of audio. This function may be
; replaced by user code to build fully customized sound engines. Depending on
; the configuration of the sound engine (MIX_WAITVSYNC), this might be called
; from either main program or interrupt.
;
; The function can be a normal C function, however it can freely clobber all
; registers. This can be relied upon when creating assembler implementations,
; allowing them to be faster.
;
; Inputs:
; r25:r24: Target 8 byte audio buffer segment.
;***********************
Process_Audio_Segment:

	movw  XL,      r24     ; Target buffer

	; Load the mixer structure

	ldi   ZL,      lo8(mixer)
	ldi   ZH,      hi8(mixer)
	ldd   r16,     Z + 0   ; Channel1, vol
	ldd   r2,      Z + 1   ; Channel1, step_lo
	ldd   r3,      Z + 2   ; Channel1, step_hi
	ldd   r6,      Z + 3   ; Channel1, pos_frac
	ldd   r4,      Z + 4   ; Channel1, pos_lo
	ldd   r5,      Z + 5   ; Channel1, pos_hi
#if (SOUND_CHANNEL_2_ENABLE != 0)
	ldd   r17,     Z + 6   ; Channel2, vol
	ldd   r7,      Z + 7   ; Channel2, step_lo
	ldd   r8,      Z + 8   ; Channel2, step_hi
	ldd   r9,      Z + 9   ; Channel2, pos_frac
	ldd   r10,     Z + 10  ; Channel2, pos_lo
	ldd   r11,     Z + 11  ; Channel2, pos_hi
#endif
#if (SOUND_CHANNEL_3_ENABLE != 0)
	ldd   r18,     Z + 12  ; Channel3, vol
	ldd   r12,     Z + 13  ; Channel3, step_lo
	ldd   r13,     Z + 14  ; Channel3, step_hi
	ldd   r21,     Z + 15  ; Channel3, pos_frac
	ldd   r14,     Z + 16  ; Channel3, pos_lo
	ldd   r15,     Z + 17  ; Channel3, pos_hi
#endif
#if (SOUND_CHANNEL_4_ENABLE != 0)
	ldd   r19,     Z + 18  ; Channel4, vol
	ldd   r22,     Z + 19  ; Channel4, step_lo / params
	ldd   r23,     Z + 20  ; Channel4, step_hi / barrel_lo
	ldd   r24,     Z + 21  ; Channel4, pos_frac / barrel_hi
	ldd   YL,      Z + 22  ; Channel4, pos_lo / divider
	ldd   YH,      Z + 23  ; Channel4, pos_hi / reserved
#endif

	; Mix samples

	ldi   r25,     MIX_SEGMENT_SIZE ; Number of samples to do

pas_loop:

	; Mixing result is collected in r0:r1 (r0 is the high byte).
	; ZH:ZL is used as a temporary during processing.

	; Channel 1

	add   r6,      r2      ; pos_frac += step_lo
	adc   r4,      r3      ; pos_lo += step_hi + cy
	movw  ZL,      r4      ; pos
	lpm   r20,     Z       ; Load sample
	mulsu r20,     r16     ; sample * vol
	sbc   r0,      r0      ; Sign extend

	; Channel 2

#if (SOUND_CHANNEL_2_ENABLE != 0)
	add   r9,      r7      ; pos_frac += step_lo
	adc   r10,     r8      ; pos_lo += step_hi + cy
	movw  ZL,      r10     ; pos
	lpm   r20,     Z       ; Load sample
	movw  ZL,      r0
	mulsu r20,     r17     ; sample * vol
	sbc   r0,      r0      ; Sign extend
	add   r1,      ZH      ; Add ((sample * vol) >> 8) to mix buffer lsb
	adc   r0,      ZL      ; Adjust mix buffer msb
#endif

	; Channel 3

#if (SOUND_CHANNEL_3_ENABLE != 0)
	add   r21,     r12     ; pos_frac += step_lo
	adc   r14,     r13     ; pos_lo += step_hi + cy
	movw  ZL,      r14     ; pos
	lpm   r20,     Z       ; Load sample
	movw  ZL,      r0
	mulsu r20,     r18     ; sample * vol
	sbc   r0,      r0      ; Sign extend
	add   r1,      ZH      ; Add ((sample * vol) >> 8) to mix buffer lsb
	adc   r0,      ZL      ; Adjust mix buffer msb
#endif

	; Channel 4

#if (SOUND_CHANNEL_4_ENABLE != 0)
#if (MIXER_CHAN4_TYPE == 0)

	mov   ZH,      r19     ; vol
	lsr   ZH
	clc
	sbrc  r23,     0       ; If the LSB of the LFSR is zero
	neg   ZH               ; then produce sample (negative) for '0' (C set unless zero)
	sbc   ZL,      ZL      ; Sign extend
	add   r1,      ZH      ; Add sample to mix buffer lsb
	adc   r0,      ZL      ; Adjust mix buffer msb
	subi  YL,      2       ; Decrement divider bits 1..7 leaving bit 0 untouched by subtracting 2
	brcc  pas_noshift      ; If not enough ticks have elapsed then don't shift the LFSR
	mov   ZL,      r23     ; Perform the actual LFSR shifting by copying low byte of LFSR to a temp for XOR opperation
	lsr   r24              ; shift the 16 bits of the barrel shifter
	ror   r23              ; leaving the old bit 0 into Carry (Same bit used to decide +ve or -ve "sample" above)
	eor   ZL,      r23     ; perform the XOR of bit 0 and bit 1
	bst   ZL,      0       ; Save that XOR'd bit to T
	bld   r24,     6       ; Write T to the 15th bit of the LFSR (regardless of mode as 7 bit will overwrite it)
	mov   YL,      r22     ; Reload the divider / Parameters which consists of 7 bits of divider + 1 bit of mode
	sbrs  YL,      0       ; If the 7/14 mode bit indicates 7 bit mode then
	bld   r23,     6       ; Store T to the 7th bit of the LFSR
pas_noshift:

#else

	add   r24,     r22     ; pos_frac += step_lo
	adc   YL,      r23     ; pos_lo += step_hi + cy
	brcc  .+2
	inc   YH               ; pos_hi += cy
	lds   r20,     tr4_loop_end_lo
	cp    YL,      r20
	lds   r20,     tr4_loop_end_hi
	cpc   YH,      r20
	brcs  pas_noreset      ; Gone past end of sample?
	lds   YL,      tr4_loop_end_lo ; Note: The inline mixer differs here: It does not support 0 for loop length.
	lds   YH,      tr4_loop_end_hi ; However VSync mixer games expect it, and in the original VSync mixer it was implemented this way.
	lds   r20,     tr4_loop_len_lo
	sub   YL,      r20
	lds   r20,     tr4_loop_len_hi
	sbc   YH,      r20
pas_noreset:
	movw  ZL,      YL      ; pos
	lpm   r20,     Z       ; Load sample
	movw  ZL,      r0
	mulsu r20,     r19     ; sample * vol
	sbc   r0,      r0      ; Sign extend
	add   r1,      ZH      ; Add ((sample * vol) >> 8) to mix buffer lsb
	adc   r0,      ZL      ; Adjust mix buffer msb

#endif
#endif

	; Mixing of sample completed, clip result

	movw  ZL,      r0
	subi  ZH,      0x80
	sbci  ZL,      0xFF    ; Converts to unsigned
	brpl  .+4
	ldi   ZH,      0x00    ; Saturate from bottom to 0x00
	rjmp  .+6
	cpi   ZL,      0x00
	breq  .+2
	ldi   ZH,      0xFF    ; Saturate from top to 0xFF
	st    X+,      ZH      ; Store sound sample

	dec   r25
	brne  pas_loop
	clr   r1

	; Save mixer structure components which changed

	ldi   ZL,      lo8(mixer)
	ldi   ZH,      hi8(mixer)
	std   Z + 3,   r6      ; Channel1, pos_frac
	std   Z + 4,   r4      ; Channel1, pos_lo
#if (SOUND_CHANNEL_2_ENABLE != 0)
	std   Z + 9,   r9      ; Channel2, pos_frac
	std   Z + 10,  r10     ; Channel2, pos_lo
#endif
#if (SOUND_CHANNEL_3_ENABLE != 0)
	std   Z + 15,  r21     ; Channel3, pos_frac
	std   Z + 16,  r14     ; Channel3, pos_lo
#endif
#if (SOUND_CHANNEL_4_ENABLE != 0)
	std   Z + 20,  r23     ; Channel4, step_hi / barrel_lo
	std   Z + 21,  r24     ; Channel4, pos_frac / barrel_hi
	std   Z + 22,  YL      ; Channel4, pos_lo / divider
	std   Z + 23,  YH      ; Channel4, pos_hi / reserved
#endif

	; Mixing is done, count processed samples and call music processing
	; once after every frame (MIX_BANK_SIZE samples).

	lds   r24,     mix_scnt + 0
	lds   r25,     mix_scnt + 1
	sbiw  r24,     MIX_SEGMENT_SIZE
	sts   mix_scnt + 0, r24
	sts   mix_scnt + 1, r25
	brcc  pas_nomusic
	subi  r24,     lo8(-(MIX_BANK_SIZE))
	sbci  r25,     hi8(-(MIX_BANK_SIZE))
	sts   mix_scnt + 0, r24
	sts   mix_scnt + 1, r25
	lds   ZL,      sound_enabled
	sbrc  ZL,      0
	jmp   ProcessMusic
pas_nomusic:

	ret

#endif




;***********************
; Mix sound and process music track
;***********************
process_music:

#if (MIX_BUF_SIZE == (2 * MIX_BANK_SIZE))
	; Compatibility: Keep using and flipping mix_bank. This only works if
	; process_music is called from the VSync interrupt, but it is
	; sufficient to run stuff using it.

	lds   ZL,      mix_bank
	ldi   ZH,      1
	eor   ZL,      ZH
	sts   mix_bank, ZL
#endif

#if (ENABLE_MIXER != 0)
	; Load current buffer read position. The position is handled in
	; interrupt, it could change between accessing the low / high half
	; of it. Avoid this by reading it until two consequent reads return
	; the same value (indicating no interrupt).

	ldi   ZL,      0
	ldi   ZH,      0
pmu_posrdl:
	movw  r24,     ZL
	lds   ZL,      mix_pos + 0
	lds   ZH,      mix_pos + 1
	cp    r24,     ZL
	cpc   r25,     ZH
	brne  pmu_posrdl

	; Load current write position & determine number of free bytes

	lds   r24,     mix_wpos + 0
	lds   r25,     mix_wpos + 1
	sub   ZL,      r24
	sbc   ZH,      r25
	brcc  .+4
	subi  ZL,      lo8(-(MIX_BUF_SIZE))
	sbci  ZH,      hi8(-(MIX_BUF_SIZE))

	; Save regs for Process_Audio_Segment

	push  r2
	push  r3
	push  r4
	push  r5
	push  r6
	push  r7
	push  r8
	push  r9
	push  r10
	push  r11
	push  r12
	push  r13
	push  r14
	push  r15
	push  r16
	push  r17
	push  YL
	push  YH

	; Run audio generation for the available space

pmu_aloop:
	sbiw  ZL,      MIX_SEGMENT_SIZE
	brcs  pmu_aloope
	push  ZL
	push  ZH
	push  r24
	push  r25
	call  Process_Audio_Segment
	pop   r25
	pop   r24
	pop   ZH
	pop   ZL
	adiw  r24,     MIX_SEGMENT_SIZE
	ldi   r20,     hi8(MIX_BUF_SIZE + mix_buf)
	cpi   r24,     lo8(MIX_BUF_SIZE + mix_buf)
	cpc   r25,     r20
	brlo  pmu_aloop
	ldi   r24,     lo8(mix_buf)
	ldi   r25,     hi8(mix_buf)
	rjmp  pmu_aloop
pmu_aloope:
	sts   mix_wpos + 0, r24
	sts   mix_wpos + 1, r25

	; Restore regs after Process_Audio_Segment

	pop   YH
	pop   YL
	pop   r17
	pop   r16
	pop   r15
	pop   r14
	pop   r13
	pop   r12
	pop   r11
	pop   r10
	pop   r9
	pop   r8
	pop   r7
	pop   r6
	pop   r5
	pop   r4
	pop   r3
	pop   r2
	clr   r1
#endif

	ret



;***********************
; Mixing buffer output
; In: ZL = video phase (1 = Pre-eq / Post-eq, 2 = Hsync, 0 = No sync)
;
; Total cycle count must be AUDIO_OUT_HSYNC_CYCLES in Hsync only, otherwise
; it can finish earlier or later. Sync pulse timings have to be maintained.
;
; Destroys: Z, r0, r1
;***********************

update_sound:

	push  r16
	push  r17
	push  r18
	push  ZL

	lds   ZL,      mix_pos
	lds   ZH,      mix_pos + 1

	ld    r16,     Z+
	sts   _SFR_MEM_ADDR(OCR2A), r16 ; Output sound byte

	; Compare + Wrap = 8 cycles fixed

	ldi   r16,     hi8(MIX_BUF_SIZE + mix_buf)
	cpi   ZL,      lo8(MIX_BUF_SIZE + mix_buf)
	cpc   ZH,      r16

	ldi   r16,     lo8(mix_buf)
	ldi   r17,     hi8(mix_buf)

	brlo  .+2
	movw  ZL,      r16

	sts   mix_pos, ZL
	sts   mix_pos + 1, ZH

	; Wait 24 cycles (there was an UART access code here which could not
	; be activated any more)

	ldi   ZL,      8
	dec   ZL
	brne  .-4

	pop   ZL
	pop   r18
	pop   r17
	pop   r16

	;--- Video sync update ( 68 cy LOW pulse) ---
	sbrc  ZL,      0
	sbi   _SFR_IO_ADDR(SYNC_PORT), SYNC_PIN
	;--------------------------------------------

	sbrc  ZL,      0
	ret

	ldi   ZH,      21
	dec   ZH
	brne  .-4

	;--- Video sync update (136 cy LOW pulse) ---
	sbrc  ZL,      1
	sbi   _SFR_IO_ADDR(SYNC_PORT), SYNC_PIN
	;--------------------------------------------

	ret
