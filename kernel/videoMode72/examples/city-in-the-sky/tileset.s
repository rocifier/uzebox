
;
; Mode 72 tileset of 20 tiles
;
;
; Total number of tile rows:  122
; Shared rows .............:    6
; Upper half only rows ....:   59
; Lower half only rows ....:   57
;
; Chosen generator mode ...:    1
;


#include <avr/io.h>
#define  PIXOUT   _SFR_IO_ADDR(PORTC)
#define  GPR0     _SFR_IO_ADDR(GPIOR0)
#define  GPR1     _SFR_IO_ADDR(GPIOR1)
#define  STACKL   0x3D
#define  LB_SPR   254
#ifndef  M72_ALIGNED_SEC
#define  M72_ALIGNED_SEC .text.align512
#endif


.global m72_defpalette
.global m72_deftilerows


.section .text



m72_defpalette:
	.byte 0xEF, 0x9D, 0x4B, 0x00, 0x52, 0x51, 0x49, 0x09
	.byte 0x9A, 0x52, 0x9A, 0x55, 0x0B, 0xB1, 0xF4, 0xFF



m72_deftilerows:
	rjmp  tilerow_0
	rjmp  tilerow_1
	rjmp  tilerow_2
	rjmp  tilerow_3
	rjmp  tilerow_4
	rjmp  tilerow_5
	rjmp  tilerow_6
	rjmp  tilerow_7

tilerow_0:
	ldi   ZH,      hi8(pm(tilerow_0_map))
	out   PIXOUT,  r1      ; ( 599) Pixel 19
	jmp   tilerow_entry_0

tilerow_1:
	ldi   ZH,      hi8(pm(tilerow_1_map))
	out   PIXOUT,  r1      ; ( 599) Pixel 19
	jmp   tilerow_entry_0

tilerow_2:
	ldi   ZH,      hi8(pm(tilerow_2_map))
	out   PIXOUT,  r1      ; ( 599) Pixel 19
	jmp   tilerow_entry_0

tilerow_3:
	ldi   ZH,      hi8(pm(tilerow_3_map))
	out   PIXOUT,  r1      ; ( 599) Pixel 19
	jmp   tilerow_entry_0

tilerow_4:
	ldi   ZH,      hi8(pm(tilerow_4_map))
	out   PIXOUT,  r1      ; ( 599) Pixel 19
	jmp   tilerow_entry_0

tilerow_5:
	ldi   ZH,      hi8(pm(tilerow_5_map))
	out   PIXOUT,  r1      ; ( 599) Pixel 19
	jmp   tilerow_entry_0

tilerow_6:
	ldi   ZH,      hi8(pm(tilerow_6_map))
	out   PIXOUT,  r1      ; ( 599) Pixel 19
	jmp   tilerow_entry_0

tilerow_7:
	ldi   ZH,      hi8(pm(tilerow_7_map))
	out   PIXOUT,  r1      ; ( 599) Pixel 19
	jmp   tilerow_entry_0



.section M72_ALIGNED_SEC




.balign 512


tilerow_common_0:
	out   PIXOUT,  r0
	breq  tilerow_exit_c_0 ; Uses Z flag
	pop   r0
tilerow_entry_0:
	dec   r20
	ld    ZL,      Y+
	out   PIXOUT,  r0
	pop   r0
	pop   r21
	pop   r1
	out   PIXOUT,  r0
	pop   r22
	pop   r23
	pop   r0
	out   PIXOUT,  r21
	rjmp  .
	ijmp
tilerow_exit_c_0:
	brts  tilerow_exit_0   ; (1582 / 1621)
	mov   r22,     r17
	mov   r23,     r17
	movw  r0,      r22
	out   PIXOUT,  r17
	ld    ZL,      Y+
	set
	ijmp
tilerow_exit_0:
	sbic  GPR0,    1       ; (1622) Color 0 (bg) loading enabled?
	in    r2,      GPR1    ; (1623) If so, load it
	sbic  GPR0,    2       ; (1624) Color 15 (border) loading enabled?
	in    r17,     GPR1    ; (1625) If so, load it
	ldi   ZL,      LB_SPR - 1 ; (1626) 254(HI):255(LO): Sprite conf
	out   STACKL,  ZL      ; (1627)
	ret                    ; (1631)


