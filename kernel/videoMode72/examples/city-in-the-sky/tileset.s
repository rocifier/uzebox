
;
; Mode 72 tileset of 19 tiles
;
;
; Total number of tile rows:   27
; Shared rows .............:   17
; Upper half only rows ....:    4
; Lower half only rows ....:    6
;
; Chosen generator mode ...:    0
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
	.byte 0xFE, 0x5C, 0xA3, 0x52, 0xAE, 0xFF, 0xFF, 0xFF
	.byte 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF



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
tilerow_0_map:
	rjmp  tilerow_block_0
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_17
	rjmp  tilerow_block_18
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_22
	rjmp  tilerow_block_23
	rjmp  tilerow_block_24
	rjmp  tilerow_block_0
	rjmp  tilerow_block_25
	rjmp  tilerow_block_26
	rjmp  tilerow_block_26
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
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0


.balign 512
tilerow_1_map:
	rjmp  tilerow_block_0
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_7
	rjmp  tilerow_block_12
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_22
	rjmp  tilerow_block_23
	rjmp  tilerow_block_24
	rjmp  tilerow_block_0
	rjmp  tilerow_block_25
	rjmp  tilerow_block_26
	rjmp  tilerow_block_26
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
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0


.balign 512
tilerow_2_map:
	rjmp  tilerow_block_0
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_3
	rjmp  tilerow_block_0
	rjmp  tilerow_block_7
	rjmp  tilerow_block_12
	rjmp  tilerow_block_17
	rjmp  tilerow_block_18
	rjmp  tilerow_block_19
	rjmp  tilerow_block_19
	rjmp  tilerow_block_22
	rjmp  tilerow_block_23
	rjmp  tilerow_block_24
	rjmp  tilerow_block_25
	rjmp  tilerow_block_25
	rjmp  tilerow_block_26
	rjmp  tilerow_block_26
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
	rjmp  tilerow_block_0
	rjmp  tilerow_block_0


.balign 512
tilerow_3_map:
	rjmp  tilerow_block_0
	rjmp  tilerow_block_1
	rjmp  tilerow_block_2
	rjmp  tilerow_block_4
	rjmp  tilerow_block_0
	rjmp  tilerow_block_8
	rjmp  tilerow_block_13
	rjmp  tilerow_block_11
	rjmp  tilerow_block_16
	rjmp  tilerow_block_20
	rjmp  tilerow_block_21
	rjmp  tilerow_block_22
	rjmp  tilerow_block_23
	rjmp  tilerow_block_24
	rjmp  tilerow_block_25
	rjmp  tilerow_block_25
	rjmp  tilerow_block_26
	rjmp  tilerow_block_26
	rjmp  tilerow_block_26
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
	rjmp  tilerow_block_0

tilerow_block_0:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_0
tilerow_block_1:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_2:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_3:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_4:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_5:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_6:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_7:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r3
	st    X+,      r3
	out   PIXOUT,  r23
	st    X+,      r3
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_8:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_9:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r5
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_10:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_11:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r2
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_12:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r3
	st    X+,      r3
	out   PIXOUT,  r22
	st    X+,      r3
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_13:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_14:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_15:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r2
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_16:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_17:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_18:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_19:
	out   PIXOUT,  r1
	st    X+,      r4
	st    X+,      r4
	st    X+,      r4
	out   PIXOUT,  r22
	st    X+,      r4
	st    X+,      r4
	st    X+,      r4
	out   PIXOUT,  r23
	st    X+,      r4
	st    X+,      r4
	rjmp  tilerow_common_0
tilerow_block_20:
	out   PIXOUT,  r1
	st    X+,      r4
	st    X+,      r4
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r4
	st    X+,      r4
	out   PIXOUT,  r23
	st    X+,      r4
	st    X+,      r4
	rjmp  tilerow_common_0