.balign 512
tilerow_0_map:
	rjmp  tilerow_block_0
	rjmp  tilerow_block_8
	rjmp  tilerow_block_16
	rjmp  tilerow_block_24
	rjmp  tilerow_block_30
	rjmp  tilerow_block_35
	rjmp  tilerow_block_41
	rjmp  tilerow_block_48
	rjmp  tilerow_block_55
	rjmp  tilerow_block_59
	rjmp  tilerow_block_65
	rjmp  tilerow_block_73
	rjmp  tilerow_block_79
	rjmp  tilerow_block_86
	rjmp  tilerow_block_89
	rjmp  tilerow_block_91
	rjmp  tilerow_block_95
	rjmp  tilerow_block_99
	rjmp  tilerow_block_106
	rjmp  tilerow_block_114
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0


.balign 512
tilerow_1_map:
	rjmp  tilerow_block_1
	rjmp  tilerow_block_9
	rjmp  tilerow_block_17
	rjmp  tilerow_block_25
	rjmp  tilerow_block_31
	rjmp  tilerow_block_36
	rjmp  tilerow_block_42
	rjmp  tilerow_block_49
	rjmp  tilerow_block_56
	rjmp  tilerow_block_60
	rjmp  tilerow_block_66
	rjmp  tilerow_block_74
	rjmp  tilerow_block_80
	rjmp  tilerow_block_34
	rjmp  tilerow_block_90
	rjmp  tilerow_block_92
	rjmp  tilerow_block_96
	rjmp  tilerow_block_100
	rjmp  tilerow_block_107
	rjmp  tilerow_block_115
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1


.balign 512
tilerow_2_map:
	rjmp  tilerow_block_2
	rjmp  tilerow_block_10
	rjmp  tilerow_block_18
	rjmp  tilerow_block_26
	rjmp  tilerow_block_32
	rjmp  tilerow_block_37
	rjmp  tilerow_block_43
	rjmp  tilerow_block_50
	rjmp  tilerow_block_56
	rjmp  tilerow_block_61
	rjmp  tilerow_block_67
	rjmp  tilerow_block_75
	rjmp  tilerow_block_80
	rjmp  tilerow_block_34
	rjmp  tilerow_block_34
	rjmp  tilerow_block_91
	rjmp  tilerow_block_34
	rjmp  tilerow_block_99
	rjmp  tilerow_block_108
	rjmp  tilerow_block_116
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2
	rjmp  tilerow_block_2


.balign 512
tilerow_3_map:
	rjmp  tilerow_block_3
	rjmp  tilerow_block_11
	rjmp  tilerow_block_19
	rjmp  tilerow_block_26
	rjmp  tilerow_block_32
	rjmp  tilerow_block_38
	rjmp  tilerow_block_44
	rjmp  tilerow_block_49
	rjmp  tilerow_block_57
	rjmp  tilerow_block_62
	rjmp  tilerow_block_68
	rjmp  tilerow_block_75
	rjmp  tilerow_block_81
	rjmp  tilerow_block_34
	rjmp  tilerow_block_34
	rjmp  tilerow_block_34
	rjmp  tilerow_block_34
	rjmp  tilerow_block_101
	rjmp  tilerow_block_109
	rjmp  tilerow_block_117
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3
	rjmp  tilerow_block_3

tilerow_block_32:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_34:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_44:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r7
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r7
	st    X+,      r11
	out   PIXOUT,  r23
	st    X+,      r11
	st    X+,      r11
	rjmp  tilerow_common_1
tilerow_block_55:
	out   PIXOUT,  r1
	st    X+,      r10
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r10
	st    X+,      r11
	out   PIXOUT,  r23
	st    X+,      r10
	st    X+,      r10
	rjmp  tilerow_common_1
tilerow_block_56:
	out   PIXOUT,  r1
	st    X+,      r10
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r23
	st    X+,      r10
	st    X+,      r10
	rjmp  tilerow_common_1
tilerow_block_92:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_0:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_1:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r6
	st    X+,      r11
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r3
	rjmp  tilerow_common_1
tilerow_block_2:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r9
	st    X+,      r11
	out   PIXOUT,  r22
	st    X+,      r11
	st    X+,      r8
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r3
	rjmp  tilerow_common_1
tilerow_block_3:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_8:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r3
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_1
tilerow_block_9:
	out   PIXOUT,  r1
	st    X+,      r3
	st    X+,      r3
	st    X+,      r3
	out   PIXOUT,  r22
	st    X+,      r3
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r6
	rjmp  tilerow_common_1
tilerow_block_10:
	out   PIXOUT,  r1
	st    X+,      r3
	st    X+,      r3
	st    X+,      r3
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_11:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r3
	st    X+,      r3
	out   PIXOUT,  r22
	st    X+,      r3
	st    X+,      r3
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_16:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r3
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r9
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_17:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r3
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_18:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r9
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_19:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r9
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_24:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r9
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_25:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r9
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_26:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r9
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r9
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_30:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r7
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r11
	rjmp  tilerow_common_1
tilerow_block_31:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r9
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_35:
	out   PIXOUT,  r1
	st    X+,      r11
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_36:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_37:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r11
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_38:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r11
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_41:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r11
	st    X+,      r11
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r7
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_42:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r7
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r7
	st    X+,      r7
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r11
	rjmp  tilerow_common_1
tilerow_block_43:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r8
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r7
	st    X+,      r7
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r11
	rjmp  tilerow_common_1
tilerow_block_48:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r7
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r23
	st    X+,      r11
	st    X+,      r11
	rjmp  tilerow_common_1
tilerow_block_49:
	out   PIXOUT,  r1
	st    X+,      r11
	st    X+,      r7
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r23
	st    X+,      r11
	st    X+,      r11
	rjmp  tilerow_common_1
tilerow_block_50:
	out   PIXOUT,  r1
	st    X+,      r11
	st    X+,      r11
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r10
	st    X+,      r11
	out   PIXOUT,  r23
	st    X+,      r11
	st    X+,      r11
	rjmp  tilerow_common_1
tilerow_block_57:
	out   PIXOUT,  r1
	st    X+,      r11
	st    X+,      r11
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r11
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r23
	st    X+,      r10
	st    X+,      r10
	rjmp  tilerow_common_1
tilerow_block_59:
	out   PIXOUT,  r1
	st    X+,      r10
	st    X+,      r12
	st    X+,      r11
	out   PIXOUT,  r22
	st    X+,      r11
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r11
	rjmp  tilerow_common_1
tilerow_block_60:
	out   PIXOUT,  r1
	st    X+,      r10
	st    X+,      r10
	st    X+,      r11
	out   PIXOUT,  r22
	st    X+,      r11
	st    X+,      r11
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r11
	rjmp  tilerow_common_1
tilerow_block_61:
	out   PIXOUT,  r1
	st    X+,      r10
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r11
	st    X+,      r10
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r12
	rjmp  tilerow_common_1
tilerow_block_62:
	out   PIXOUT,  r1
	st    X+,      r10
	st    X+,      r11
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r23
	st    X+,      r10
	st    X+,      r10
	rjmp  tilerow_common_1
tilerow_block_65:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r11
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r11
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r23
	st    X+,      r10
	st    X+,      r11
	rjmp  tilerow_common_1
tilerow_block_66:
	out   PIXOUT,  r1
	st    X+,      r11
	st    X+,      r10
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r12
	st    X+,      r10
	out   PIXOUT,  r23
	st    X+,      r10
	st    X+,      r11
	rjmp  tilerow_common_1
tilerow_block_67:
	out   PIXOUT,  r1
	st    X+,      r11
	st    X+,      r11
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r11
	st    X+,      r11
	st    X+,      r11
	out   PIXOUT,  r23
	st    X+,      r11
	st    X+,      r11
	rjmp  tilerow_common_1
tilerow_block_68:
	out   PIXOUT,  r1
	st    X+,      r11
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r11
	st    X+,      r11
	st    X+,      r11
	out   PIXOUT,  r23
	st    X+,      r11
	st    X+,      r11
	rjmp  tilerow_common_1
tilerow_block_73:
	out   PIXOUT,  r1
	st    X+,      r11
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r23
	st    X+,      r11
	st    X+,      r11
	rjmp  tilerow_common_1