tilerow_block_21:
	out   PIXOUT,  r1
	st    X+,      r4
	st    X+,      r4
	st    X+,      r4
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r5
	st    X+,      r4
	out   PIXOUT,  r23
	st    X+,      r4
	st    X+,      r4
	rjmp  tilerow_common_0
tilerow_block_22:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_23:
	out   PIXOUT,  r1
	st    X+,      r3
	st    X+,      r3
	st    X+,      r3
	out   PIXOUT,  r22
	st    X+,      r3
	st    X+,      r3
	st    X+,      r3
	out   PIXOUT,  r23
	st    X+,      r3
	st    X+,      r3
	rjmp  tilerow_common_0
tilerow_block_24:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_25:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r3
	st    X+,      r3
	st    X+,      r3
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_0
tilerow_block_26:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_0

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
	rjmp  .
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
tilerow_4_map:
	rjmp  tilerow_block_0
	rjmp  tilerow_block_1
	rjmp  tilerow_block_2
	rjmp  tilerow_block_5
	rjmp  tilerow_block_0
	rjmp  tilerow_block_8
	rjmp  tilerow_block_13
	rjmp  tilerow_block_10
	rjmp  tilerow_block_15
	rjmp  tilerow_block_20
	rjmp  tilerow_block_21
	rjmp  tilerow_block_22
	rjmp  tilerow_block_23
	rjmp  tilerow_block_24
	rjmp  tilerow_block_25
	rjmp  tilerow_block_25
	rjmp  tilerow_block_26
	rjmp  tilerow_block_26
	rjmp  tilerow_block_26
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
	rjmp  tilerow_block_0


.balign 512
tilerow_5_map:
	rjmp  tilerow_block_0
	rjmp  tilerow_block_1
	rjmp  tilerow_block_2
	rjmp  tilerow_block_6
	rjmp  tilerow_block_0
	rjmp  tilerow_block_9
	rjmp  tilerow_block_14
	rjmp  tilerow_block_9
	rjmp  tilerow_block_14
	rjmp  tilerow_block_20
	rjmp  tilerow_block_21
	rjmp  tilerow_block_22
	rjmp  tilerow_block_23
	rjmp  tilerow_block_24
	rjmp  tilerow_block_25
	rjmp  tilerow_block_25
	rjmp  tilerow_block_26
	rjmp  tilerow_block_26
	rjmp  tilerow_block_26
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
	rjmp  tilerow_block_0


.balign 512
tilerow_6_map:
	rjmp  tilerow_block_0
	rjmp  tilerow_block_1
	rjmp  tilerow_block_2
	rjmp  tilerow_block_1
	rjmp  tilerow_block_3
	rjmp  tilerow_block_10
	rjmp  tilerow_block_15
	rjmp  tilerow_block_8
	rjmp  tilerow_block_13
	rjmp  tilerow_block_19
	rjmp  tilerow_block_21
	rjmp  tilerow_block_22
	rjmp  tilerow_block_23
	rjmp  tilerow_block_24
	rjmp  tilerow_block_25
	rjmp  tilerow_block_25
	rjmp  tilerow_block_26
	rjmp  tilerow_block_26
	rjmp  tilerow_block_26
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
	rjmp  tilerow_block_0


.balign 512
tilerow_7_map:
	rjmp  tilerow_block_0
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_1
	rjmp  tilerow_block_4
	rjmp  tilerow_block_11
	rjmp  tilerow_block_16
	rjmp  tilerow_block_8
	rjmp  tilerow_block_13
	rjmp  tilerow_block_19
	rjmp  tilerow_block_21
	rjmp  tilerow_block_22
	rjmp  tilerow_block_23
	rjmp  tilerow_block_24
	rjmp  tilerow_block_25
	rjmp  tilerow_block_25
	rjmp  tilerow_block_26
	rjmp  tilerow_block_26
	rjmp  tilerow_block_26
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
	rjmp  tilerow_block_0