tilerow_block_74:
	out   PIXOUT,  r1
	st    X+,      r11
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r23
	st    X+,      r10
	st    X+,      r11
	rjmp  tilerow_common_1
tilerow_block_75:
	out   PIXOUT,  r1
	st    X+,      r10
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r23
	st    X+,      r10
	st    X+,      r11
	rjmp  tilerow_common_1
tilerow_block_79:
	out   PIXOUT,  r1
	st    X+,      r11
	st    X+,      r7
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_80:
	out   PIXOUT,  r1
	st    X+,      r11
	st    X+,      r11
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r7
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_81:
	out   PIXOUT,  r1
	st    X+,      r11
	st    X+,      r11
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_86:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r4
	st    X+,      r4
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_89:
	out   PIXOUT,  r1
	st    X+,      r11
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_90:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_91:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_95:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r11
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r11
	rjmp  tilerow_common_1
tilerow_block_96:
	out   PIXOUT,  r1
	st    X+,      r11
	st    X+,      r11
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_99:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_100:
	out   PIXOUT,  r1
	st    X+,      r11
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_101:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r9
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_106:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r9
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_107:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_108:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r9
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r9
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_109:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r9
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_114:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r9
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r8
	st    X+,      r4
	out   PIXOUT,  r23
	st    X+,      r4
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_115:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r3
	st    X+,      r3
	out   PIXOUT,  r22
	st    X+,      r3
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_116:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r5
	rjmp  tilerow_common_1
tilerow_block_117:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r3
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r3
	st    X+,      r4
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_4:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r9
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_5:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_6:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r9
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_1
tilerow_block_7:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r9
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_12:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r6
	st    X+,      r3
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_13:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_14:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r11
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r11
	rjmp  tilerow_common_1
tilerow_block_15:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r9
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_20:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r9
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_21:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r9
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_22:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r9
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_1
tilerow_block_23:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_27:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r9
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r9
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_28:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r9
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r9
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_29:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r9
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r9
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r11
	rjmp  tilerow_common_1
tilerow_block_33:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_39:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r7
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r11
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_40:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r11
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_45:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r11
	st    X+,      r11
	st    X+,      r11
	out   PIXOUT,  r23
	st    X+,      r10
	st    X+,      r10
	rjmp  tilerow_common_1
tilerow_block_46:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r7
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r7
	st    X+,      r7
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r11
	rjmp  tilerow_common_1
tilerow_block_47:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r7
	st    X+,      r11
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r7
	st    X+,      r11
	out   PIXOUT,  r23
	st    X+,      r11
	st    X+,      r11
	rjmp  tilerow_common_1
tilerow_block_51:
	out   PIXOUT,  r1
	st    X+,      r10
	st    X+,      r11
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r23
	st    X+,      r11
	st    X+,      r11
	rjmp  tilerow_common_1
tilerow_block_52:
	out   PIXOUT,  r1
	st    X+,      r11
	st    X+,      r8
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r11
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r23
	st    X+,      r11
	st    X+,      r11
	rjmp  tilerow_common_1
tilerow_block_53:
	out   PIXOUT,  r1
	st    X+,      r11
	st    X+,      r7
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r23
	st    X+,      r11
	st    X+,      r10
	rjmp  tilerow_common_1
tilerow_block_54:
	out   PIXOUT,  r1
	st    X+,      r11
	st    X+,      r7
	st    X+,      r11
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r23
	st    X+,      r10
	st    X+,      r10
	rjmp  tilerow_common_1
tilerow_block_58:
	out   PIXOUT,  r1
	st    X+,      r10
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r23
	st    X+,      r10
	st    X+,      r12
	rjmp  tilerow_common_1
tilerow_block_63:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r12
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r23
	st    X+,      r10
	st    X+,      r10
	rjmp  tilerow_common_1
tilerow_block_64:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r10
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r23
	st    X+,      r10
	st    X+,      r10
	rjmp  tilerow_common_1
tilerow_block_69:
	out   PIXOUT,  r1
	st    X+,      r10
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r11
	st    X+,      r11
	st    X+,      r11
	out   PIXOUT,  r23
	st    X+,      r11
	st    X+,      r11
	rjmp  tilerow_common_1
tilerow_block_70:
	out   PIXOUT,  r1
	st    X+,      r10
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r11
	st    X+,      r11
	st    X+,      r11
	out   PIXOUT,  r23
	st    X+,      r10
	st    X+,      r10
	rjmp  tilerow_common_1
tilerow_block_71:
	out   PIXOUT,  r1
	st    X+,      r10
	st    X+,      r11
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r10
	st    X+,      r11
	out   PIXOUT,  r23
	st    X+,      r11
	st    X+,      r11
	rjmp  tilerow_common_1
tilerow_block_72:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r23
	st    X+,      r10
	st    X+,      r11
	rjmp  tilerow_common_1
tilerow_block_76:
	out   PIXOUT,  r1
	st    X+,      r10
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r23
	st    X+,      r11
	st    X+,      r11
	rjmp  tilerow_common_1
tilerow_block_77:
	out   PIXOUT,  r1
	st    X+,      r10
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r10
	st    X+,      r11
	out   PIXOUT,  r23
	st    X+,      r11
	st    X+,      r11
	rjmp  tilerow_common_1
tilerow_block_78:
	out   PIXOUT,  r1
	st    X+,      r11
	st    X+,      r10
	st    X+,      r11
	out   PIXOUT,  r22
	st    X+,      r11
	st    X+,      r10
	st    X+,      r11
	out   PIXOUT,  r23
	st    X+,      r10
	st    X+,      r10
	rjmp  tilerow_common_1
tilerow_block_82:
	out   PIXOUT,  r1
	st    X+,      r11
	st    X+,      r11
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r7
	st    X+,      r7
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_83:
	out   PIXOUT,  r1
	st    X+,      r11
	st    X+,      r7
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_84:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r7
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r11
	st    X+,      r11
	st    X+,      r11
	out   PIXOUT,  r23
	st    X+,      r11
	st    X+,      r11
	rjmp  tilerow_common_1
tilerow_block_85:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r10
	st    X+,      r11
	out   PIXOUT,  r22
	st    X+,      r11
	st    X+,      r11
	st    X+,      r11
	out   PIXOUT,  r23
	st    X+,      r11
	st    X+,      r11
	rjmp  tilerow_common_1
tilerow_block_87:
	out   PIXOUT,  r1
	st    X+,      r11
	st    X+,      r7
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_88:
	out   PIXOUT,  r1
	st    X+,      r11
	st    X+,      r7
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_93:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_94:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_97:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r3
	rjmp  tilerow_common_1
tilerow_block_98:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_102:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r3
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_103:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r3
	st    X+,      r3
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r3
	rjmp  tilerow_common_1
tilerow_block_104:
	out   PIXOUT,  r1
	st    X+,      r3
	st    X+,      r3
	st    X+,      r4
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r3
	st    X+,      r3
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_105:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r7
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_110:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r9
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_111:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r3
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_112:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r3
	out   PIXOUT,  r23
	st    X+,      r3
	st    X+,      r3
	rjmp  tilerow_common_1
tilerow_block_113:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r3
	rjmp  tilerow_common_1
tilerow_block_118:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r3
	st    X+,      r3
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r3
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_119:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r3
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r3
	st    X+,      r9
	st    X+,      r4
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r6
	rjmp  tilerow_common_1
tilerow_block_120:
	out   PIXOUT,  r1
	st    X+,      r4
	st    X+,      r3
	st    X+,      r3
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r9
	st    X+,      r3
	out   PIXOUT,  r23
	st    X+,      r3
	st    X+,      r3
	rjmp  tilerow_common_1
tilerow_block_121:
	out   PIXOUT,  r1
	st    X+,      r3
	st    X+,      r11
	st    X+,      r3
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r4
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r3
	st    X+,      r3
	rjmp  tilerow_common_1

.balign 512
tilerow_4_map:
	rjmp  tilerow_block_4
	rjmp  tilerow_block_12
	rjmp  tilerow_block_20
	rjmp  tilerow_block_27
	rjmp  tilerow_block_33
	rjmp  tilerow_block_39
	rjmp  tilerow_block_45
	rjmp  tilerow_block_51
	rjmp  tilerow_block_56
	rjmp  tilerow_block_63
	rjmp  tilerow_block_69
	rjmp  tilerow_block_76
	rjmp  tilerow_block_82
	rjmp  tilerow_block_34
	rjmp  tilerow_block_34
	rjmp  tilerow_block_92
	rjmp  tilerow_block_34
	rjmp  tilerow_block_102
	rjmp  tilerow_block_110
	rjmp  tilerow_block_118
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4
	rjmp  tilerow_block_4


.balign 512
tilerow_5_map:
	rjmp  tilerow_block_5
	rjmp  tilerow_block_13
	rjmp  tilerow_block_21
	rjmp  tilerow_block_28
	rjmp  tilerow_block_33
	rjmp  tilerow_block_40
	rjmp  tilerow_block_46
	rjmp  tilerow_block_52
	rjmp  tilerow_block_56
	rjmp  tilerow_block_64
	rjmp  tilerow_block_70
	rjmp  tilerow_block_77
	rjmp  tilerow_block_83
	rjmp  tilerow_block_34
	rjmp  tilerow_block_34
	rjmp  tilerow_block_93
	rjmp  tilerow_block_32
	rjmp  tilerow_block_103
	rjmp  tilerow_block_111
	rjmp  tilerow_block_119
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5
	rjmp  tilerow_block_5


.balign 512
tilerow_6_map:
	rjmp  tilerow_block_6
	rjmp  tilerow_block_14
	rjmp  tilerow_block_22
	rjmp  tilerow_block_27
	rjmp  tilerow_block_33
	rjmp  tilerow_block_34
	rjmp  tilerow_block_44
	rjmp  tilerow_block_53
	rjmp  tilerow_block_58
	rjmp  tilerow_block_56
	rjmp  tilerow_block_71
	rjmp  tilerow_block_78
	rjmp  tilerow_block_84
	rjmp  tilerow_block_87
	rjmp  tilerow_block_34
	rjmp  tilerow_block_34
	rjmp  tilerow_block_97
	rjmp  tilerow_block_104
	rjmp  tilerow_block_112
	rjmp  tilerow_block_120
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6
	rjmp  tilerow_block_6


.balign 512
tilerow_7_map:
	rjmp  tilerow_block_7
	rjmp  tilerow_block_15
	rjmp  tilerow_block_23
	rjmp  tilerow_block_29
	rjmp  tilerow_block_34
	rjmp  tilerow_block_34
	rjmp  tilerow_block_47
	rjmp  tilerow_block_54
	rjmp  tilerow_block_56
	rjmp  tilerow_block_56
	rjmp  tilerow_block_72
	rjmp  tilerow_block_55
	rjmp  tilerow_block_85
	rjmp  tilerow_block_88
	rjmp  tilerow_block_34
	rjmp  tilerow_block_94
	rjmp  tilerow_block_98
	rjmp  tilerow_block_105
	rjmp  tilerow_block_113
	rjmp  tilerow_block_121
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7
	rjmp  tilerow_block_7


tilerow_common_1:
	out   PIXOUT,  r0
	breq  tilerow_exit_c_1 ; Uses Z flag
	pop   r0
tilerow_entry_1:
	dec   r20
	ld    ZL,      Y+
	out   PIXOUT,  r0
	pop   r0
	pop   r21
	pop   r1
	out   PIXOUT,  r0
	pop   r22
	pop   r23
	pop   r0
	out   PIXOUT,  r21
	rjmp  .
	ijmp
tilerow_exit_c_1:
	brts  tilerow_exit_1   ; (1582 / 1621)
	mov   r22,     r17
	mov   r23,     r17
	movw  r0,      r22
	out   PIXOUT,  r17
	ld    ZL,      Y+
	set
	ijmp
tilerow_exit_1:
	sbic  GPR0,    1       ; (1622) Color 0 (bg) loading enabled?
	in    r2,      GPR1    ; (1623) If so, load it
	sbic  GPR0,    2       ; (1624) Color 15 (border) loading enabled?
	in    r17,     GPR1    ; (1625) If so, load it
	ldi   ZL,      LB_SPR - 1 ; (1626) 254(HI):255(LO): Sprite conf
	out   STACKL,  ZL      ; (1627)
	ret                    ; (1631)

