
;
; Mode 72 tileset of 192 tiles
;
;
; Total number of tile rows:  589
; Shared rows .............:   39
; Upper half only rows ....:  273
; Lower half only rows ....:  277
;
; Chosen generator mode ...:    5
;


#include <avr/io.h>
#define  PIXOUT   _SFR_IO_ADDR(PORTC)
#define  GPR0     _SFR_IO_ADDR(GPIOR0)
#define  GPR1     _SFR_IO_ADDR(GPIOR1)
#define  STACKL   0x3D
#define  LB_SPR_B 254
#define  LB_SPR_A 252
#ifndef  M72_ALIGNED_SEC
#define  M72_ALIGNED_SEC .text
#endif


.global m72_defpalette
.global m72_deftilerows


.section .text



m72_defpalette:
	.byte 0xF4, 0xE3, 0x91, 0x00, 0x09, 0x11, 0x19, 0x23
	.byte 0x15, 0x0B, 0x52, 0x5B, 0xA4, 0xAD, 0x76, 0xFF



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

tilerow_block_148:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_0
tilerow_block_153:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r7
	rjmp  tilerow_common_0
tilerow_block_154:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r7
	rjmp  tilerow_common_0
tilerow_block_156:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r7
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r9
	st    X+,      r7
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r7
	rjmp  tilerow_common_0
tilerow_block_157:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r7
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r8
	st    X+,      r7
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r7
	rjmp  tilerow_common_0
tilerow_block_162:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r7
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r7
	st    X+,      r7
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_0
tilerow_block_167:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_168:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r12
	rjmp  tilerow_common_0
tilerow_block_169:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r2
	rjmp  tilerow_common_0
tilerow_block_170:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r2
	rjmp  tilerow_common_0
tilerow_block_175:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r13
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_176:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r13
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_177:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_178:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_182:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r12
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r13
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_183:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r2
	rjmp  tilerow_common_0
tilerow_block_184:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r6
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_0
tilerow_block_185:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r6
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r6
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_0
tilerow_block_189:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r13
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_190:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_191:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_192:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r6
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_199:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r13
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_0
tilerow_block_203:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r13
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r12
	rjmp  tilerow_common_0
tilerow_block_205:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r6
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_209:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r12
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_210:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r6
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r5
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r2
	rjmp  tilerow_common_0
tilerow_block_213:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_214:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r6
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_215:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_216:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_221:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r5
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r2
	rjmp  tilerow_common_0
tilerow_block_222:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_0
tilerow_block_223:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_0
tilerow_block_224:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r12
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r6
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r2
	rjmp  tilerow_common_0
tilerow_block_229:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_230:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_231:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_232:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_237:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_0
tilerow_block_238:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r2
	rjmp  tilerow_common_0
tilerow_block_239:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r12
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r2
	rjmp  tilerow_common_0
tilerow_block_242:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_243:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r6
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_244:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r12
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_245:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r5
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_250:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r5
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r2
	rjmp  tilerow_common_0
tilerow_block_251:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r6
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_0
tilerow_block_252:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r6
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r2
	rjmp  tilerow_common_0
tilerow_block_253:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r12
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r5
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_257:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_258:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_259:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_260:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_265:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r6
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_266:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_267:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r12
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_271:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_272:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_273:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_274:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r12
	rjmp  tilerow_common_0
tilerow_block_278:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r5
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_279:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r12
	rjmp  tilerow_common_0
tilerow_block_280:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r6
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_281:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r5
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_282:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_283:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r12
	rjmp  tilerow_common_0
tilerow_block_284:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r12
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_285:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_286:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_287:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r13
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_288:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r5
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_289:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_290:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r13
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_291:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_292:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_293:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_294:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_299:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r17
	out   PIXOUT,  r22
	st    X+,      r17
	st    X+,      r17
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_0
tilerow_block_302:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r17
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_0
tilerow_block_303:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r17
	st    X+,      r16
	out   PIXOUT,  r22
	st    X+,      r17
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_0
tilerow_block_304:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r16
	st    X+,      r17
	out   PIXOUT,  r22
	st    X+,      r17
	st    X+,      r17
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_0
tilerow_block_305:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r16
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r17
	st    X+,      r17
	st    X+,      r17
	out   PIXOUT,  r23
	st    X+,      r17
	st    X+,      r2
	rjmp  tilerow_common_0
tilerow_block_308:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r17
	st    X+,      r17
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_0
tilerow_block_309:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r17
	out   PIXOUT,  r22
	st    X+,      r17
	st    X+,      r17
	st    X+,      r17
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_0
tilerow_block_315:
	out   PIXOUT,  r1
	st    X+,      r3
	st    X+,      r3
	st    X+,      r3
	out   PIXOUT,  r22
	st    X+,      r4
	st    X+,      r4
	st    X+,      r4
	out   PIXOUT,  r23
	st    X+,      r4
	st    X+,      r4
	rjmp  tilerow_common_0
tilerow_block_316:
	out   PIXOUT,  r1
	st    X+,      r4
	st    X+,      r4
	st    X+,      r4
	out   PIXOUT,  r22
	st    X+,      r4
	st    X+,      r3
	st    X+,      r3
	out   PIXOUT,  r23
	st    X+,      r4
	st    X+,      r4
	rjmp  tilerow_common_0
tilerow_block_317:
	out   PIXOUT,  r1
	st    X+,      r3
	st    X+,      r3
	st    X+,      r4
	out   PIXOUT,  r22
	st    X+,      r4
	st    X+,      r4
	st    X+,      r4
	out   PIXOUT,  r23
	st    X+,      r4
	st    X+,      r3
	rjmp  tilerow_common_0
tilerow_block_321:
	out   PIXOUT,  r1
	st    X+,      r4
	st    X+,      r3
	st    X+,      r3
	out   PIXOUT,  r22
	st    X+,      r3
	st    X+,      r4
	st    X+,      r4
	out   PIXOUT,  r23
	st    X+,      r4
	st    X+,      r4
	rjmp  tilerow_common_0
tilerow_block_322:
	out   PIXOUT,  r1
	st    X+,      r4
	st    X+,      r4
	st    X+,      r4
	out   PIXOUT,  r22
	st    X+,      r4
	st    X+,      r4
	st    X+,      r3
	out   PIXOUT,  r23
	st    X+,      r3
	st    X+,      r3
	rjmp  tilerow_common_0
tilerow_block_328:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_332:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_334:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_335:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r13
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_340:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_341:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_342:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r6
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_343:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_346:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r13
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_347:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r13
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_348:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r13
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_349:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_353:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r6
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_355:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r6
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_359:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r17
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r17
	out   PIXOUT,  r23
	st    X+,      r17
	st    X+,      r17
	rjmp  tilerow_common_0
tilerow_block_360:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r15
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r17
	out   PIXOUT,  r23
	st    X+,      r16
	st    X+,      r15
	rjmp  tilerow_common_0
tilerow_block_361:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r15
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r17
	out   PIXOUT,  r23
	st    X+,      r15
	st    X+,      r15
	rjmp  tilerow_common_0
tilerow_block_362:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_367:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r15
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r17
	out   PIXOUT,  r23
	st    X+,      r16
	st    X+,      r15
	rjmp  tilerow_common_0
tilerow_block_368:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r14
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r17
	out   PIXOUT,  r23
	st    X+,      r15
	st    X+,      r15
	rjmp  tilerow_common_0
tilerow_block_369:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_374:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r17
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r17
	out   PIXOUT,  r23
	st    X+,      r17
	st    X+,      r15
	rjmp  tilerow_common_0
tilerow_block_375:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r15
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r17
	out   PIXOUT,  r23
	st    X+,      r15
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_376:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r14
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r17
	out   PIXOUT,  r23
	st    X+,      r15
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_377:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r16
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_382:
	out   PIXOUT,  r1
	st    X+,      r16
	st    X+,      r17
	st    X+,      r17
	out   PIXOUT,  r22
	st    X+,      r17
	st    X+,      r16
	st    X+,      r17
	out   PIXOUT,  r23
	st    X+,      r17
	st    X+,      r15
	rjmp  tilerow_common_0
tilerow_block_383:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r15
	st    X+,      r16
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r15
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r15
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_398:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r16
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r15
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r15
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_399:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r12
	rjmp  tilerow_common_0
tilerow_block_404:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r15
	st    X+,      r17
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r14
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_405:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r15
	st    X+,      r17
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r15
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_406:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r16
	st    X+,      r17
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r15
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r12
	rjmp  tilerow_common_0
tilerow_block_407:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r15
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r12
	rjmp  tilerow_common_0
tilerow_block_411:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r15
	st    X+,      r17
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r15
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_412:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r15
	st    X+,      r17
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r14
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_413:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r16
	st    X+,      r17
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r15
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r12
	rjmp  tilerow_common_0
tilerow_block_414:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r15
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_415:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r15
	st    X+,      r14
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r14
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r12
	rjmp  tilerow_common_0
tilerow_block_416:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r14
	st    X+,      r14
	out   PIXOUT,  r22
	st    X+,      r14
	st    X+,      r14
	st    X+,      r14
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_417:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r14
	st    X+,      r14
	out   PIXOUT,  r22
	st    X+,      r14
	st    X+,      r14
	st    X+,      r14
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r12
	rjmp  tilerow_common_0
tilerow_block_418:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_423:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r15
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r14
	st    X+,      r14
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_424:
	out   PIXOUT,  r1
	st    X+,      r14
	st    X+,      r14
	st    X+,      r14
	out   PIXOUT,  r22
	st    X+,      r14
	st    X+,      r14
	st    X+,      r14
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r12
	rjmp  tilerow_common_0
tilerow_block_425:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_430:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r15
	st    X+,      r14
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r14
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_431:
	out   PIXOUT,  r1
	st    X+,      r14
	st    X+,      r14
	st    X+,      r14
	out   PIXOUT,  r22
	st    X+,      r14
	st    X+,      r14
	st    X+,      r14
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r12
	rjmp  tilerow_common_0
tilerow_block_436:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r14
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_437:
	out   PIXOUT,  r1
	st    X+,      r14
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_438:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r12
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r12
	rjmp  tilerow_common_0
tilerow_block_442:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r12
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r15
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_443:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r12
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_444:
	out   PIXOUT,  r1
	st    X+,      r14
	st    X+,      r14
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r15
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r15
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_445:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r12
	rjmp  tilerow_common_0
tilerow_block_447:
	out   PIXOUT,  r1
	st    X+,      r16
	st    X+,      r17
	st    X+,      r16
	out   PIXOUT,  r22
	st    X+,      r17
	st    X+,      r17
	st    X+,      r17
	out   PIXOUT,  r23
	st    X+,      r17
	st    X+,      r15
	rjmp  tilerow_common_0
tilerow_block_448:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r16
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r16
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r16
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_449:
	out   PIXOUT,  r1
	st    X+,      r16
	st    X+,      r15
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r15
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_450:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r12
	rjmp  tilerow_common_0
tilerow_block_457:
	out   PIXOUT,  r1
	st    X+,      r16
	st    X+,      r13
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r16
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r15
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_464:
	out   PIXOUT,  r1
	st    X+,      r16
	st    X+,      r13
	st    X+,      r16
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r16
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r16
	st    X+,      r13
	rjmp  tilerow_common_0

.balign 512

tilerow_block_148_j0:
	rjmp  tilerow_block_148
tilerow_block_153_j0:
	rjmp  tilerow_block_153
tilerow_block_154_j0:
	rjmp  tilerow_block_154
tilerow_block_156_j0:
	rjmp  tilerow_block_156
tilerow_block_157_j0:
	rjmp  tilerow_block_157
tilerow_block_162_j0:
	rjmp  tilerow_block_162
tilerow_block_167_j0:
	rjmp  tilerow_block_167
tilerow_block_168_j0:
	rjmp  tilerow_block_168
tilerow_block_169_j0:
	rjmp  tilerow_block_169
tilerow_block_170_j0:
	rjmp  tilerow_block_170
tilerow_block_175_j0:
	rjmp  tilerow_block_175
tilerow_block_176_j0:
	rjmp  tilerow_block_176
tilerow_block_177_j0:
	rjmp  tilerow_block_177
tilerow_block_178_j0:
	rjmp  tilerow_block_178
tilerow_block_182_j0:
	rjmp  tilerow_block_182
tilerow_block_183_j0:
	rjmp  tilerow_block_183
tilerow_block_184_j0:
	rjmp  tilerow_block_184
tilerow_block_185_j0:
	rjmp  tilerow_block_185
tilerow_block_189_j0:
	rjmp  tilerow_block_189
tilerow_block_190_j0:
	rjmp  tilerow_block_190
tilerow_block_191_j0:
	rjmp  tilerow_block_191
tilerow_block_192_j0:
	rjmp  tilerow_block_192
tilerow_block_199_j0:
	rjmp  tilerow_block_199
tilerow_block_203_j0:
	rjmp  tilerow_block_203
tilerow_block_205_j0:
	rjmp  tilerow_block_205
tilerow_block_209_j0:
	rjmp  tilerow_block_209
tilerow_block_210_j0:
	rjmp  tilerow_block_210
tilerow_block_213_j0:
	rjmp  tilerow_block_213
tilerow_block_214_j0:
	rjmp  tilerow_block_214
tilerow_block_215_j0:
	rjmp  tilerow_block_215
tilerow_block_216_j0:
	rjmp  tilerow_block_216
tilerow_block_221_j0:
	rjmp  tilerow_block_221
tilerow_block_222_j0:
	rjmp  tilerow_block_222
tilerow_block_223_j0:
	rjmp  tilerow_block_223
tilerow_block_224_j0:
	rjmp  tilerow_block_224
tilerow_block_229_j0:
	rjmp  tilerow_block_229
tilerow_block_230_j0:
	rjmp  tilerow_block_230
tilerow_block_231_j0:
	rjmp  tilerow_block_231
tilerow_block_232_j0:
	rjmp  tilerow_block_232
tilerow_block_237_j0:
	rjmp  tilerow_block_237
tilerow_block_238_j0:
	rjmp  tilerow_block_238
tilerow_block_239_j0:
	rjmp  tilerow_block_239
tilerow_block_242_j0:
	rjmp  tilerow_block_242
tilerow_block_243_j0:
	rjmp  tilerow_block_243
tilerow_block_244_j0:
	rjmp  tilerow_block_244
tilerow_block_245_j0:
	rjmp  tilerow_block_245
tilerow_block_250_j0:
	rjmp  tilerow_block_250
tilerow_block_251_j0:
	rjmp  tilerow_block_251
tilerow_block_252_j0:
	rjmp  tilerow_block_252
tilerow_block_253_j0:
	rjmp  tilerow_block_253
tilerow_block_257_j0:
	rjmp  tilerow_block_257
tilerow_block_258_j0:
	rjmp  tilerow_block_258
tilerow_block_259_j0:
	rjmp  tilerow_block_259
tilerow_block_260_j0:
	rjmp  tilerow_block_260
tilerow_block_265_j0:
	rjmp  tilerow_block_265
tilerow_block_266_j0:
	rjmp  tilerow_block_266
tilerow_block_267_j0:
	rjmp  tilerow_block_267
tilerow_block_271_j0:
	rjmp  tilerow_block_271
tilerow_block_272_j0:
	rjmp  tilerow_block_272
tilerow_block_273_j0:
	rjmp  tilerow_block_273
tilerow_block_274_j0:
	rjmp  tilerow_block_274
tilerow_block_278_j0:
	rjmp  tilerow_block_278
tilerow_block_279_j0:
	rjmp  tilerow_block_279
tilerow_block_280_j0:
	rjmp  tilerow_block_280
tilerow_block_281_j0:
	rjmp  tilerow_block_281
tilerow_block_282_j0:
	rjmp  tilerow_block_282
tilerow_block_283_j0:
	rjmp  tilerow_block_283
tilerow_block_284_j0:
	rjmp  tilerow_block_284
tilerow_block_285_j0:
	rjmp  tilerow_block_285
tilerow_block_286_j0:
	rjmp  tilerow_block_286
tilerow_block_287_j0:
	rjmp  tilerow_block_287
tilerow_block_288_j0:
	rjmp  tilerow_block_288
tilerow_block_289_j0:
	rjmp  tilerow_block_289
tilerow_block_290_j0:
	rjmp  tilerow_block_290
tilerow_block_291_j0:
	rjmp  tilerow_block_291
tilerow_block_292_j0:
	rjmp  tilerow_block_292
tilerow_block_293_j0:
	rjmp  tilerow_block_293
tilerow_block_294_j0:
	rjmp  tilerow_block_294
tilerow_block_299_j0:
	rjmp  tilerow_block_299
tilerow_block_302_j0:
	rjmp  tilerow_block_302
tilerow_block_303_j0:
	rjmp  tilerow_block_303
tilerow_block_304_j0:
	rjmp  tilerow_block_304
tilerow_block_305_j0:
	rjmp  tilerow_block_305
tilerow_block_308_j0:
	rjmp  tilerow_block_308
tilerow_block_309_j0:
	rjmp  tilerow_block_309
tilerow_block_315_j0:
	rjmp  tilerow_block_315
tilerow_block_316_j0:
	rjmp  tilerow_block_316
tilerow_block_317_j0:
	rjmp  tilerow_block_317
tilerow_block_321_j0:
	rjmp  tilerow_block_321
tilerow_block_322_j0:
	rjmp  tilerow_block_322
tilerow_block_328_j0:
	rjmp  tilerow_block_328
tilerow_block_332_j0:
	rjmp  tilerow_block_332
tilerow_block_334_j0:
	rjmp  tilerow_block_334
tilerow_block_335_j0:
	rjmp  tilerow_block_335
tilerow_block_340_j0:
	rjmp  tilerow_block_340
tilerow_block_341_j0:
	rjmp  tilerow_block_341
tilerow_block_342_j0:
	rjmp  tilerow_block_342
tilerow_block_343_j0:
	rjmp  tilerow_block_343
tilerow_block_346_j0:
	rjmp  tilerow_block_346
tilerow_block_347_j0:
	rjmp  tilerow_block_347
tilerow_block_348_j0:
	rjmp  tilerow_block_348
tilerow_block_349_j0:
	rjmp  tilerow_block_349
tilerow_block_353_j0:
	rjmp  tilerow_block_353
tilerow_block_355_j0:
	rjmp  tilerow_block_355
tilerow_block_359_j0:
	rjmp  tilerow_block_359
tilerow_block_360_j0:
	rjmp  tilerow_block_360
tilerow_block_361_j0:
	rjmp  tilerow_block_361
tilerow_block_362_j0:
	rjmp  tilerow_block_362
tilerow_block_367_j0:
	rjmp  tilerow_block_367
tilerow_block_368_j0:
	rjmp  tilerow_block_368
tilerow_block_369_j0:
	rjmp  tilerow_block_369
tilerow_block_374_j0:
	rjmp  tilerow_block_374
tilerow_block_375_j0:
	rjmp  tilerow_block_375
tilerow_block_376_j0:
	rjmp  tilerow_block_376
tilerow_block_377_j0:
	rjmp  tilerow_block_377
tilerow_block_382_j0:
	rjmp  tilerow_block_382
tilerow_block_383_j0:
	rjmp  tilerow_block_383
tilerow_block_398_j0:
	rjmp  tilerow_block_398
tilerow_block_399_j0:
	rjmp  tilerow_block_399
tilerow_block_404_j0:
	rjmp  tilerow_block_404
tilerow_block_405_j0:
	rjmp  tilerow_block_405
tilerow_block_406_j0:
	rjmp  tilerow_block_406
tilerow_block_407_j0:
	rjmp  tilerow_block_407
tilerow_block_411_j0:
	rjmp  tilerow_block_411
tilerow_block_412_j0:
	rjmp  tilerow_block_412
tilerow_block_413_j0:
	rjmp  tilerow_block_413
tilerow_block_414_j0:
	rjmp  tilerow_block_414
tilerow_block_415_j0:
	rjmp  tilerow_block_415
tilerow_block_416_j0:
	rjmp  tilerow_block_416
tilerow_block_417_j0:
	rjmp  tilerow_block_417
tilerow_block_418_j0:
	rjmp  tilerow_block_418
tilerow_block_423_j0:
	rjmp  tilerow_block_423
tilerow_block_424_j0:
	rjmp  tilerow_block_424
tilerow_block_425_j0:
	rjmp  tilerow_block_425
tilerow_block_430_j0:
	rjmp  tilerow_block_430
tilerow_block_431_j0:
	rjmp  tilerow_block_431
tilerow_block_436_j0:
	rjmp  tilerow_block_436
tilerow_block_437_j0:
	rjmp  tilerow_block_437
tilerow_block_438_j0:
	rjmp  tilerow_block_438
tilerow_block_442_j0:
	rjmp  tilerow_block_442
tilerow_block_443_j0:
	rjmp  tilerow_block_443
tilerow_block_444_j0:
	rjmp  tilerow_block_444
tilerow_block_445_j0:
	rjmp  tilerow_block_445
tilerow_block_447_j0:
	rjmp  tilerow_block_447
tilerow_block_448_j0:
	rjmp  tilerow_block_448
tilerow_block_449_j0:
	rjmp  tilerow_block_449
tilerow_block_450_j0:
	rjmp  tilerow_block_450
tilerow_block_457_j0:
	rjmp  tilerow_block_457
tilerow_block_464_j0:
	rjmp  tilerow_block_464
tilerow_block_466_j0:
	rjmp  tilerow_block_466
tilerow_block_467_j0:
	rjmp  tilerow_block_467
tilerow_block_468_j0:
	rjmp  tilerow_block_468
tilerow_block_469_j0:
	rjmp  tilerow_block_469
tilerow_block_470_j0:
	rjmp  tilerow_block_470
tilerow_block_471_j0:
	rjmp  tilerow_block_471
tilerow_block_472_j0:
	rjmp  tilerow_block_472
tilerow_block_475_j0:
	rjmp  tilerow_block_475
tilerow_block_476_j0:
	rjmp  tilerow_block_476
tilerow_block_477_j0:
	rjmp  tilerow_block_477
tilerow_block_478_j0:
	rjmp  tilerow_block_478
tilerow_block_482_j0:
	rjmp  tilerow_block_482
tilerow_block_483_j0:
	rjmp  tilerow_block_483
tilerow_block_488_j0:
	rjmp  tilerow_block_488
tilerow_block_489_j0:
	rjmp  tilerow_block_489
tilerow_block_496_j0:
	rjmp  tilerow_block_496
tilerow_block_497_j0:
	rjmp  tilerow_block_497
tilerow_block_499_j0:
	rjmp  tilerow_block_499
tilerow_block_500_j0:
	rjmp  tilerow_block_500
tilerow_block_504_j0:
	rjmp  tilerow_block_504
tilerow_block_515_j0:
	rjmp  tilerow_block_515
tilerow_block_517_j0:
	rjmp  tilerow_block_517
tilerow_block_518_j0:
	rjmp  tilerow_block_518
tilerow_block_520_j0:
	rjmp  tilerow_block_520
tilerow_block_521_j0:
	rjmp  tilerow_block_521
tilerow_block_523_j0:
	rjmp  tilerow_block_523
tilerow_block_524_j0:
	rjmp  tilerow_block_524
tilerow_block_529_j0:
	rjmp  tilerow_block_529
tilerow_block_530_j0:
	rjmp  tilerow_block_530
tilerow_block_531_j0:
	rjmp  tilerow_block_531
tilerow_block_535_j0:
	rjmp  tilerow_block_535
tilerow_block_540_j0:
	rjmp  tilerow_block_540
tilerow_block_541_j0:
	rjmp  tilerow_block_541
tilerow_block_542_j0:
	rjmp  tilerow_block_542
tilerow_block_546_j0:
	rjmp  tilerow_block_546
tilerow_block_547_j0:
	rjmp  tilerow_block_547
tilerow_block_548_j0:
	rjmp  tilerow_block_548
tilerow_block_549_j0:
	rjmp  tilerow_block_549
tilerow_block_550_j0:
	rjmp  tilerow_block_550
tilerow_block_551_j0:
	rjmp  tilerow_block_551
tilerow_block_552_j0:
	rjmp  tilerow_block_552
tilerow_block_553_j0:
	rjmp  tilerow_block_553
tilerow_block_554_j0:
	rjmp  tilerow_block_554
tilerow_block_555_j0:
	rjmp  tilerow_block_555
tilerow_block_556_j0:
	rjmp  tilerow_block_556
tilerow_block_557_j0:
	rjmp  tilerow_block_557
tilerow_block_562_j0:
	rjmp  tilerow_block_562
tilerow_block_563_j0:
	rjmp  tilerow_block_563
tilerow_block_568_j0:
	rjmp  tilerow_block_568
tilerow_block_573_j0:
	rjmp  tilerow_block_573
tilerow_block_578_j0:
	rjmp  tilerow_block_578
tilerow_block_579_j0:
	rjmp  tilerow_block_579
tilerow_block_580_j0:
	rjmp  tilerow_block_580
tilerow_block_581_j0:
	rjmp  tilerow_block_581
tilerow_block_583_j0:
	rjmp  tilerow_block_583
tilerow_block_584_j0:
	rjmp  tilerow_block_584
tilerow_block_585_j0:
	rjmp  tilerow_block_585
tilerow_block_586_j0:
	rjmp  tilerow_block_586
tilerow_block_587_j0:
	rjmp  tilerow_block_587
tilerow_block_588_j0:
	rjmp  tilerow_block_588

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
	ldi   ZL,      LB_SPR_B - 1 ; (1626) 254(HI):255(LO): Sprite conf B
	sbic  GPR0,    0       ; (1627)
	ldi   ZL,      LB_SPR_A - 1 ; (1628) 252(HI):253(LO): Sprite conf A
	out   STACKL,  ZL      ; (1629)
	ret                    ; (1633)

tilerow_block_466:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r12
	rjmp  tilerow_common_0
tilerow_block_467:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r5
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_468:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r5
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_469:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r12
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_470:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r13
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r12
	rjmp  tilerow_common_0
tilerow_block_471:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r6
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_472:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r6
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_475:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r12
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r13
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_476:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_477:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r6
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_478:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r5
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_482:
	out   PIXOUT,  r1
	st    X+,      r14
	st    X+,      r14
	st    X+,      r16
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r16
	st    X+,      r14
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r12
	rjmp  tilerow_common_0
tilerow_block_483:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r13
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r15
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_488:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r13
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_489:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_496:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_497:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r12
	rjmp  tilerow_common_0
tilerow_block_499:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r12
	rjmp  tilerow_common_0
tilerow_block_500:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_504:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_515:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r5
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_517:
	out   PIXOUT,  r1
	st    X+,      r5
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
tilerow_block_518:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_520:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r6
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_521:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r6
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_523:
	out   PIXOUT,  r1
	st    X+,      r14
	st    X+,      r14
	st    X+,      r14
	out   PIXOUT,  r22
	st    X+,      r14
	st    X+,      r10
	st    X+,      r14
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r12
	rjmp  tilerow_common_0
tilerow_block_524:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r14
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_529:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r14
	st    X+,      r14
	out   PIXOUT,  r22
	st    X+,      r14
	st    X+,      r10
	st    X+,      r14
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_530:
	out   PIXOUT,  r1
	st    X+,      r14
	st    X+,      r14
	st    X+,      r14
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r14
	st    X+,      r14
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r12
	rjmp  tilerow_common_0
tilerow_block_531:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r13
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r14
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_535:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r13
	st    X+,      r14
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r10
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_540:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r14
	st    X+,      r14
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r14
	st    X+,      r14
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_541:
	out   PIXOUT,  r1
	st    X+,      r14
	st    X+,      r14
	st    X+,      r14
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r10
	st    X+,      r14
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r12
	rjmp  tilerow_common_0
tilerow_block_542:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r13
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r14
	st    X+,      r10
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r6
	rjmp  tilerow_common_0
tilerow_block_546:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r10
	st    X+,      r16
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r10
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_547:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r14
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r10
	st    X+,      r14
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_548:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r10
	st    X+,      r16
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r16
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_549:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r14
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r14
	st    X+,      r14
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_550:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r15
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r10
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_551:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r14
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r15
	st    X+,      r14
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_552:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r16
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_553:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r14
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r10
	st    X+,      r14
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r13
	rjmp  tilerow_common_0
tilerow_block_554:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_555:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_556:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_557:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_562:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_563:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_568:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_573:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_578:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r10
	st    X+,      r16
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r16
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_579:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r10
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_580:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r14
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r14
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_581:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_583:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r10
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r10
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_584:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r13
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_585:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r10
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_586:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r13
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_587:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r15
	st    X+,      r10
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_0
tilerow_block_588:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r10
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r5
	rjmp  tilerow_common_0

.balign 512
tilerow_0_map:
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_6_j0
	rjmp  tilerow_block_11_j0
	rjmp  tilerow_block_21_j0
	rjmp  tilerow_block_29_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_21_j0
	rjmp  tilerow_block_11_j0
	rjmp  tilerow_block_9_j0
	rjmp  tilerow_block_69_j0
	rjmp  tilerow_block_74_j0
	rjmp  tilerow_block_81_j0
	rjmp  tilerow_block_89_j0
	rjmp  tilerow_block_97_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_108_j0
	rjmp  tilerow_block_116_j0
	rjmp  tilerow_block_123_j0
	rjmp  tilerow_block_130_j0
	rjmp  tilerow_block_138_j0
	rjmp  tilerow_block_29_j0
	rjmp  tilerow_block_81_j0
	rjmp  tilerow_block_89_j0
	rjmp  tilerow_block_97_j0
	rjmp  tilerow_block_167_j0
	rjmp  tilerow_block_175_j0
	rjmp  tilerow_block_182_j0
	rjmp  tilerow_block_189_j0
	rjmp  tilerow_block_197_j0
	rjmp  tilerow_block_203_j0
	rjmp  tilerow_block_209_j0
	rjmp  tilerow_block_213_j0
	rjmp  tilerow_block_221_j0
	rjmp  tilerow_block_229_j0
	rjmp  tilerow_block_236_j0
	rjmp  tilerow_block_242_j0
	rjmp  tilerow_block_250_j0
	rjmp  tilerow_block_257_j0
	rjmp  tilerow_block_257_j0
	rjmp  tilerow_block_271_j0
	rjmp  tilerow_block_278_j0
	rjmp  tilerow_block_282_j0
	rjmp  tilerow_block_285_j0
	rjmp  tilerow_block_287_j0
	rjmp  tilerow_block_291_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_302_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_314_j0
	rjmp  tilerow_block_321_j0
	rjmp  tilerow_block_325_j0
	rjmp  tilerow_block_332_j0
	rjmp  tilerow_block_340_j0
	rjmp  tilerow_block_346_j0
	rjmp  tilerow_block_353_j0
	rjmp  tilerow_block_359_j0
	rjmp  tilerow_block_359_j0
	rjmp  tilerow_block_374_j0
	rjmp  tilerow_block_382_j0
	rjmp  tilerow_block_382_j0
	rjmp  tilerow_block_382_j0
	rjmp  tilerow_block_397_j0
	rjmp  tilerow_block_404_j0
	rjmp  tilerow_block_411_j0
	rjmp  tilerow_block_415_j0
	rjmp  tilerow_block_423_j0
	rjmp  tilerow_block_430_j0
	rjmp  tilerow_block_430_j0
	rjmp  tilerow_block_442_j0
	rjmp  tilerow_block_447_j0
	rjmp  tilerow_block_455_j0
	rjmp  tilerow_block_455_j0
	rjmp  tilerow_block_455_j0
	rjmp  tilerow_block_466_j0
	rjmp  tilerow_block_470_j0
	rjmp  tilerow_block_475_j0
	rjmp  tilerow_block_430_j0
	rjmp  tilerow_block_487_j0
	rjmp  tilerow_block_493_j0
	rjmp  tilerow_block_496_j0
	rjmp  tilerow_block_497_j0
	rjmp  tilerow_block_504_j0
	rjmp  tilerow_block_504_j0
	rjmp  tilerow_block_510_j0
	rjmp  tilerow_block_515_j0
	rjmp  tilerow_block_517_j0
	rjmp  tilerow_block_520_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_430_j0
	rjmp  tilerow_block_430_j0
	rjmp  tilerow_block_430_j0
	rjmp  tilerow_block_430_j0
	rjmp  tilerow_block_546_j0
	rjmp  tilerow_block_548_j0
	rjmp  tilerow_block_550_j0
	rjmp  tilerow_block_552_j0
	rjmp  tilerow_block_554_j0
	rjmp  tilerow_block_554_j0
	rjmp  tilerow_block_487_j0
	rjmp  tilerow_block_554_j0
	rjmp  tilerow_block_578_j0
	rjmp  tilerow_block_583_j0
	rjmp  tilerow_block_585_j0
	rjmp  tilerow_block_587_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0


.balign 512
tilerow_1_map:
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_7_j0
	rjmp  tilerow_block_14_j0
	rjmp  tilerow_block_22_j0
	rjmp  tilerow_block_30_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_49_j0
	rjmp  tilerow_block_14_j0
	rjmp  tilerow_block_62_j0
	rjmp  tilerow_block_70_j0
	rjmp  tilerow_block_75_j0
	rjmp  tilerow_block_82_j0
	rjmp  tilerow_block_90_j0
	rjmp  tilerow_block_98_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_109_j0
	rjmp  tilerow_block_29_j0
	rjmp  tilerow_block_124_j0
	rjmp  tilerow_block_131_j0
	rjmp  tilerow_block_139_j0
	rjmp  tilerow_block_146_j0
	rjmp  tilerow_block_129_j0
	rjmp  tilerow_block_90_j0
	rjmp  tilerow_block_98_j0
	rjmp  tilerow_block_168_j0
	rjmp  tilerow_block_176_j0
	rjmp  tilerow_block_183_j0
	rjmp  tilerow_block_190_j0
	rjmp  tilerow_block_197_j0
	rjmp  tilerow_block_204_j0
	rjmp  tilerow_block_183_j0
	rjmp  tilerow_block_214_j0
	rjmp  tilerow_block_222_j0
	rjmp  tilerow_block_230_j0
	rjmp  tilerow_block_237_j0
	rjmp  tilerow_block_243_j0
	rjmp  tilerow_block_251_j0
	rjmp  tilerow_block_258_j0
	rjmp  tilerow_block_265_j0
	rjmp  tilerow_block_272_j0
	rjmp  tilerow_block_279_j0
	rjmp  tilerow_block_283_j0
	rjmp  tilerow_block_286_j0
	rjmp  tilerow_block_288_j0
	rjmp  tilerow_block_292_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_303_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_315_j0
	rjmp  tilerow_block_322_j0
	rjmp  tilerow_block_326_j0
	rjmp  tilerow_block_333_j0
	rjmp  tilerow_block_341_j0
	rjmp  tilerow_block_347_j0
	rjmp  tilerow_block_354_j0
	rjmp  tilerow_block_360_j0
	rjmp  tilerow_block_367_j0
	rjmp  tilerow_block_375_j0
	rjmp  tilerow_block_383_j0
	rjmp  tilerow_block_383_j0
	rjmp  tilerow_block_383_j0
	rjmp  tilerow_block_398_j0
	rjmp  tilerow_block_405_j0
	rjmp  tilerow_block_412_j0
	rjmp  tilerow_block_416_j0
	rjmp  tilerow_block_416_j0
	rjmp  tilerow_block_416_j0
	rjmp  tilerow_block_436_j0
	rjmp  tilerow_block_443_j0
	rjmp  tilerow_block_448_j0
	rjmp  tilerow_block_456_j0
	rjmp  tilerow_block_457_j0
	rjmp  tilerow_block_464_j0
	rjmp  tilerow_block_467_j0
	rjmp  tilerow_block_471_j0
	rjmp  tilerow_block_476_j0
	rjmp  tilerow_block_416_j0
	rjmp  tilerow_block_487_j0
	rjmp  tilerow_block_487_j0
	rjmp  tilerow_block_491_j0
	rjmp  tilerow_block_498_j0
	rjmp  tilerow_block_501_j0
	rjmp  tilerow_block_501_j0
	rjmp  tilerow_block_511_j0
	rjmp  tilerow_block_514_j0
	rjmp  tilerow_block_511_j0
	rjmp  tilerow_block_521_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_416_j0
	rjmp  tilerow_block_529_j0
	rjmp  tilerow_block_416_j0
	rjmp  tilerow_block_540_j0
	rjmp  tilerow_block_547_j0
	rjmp  tilerow_block_549_j0
	rjmp  tilerow_block_551_j0
	rjmp  tilerow_block_553_j0
	rjmp  tilerow_block_555_j0
	rjmp  tilerow_block_555_j0
	rjmp  tilerow_block_555_j0
	rjmp  tilerow_block_555_j0
	rjmp  tilerow_block_579_j0
	rjmp  tilerow_block_584_j0
	rjmp  tilerow_block_586_j0
	rjmp  tilerow_block_588_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0


.balign 512
tilerow_2_map:
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_8_j0
	rjmp  tilerow_block_15_j0
	rjmp  tilerow_block_23_j0
	rjmp  tilerow_block_31_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_50_j0
	rjmp  tilerow_block_56_j0
	rjmp  tilerow_block_63_j0
	rjmp  tilerow_block_71_j0
	rjmp  tilerow_block_76_j0
	rjmp  tilerow_block_83_j0
	rjmp  tilerow_block_91_j0
	rjmp  tilerow_block_99_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_110_j0
	rjmp  tilerow_block_117_j0
	rjmp  tilerow_block_125_j0
	rjmp  tilerow_block_132_j0
	rjmp  tilerow_block_140_j0
	rjmp  tilerow_block_147_j0
	rjmp  tilerow_block_153_j0
	rjmp  tilerow_block_156_j0
	rjmp  tilerow_block_99_j0
	rjmp  tilerow_block_169_j0
	rjmp  tilerow_block_177_j0
	rjmp  tilerow_block_184_j0
	rjmp  tilerow_block_191_j0
	rjmp  tilerow_block_198_j0
	rjmp  tilerow_block_205_j0
	rjmp  tilerow_block_184_j0
	rjmp  tilerow_block_215_j0
	rjmp  tilerow_block_223_j0
	rjmp  tilerow_block_231_j0
	rjmp  tilerow_block_238_j0
	rjmp  tilerow_block_244_j0
	rjmp  tilerow_block_252_j0
	rjmp  tilerow_block_259_j0
	rjmp  tilerow_block_266_j0
	rjmp  tilerow_block_273_j0
	rjmp  tilerow_block_280_j0
	rjmp  tilerow_block_284_j0
	rjmp  tilerow_block_76_j0
	rjmp  tilerow_block_289_j0
	rjmp  tilerow_block_293_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_304_j0
	rjmp  tilerow_block_308_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_316_j0
	rjmp  tilerow_block_314_j0
	rjmp  tilerow_block_327_j0
	rjmp  tilerow_block_334_j0
	rjmp  tilerow_block_342_j0
	rjmp  tilerow_block_348_j0
	rjmp  tilerow_block_355_j0
	rjmp  tilerow_block_361_j0
	rjmp  tilerow_block_368_j0
	rjmp  tilerow_block_376_j0
	rjmp  tilerow_block_384_j0
	rjmp  tilerow_block_384_j0
	rjmp  tilerow_block_394_j0
	rjmp  tilerow_block_384_j0
	rjmp  tilerow_block_406_j0
	rjmp  tilerow_block_413_j0
	rjmp  tilerow_block_417_j0
	rjmp  tilerow_block_424_j0
	rjmp  tilerow_block_431_j0
	rjmp  tilerow_block_437_j0
	rjmp  tilerow_block_444_j0
	rjmp  tilerow_block_449_j0
	rjmp  tilerow_block_455_j0
	rjmp  tilerow_block_461_j0
	rjmp  tilerow_block_463_j0
	rjmp  tilerow_block_468_j0
	rjmp  tilerow_block_472_j0
	rjmp  tilerow_block_477_j0
	rjmp  tilerow_block_482_j0
	rjmp  tilerow_block_488_j0
	rjmp  tilerow_block_494_j0
	rjmp  tilerow_block_491_j0
	rjmp  tilerow_block_499_j0
	rjmp  tilerow_block_502_j0
	rjmp  tilerow_block_502_j0
	rjmp  tilerow_block_512_j0
	rjmp  tilerow_block_514_j0
	rjmp  tilerow_block_510_j0
	rjmp  tilerow_block_510_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_523_j0
	rjmp  tilerow_block_530_j0
	rjmp  tilerow_block_530_j0
	rjmp  tilerow_block_541_j0
	rjmp  tilerow_block_482_j0
	rjmp  tilerow_block_482_j0
	rjmp  tilerow_block_482_j0
	rjmp  tilerow_block_482_j0
	rjmp  tilerow_block_556_j0
	rjmp  tilerow_block_562_j0
	rjmp  tilerow_block_568_j0
	rjmp  tilerow_block_573_j0
	rjmp  tilerow_block_580_j0
	rjmp  tilerow_block_580_j0
	rjmp  tilerow_block_580_j0
	rjmp  tilerow_block_580_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0


.balign 512
tilerow_3_map:
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_1_j0
	rjmp  tilerow_block_9_j0
	rjmp  tilerow_block_16_j0
	rjmp  tilerow_block_24_j0
	rjmp  tilerow_block_9_j0
	rjmp  tilerow_block_36_j0
	rjmp  tilerow_block_41_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_51_j0
	rjmp  tilerow_block_57_j0
	rjmp  tilerow_block_64_j0
	rjmp  tilerow_block_72_j0
	rjmp  tilerow_block_77_j0
	rjmp  tilerow_block_84_j0
	rjmp  tilerow_block_92_j0
	rjmp  tilerow_block_100_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_111_j0
	rjmp  tilerow_block_118_j0
	rjmp  tilerow_block_126_j0
	rjmp  tilerow_block_133_j0
	rjmp  tilerow_block_141_j0
	rjmp  tilerow_block_148_j0
	rjmp  tilerow_block_154_j0
	rjmp  tilerow_block_157_j0
	rjmp  tilerow_block_162_j0
	rjmp  tilerow_block_170_j0
	rjmp  tilerow_block_178_j0
	rjmp  tilerow_block_185_j0
	rjmp  tilerow_block_192_j0
	rjmp  tilerow_block_199_j0
	rjmp  tilerow_block_192_j0
	rjmp  tilerow_block_210_j0
	rjmp  tilerow_block_216_j0
	rjmp  tilerow_block_224_j0
	rjmp  tilerow_block_232_j0
	rjmp  tilerow_block_239_j0
	rjmp  tilerow_block_245_j0
	rjmp  tilerow_block_253_j0
	rjmp  tilerow_block_260_j0
	rjmp  tilerow_block_267_j0
	rjmp  tilerow_block_274_j0
	rjmp  tilerow_block_281_j0
	rjmp  tilerow_block_72_j0
	rjmp  tilerow_block_77_j0
	rjmp  tilerow_block_290_j0
	rjmp  tilerow_block_294_j0
	rjmp  tilerow_block_299_j0
	rjmp  tilerow_block_305_j0
	rjmp  tilerow_block_309_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_317_j0
	rjmp  tilerow_block_315_j0
	rjmp  tilerow_block_328_j0
	rjmp  tilerow_block_335_j0
	rjmp  tilerow_block_343_j0
	rjmp  tilerow_block_349_j0
	rjmp  tilerow_block_354_j0
	rjmp  tilerow_block_362_j0
	rjmp  tilerow_block_369_j0
	rjmp  tilerow_block_377_j0
	rjmp  tilerow_block_385_j0
	rjmp  tilerow_block_385_j0
	rjmp  tilerow_block_385_j0
	rjmp  tilerow_block_399_j0
	rjmp  tilerow_block_407_j0
	rjmp  tilerow_block_414_j0
	rjmp  tilerow_block_418_j0
	rjmp  tilerow_block_425_j0
	rjmp  tilerow_block_429_j0
	rjmp  tilerow_block_438_j0
	rjmp  tilerow_block_445_j0
	rjmp  tilerow_block_450_j0
	rjmp  tilerow_block_457_j0
	rjmp  tilerow_block_459_j0
	rjmp  tilerow_block_457_j0
	rjmp  tilerow_block_469_j0
	rjmp  tilerow_block_77_j0
	rjmp  tilerow_block_478_j0
	rjmp  tilerow_block_483_j0
	rjmp  tilerow_block_489_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_500_j0
	rjmp  tilerow_block_500_j0
	rjmp  tilerow_block_500_j0
	rjmp  tilerow_block_513_j0
	rjmp  tilerow_block_513_j0
	rjmp  tilerow_block_518_j0
	rjmp  tilerow_block_516_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_492_j0
	rjmp  tilerow_block_524_j0
	rjmp  tilerow_block_531_j0
	rjmp  tilerow_block_535_j0
	rjmp  tilerow_block_542_j0
	rjmp  tilerow_block_483_j0
	rjmp  tilerow_block_483_j0
	rjmp  tilerow_block_483_j0
	rjmp  tilerow_block_483_j0
	rjmp  tilerow_block_557_j0
	rjmp  tilerow_block_563_j0
	rjmp  tilerow_block_557_j0
	rjmp  tilerow_block_563_j0
	rjmp  tilerow_block_581_j0
	rjmp  tilerow_block_581_j0
	rjmp  tilerow_block_581_j0
	rjmp  tilerow_block_581_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0
	rjmp  tilerow_block_0_j0

tilerow_block_6:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_7:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_8:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r2
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_9:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_14:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r9
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_15:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_16:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r7
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_21:
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
tilerow_block_22:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r13
	rjmp  tilerow_common_1
tilerow_block_23:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r7
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_24:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r7
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_29:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r2
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_30:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r2
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_31:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r7
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_36:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_41:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_49:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_50:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_51:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r7
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r5
	rjmp  tilerow_common_1
tilerow_block_56:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r7
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_57:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r6
	rjmp  tilerow_common_1
tilerow_block_62:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r7
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r13
	rjmp  tilerow_common_1
tilerow_block_63:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r7
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_64:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r7
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_69:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r13
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_1
tilerow_block_70:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r6
	rjmp  tilerow_common_1
tilerow_block_71:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r12
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_1
tilerow_block_72:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r13
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r6
	rjmp  tilerow_common_1
tilerow_block_74:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r12
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r13
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r12
	rjmp  tilerow_common_1
tilerow_block_75:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r6
	rjmp  tilerow_common_1
tilerow_block_76:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r6
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_1
tilerow_block_77:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r6
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r5
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r5
	rjmp  tilerow_common_1
tilerow_block_81:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r15
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_82:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r2
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_83:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r9
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_84:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r2
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_89:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r8
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_90:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r8
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r7
	st    X+,      r7
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_91:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r7
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r9
	st    X+,      r7
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_92:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r7
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r8
	st    X+,      r7
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_97:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r8
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r7
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_98:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r12
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r7
	st    X+,      r7
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_99:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r8
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_100:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r7
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r7
	st    X+,      r7
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_109:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_110:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r15
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r9
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r15
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_111:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r9
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_116:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r9
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_117:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_118:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r7
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r15
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_123:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_124:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_125:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r15
	rjmp  tilerow_common_1
tilerow_block_126:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r2
	st    X+,      r7
	out   PIXOUT,  r23
	st    X+,      r15
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_130:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r13
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r15
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_131:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r13
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_132:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r7
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r7
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_133:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r7
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r9
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r13
	rjmp  tilerow_common_1
tilerow_block_138:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r9
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r7
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_139:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r7
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_140:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r8
	st    X+,      r7
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_141:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r13
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r8
	st    X+,      r7
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_146:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_147:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r7
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_1

.balign 512

tilerow_block_6_j0:
	rjmp  tilerow_block_6
tilerow_block_7_j0:
	rjmp  tilerow_block_7
tilerow_block_8_j0:
	rjmp  tilerow_block_8
tilerow_block_9_j0:
	rjmp  tilerow_block_9
tilerow_block_14_j0:
	rjmp  tilerow_block_14
tilerow_block_15_j0:
	rjmp  tilerow_block_15
tilerow_block_16_j0:
	rjmp  tilerow_block_16
tilerow_block_21_j0:
	rjmp  tilerow_block_21
tilerow_block_22_j0:
	rjmp  tilerow_block_22
tilerow_block_23_j0:
	rjmp  tilerow_block_23
tilerow_block_24_j0:
	rjmp  tilerow_block_24
tilerow_block_29_j0:
	rjmp  tilerow_block_29
tilerow_block_30_j0:
	rjmp  tilerow_block_30
tilerow_block_31_j0:
	rjmp  tilerow_block_31
tilerow_block_36_j0:
	rjmp  tilerow_block_36
tilerow_block_41_j0:
	rjmp  tilerow_block_41
tilerow_block_49_j0:
	rjmp  tilerow_block_49
tilerow_block_50_j0:
	rjmp  tilerow_block_50
tilerow_block_51_j0:
	rjmp  tilerow_block_51
tilerow_block_56_j0:
	rjmp  tilerow_block_56
tilerow_block_57_j0:
	rjmp  tilerow_block_57
tilerow_block_62_j0:
	rjmp  tilerow_block_62
tilerow_block_63_j0:
	rjmp  tilerow_block_63
tilerow_block_64_j0:
	rjmp  tilerow_block_64
tilerow_block_69_j0:
	rjmp  tilerow_block_69
tilerow_block_70_j0:
	rjmp  tilerow_block_70
tilerow_block_71_j0:
	rjmp  tilerow_block_71
tilerow_block_72_j0:
	rjmp  tilerow_block_72
tilerow_block_74_j0:
	rjmp  tilerow_block_74
tilerow_block_75_j0:
	rjmp  tilerow_block_75
tilerow_block_76_j0:
	rjmp  tilerow_block_76
tilerow_block_77_j0:
	rjmp  tilerow_block_77
tilerow_block_81_j0:
	rjmp  tilerow_block_81
tilerow_block_82_j0:
	rjmp  tilerow_block_82
tilerow_block_83_j0:
	rjmp  tilerow_block_83
tilerow_block_84_j0:
	rjmp  tilerow_block_84
tilerow_block_89_j0:
	rjmp  tilerow_block_89
tilerow_block_90_j0:
	rjmp  tilerow_block_90
tilerow_block_91_j0:
	rjmp  tilerow_block_91
tilerow_block_92_j0:
	rjmp  tilerow_block_92
tilerow_block_97_j0:
	rjmp  tilerow_block_97
tilerow_block_98_j0:
	rjmp  tilerow_block_98
tilerow_block_99_j0:
	rjmp  tilerow_block_99
tilerow_block_100_j0:
	rjmp  tilerow_block_100
tilerow_block_109_j0:
	rjmp  tilerow_block_109
tilerow_block_110_j0:
	rjmp  tilerow_block_110
tilerow_block_111_j0:
	rjmp  tilerow_block_111
tilerow_block_116_j0:
	rjmp  tilerow_block_116
tilerow_block_117_j0:
	rjmp  tilerow_block_117
tilerow_block_118_j0:
	rjmp  tilerow_block_118
tilerow_block_123_j0:
	rjmp  tilerow_block_123
tilerow_block_124_j0:
	rjmp  tilerow_block_124
tilerow_block_125_j0:
	rjmp  tilerow_block_125
tilerow_block_126_j0:
	rjmp  tilerow_block_126
tilerow_block_130_j0:
	rjmp  tilerow_block_130
tilerow_block_131_j0:
	rjmp  tilerow_block_131
tilerow_block_132_j0:
	rjmp  tilerow_block_132
tilerow_block_133_j0:
	rjmp  tilerow_block_133
tilerow_block_138_j0:
	rjmp  tilerow_block_138
tilerow_block_139_j0:
	rjmp  tilerow_block_139
tilerow_block_140_j0:
	rjmp  tilerow_block_140
tilerow_block_141_j0:
	rjmp  tilerow_block_141
tilerow_block_146_j0:
	rjmp  tilerow_block_146
tilerow_block_147_j0:
	rjmp  tilerow_block_147
tilerow_block_0_j0:
	rjmp  tilerow_block_0
tilerow_block_1_j0:
	rjmp  tilerow_block_1
tilerow_block_11_j0:
	rjmp  tilerow_block_11
tilerow_block_108_j0:
	rjmp  tilerow_block_108
tilerow_block_129_j0:
	rjmp  tilerow_block_129
tilerow_block_197_j0:
	rjmp  tilerow_block_197
tilerow_block_198_j0:
	rjmp  tilerow_block_198
tilerow_block_204_j0:
	rjmp  tilerow_block_204
tilerow_block_236_j0:
	rjmp  tilerow_block_236
tilerow_block_314_j0:
	rjmp  tilerow_block_314
tilerow_block_325_j0:
	rjmp  tilerow_block_325
tilerow_block_326_j0:
	rjmp  tilerow_block_326
tilerow_block_327_j0:
	rjmp  tilerow_block_327
tilerow_block_333_j0:
	rjmp  tilerow_block_333
tilerow_block_354_j0:
	rjmp  tilerow_block_354
tilerow_block_384_j0:
	rjmp  tilerow_block_384
tilerow_block_385_j0:
	rjmp  tilerow_block_385
tilerow_block_394_j0:
	rjmp  tilerow_block_394
tilerow_block_397_j0:
	rjmp  tilerow_block_397
tilerow_block_429_j0:
	rjmp  tilerow_block_429
tilerow_block_455_j0:
	rjmp  tilerow_block_455
tilerow_block_456_j0:
	rjmp  tilerow_block_456
tilerow_block_459_j0:
	rjmp  tilerow_block_459
tilerow_block_461_j0:
	rjmp  tilerow_block_461
tilerow_block_463_j0:
	rjmp  tilerow_block_463
tilerow_block_487_j0:
	rjmp  tilerow_block_487
tilerow_block_491_j0:
	rjmp  tilerow_block_491
tilerow_block_492_j0:
	rjmp  tilerow_block_492
tilerow_block_493_j0:
	rjmp  tilerow_block_493
tilerow_block_494_j0:
	rjmp  tilerow_block_494
tilerow_block_498_j0:
	rjmp  tilerow_block_498
tilerow_block_501_j0:
	rjmp  tilerow_block_501
tilerow_block_502_j0:
	rjmp  tilerow_block_502
tilerow_block_510_j0:
	rjmp  tilerow_block_510
tilerow_block_511_j0:
	rjmp  tilerow_block_511
tilerow_block_512_j0:
	rjmp  tilerow_block_512
tilerow_block_513_j0:
	rjmp  tilerow_block_513
tilerow_block_514_j0:
	rjmp  tilerow_block_514
tilerow_block_516_j0:
	rjmp  tilerow_block_516
tilerow_block_2_j0:
	rjmp  tilerow_block_2
tilerow_block_3_j0:
	rjmp  tilerow_block_3
tilerow_block_4_j0:
	rjmp  tilerow_block_4
tilerow_block_5_j0:
	rjmp  tilerow_block_5
tilerow_block_10_j0:
	rjmp  tilerow_block_10
tilerow_block_12_j0:
	rjmp  tilerow_block_12
tilerow_block_13_j0:
	rjmp  tilerow_block_13
tilerow_block_17_j0:
	rjmp  tilerow_block_17
tilerow_block_18_j0:
	rjmp  tilerow_block_18
tilerow_block_19_j0:
	rjmp  tilerow_block_19
tilerow_block_20_j0:
	rjmp  tilerow_block_20
tilerow_block_25_j0:
	rjmp  tilerow_block_25
tilerow_block_26_j0:
	rjmp  tilerow_block_26
tilerow_block_27_j0:
	rjmp  tilerow_block_27
tilerow_block_28_j0:
	rjmp  tilerow_block_28
tilerow_block_32_j0:
	rjmp  tilerow_block_32
tilerow_block_33_j0:
	rjmp  tilerow_block_33
tilerow_block_34_j0:
	rjmp  tilerow_block_34
tilerow_block_35_j0:
	rjmp  tilerow_block_35
tilerow_block_37_j0:
	rjmp  tilerow_block_37
tilerow_block_38_j0:
	rjmp  tilerow_block_38
tilerow_block_39_j0:
	rjmp  tilerow_block_39
tilerow_block_40_j0:
	rjmp  tilerow_block_40
tilerow_block_42_j0:
	rjmp  tilerow_block_42
tilerow_block_43_j0:
	rjmp  tilerow_block_43
tilerow_block_44_j0:
	rjmp  tilerow_block_44
tilerow_block_45_j0:
	rjmp  tilerow_block_45
tilerow_block_46_j0:
	rjmp  tilerow_block_46
tilerow_block_47_j0:
	rjmp  tilerow_block_47
tilerow_block_48_j0:
	rjmp  tilerow_block_48
tilerow_block_52_j0:
	rjmp  tilerow_block_52
tilerow_block_53_j0:
	rjmp  tilerow_block_53
tilerow_block_54_j0:
	rjmp  tilerow_block_54
tilerow_block_55_j0:
	rjmp  tilerow_block_55
tilerow_block_58_j0:
	rjmp  tilerow_block_58
tilerow_block_59_j0:
	rjmp  tilerow_block_59
tilerow_block_60_j0:
	rjmp  tilerow_block_60
tilerow_block_61_j0:
	rjmp  tilerow_block_61
tilerow_block_65_j0:
	rjmp  tilerow_block_65
tilerow_block_66_j0:
	rjmp  tilerow_block_66
tilerow_block_67_j0:
	rjmp  tilerow_block_67
tilerow_block_68_j0:
	rjmp  tilerow_block_68
tilerow_block_73_j0:
	rjmp  tilerow_block_73
tilerow_block_78_j0:
	rjmp  tilerow_block_78
tilerow_block_79_j0:
	rjmp  tilerow_block_79
tilerow_block_80_j0:
	rjmp  tilerow_block_80
tilerow_block_85_j0:
	rjmp  tilerow_block_85
tilerow_block_86_j0:
	rjmp  tilerow_block_86
tilerow_block_87_j0:
	rjmp  tilerow_block_87
tilerow_block_88_j0:
	rjmp  tilerow_block_88
tilerow_block_93_j0:
	rjmp  tilerow_block_93
tilerow_block_94_j0:
	rjmp  tilerow_block_94
tilerow_block_95_j0:
	rjmp  tilerow_block_95
tilerow_block_96_j0:
	rjmp  tilerow_block_96
tilerow_block_101_j0:
	rjmp  tilerow_block_101
tilerow_block_102_j0:
	rjmp  tilerow_block_102
tilerow_block_103_j0:
	rjmp  tilerow_block_103
tilerow_block_104_j0:
	rjmp  tilerow_block_104
tilerow_block_105_j0:
	rjmp  tilerow_block_105
tilerow_block_106_j0:
	rjmp  tilerow_block_106
tilerow_block_107_j0:
	rjmp  tilerow_block_107
tilerow_block_112_j0:
	rjmp  tilerow_block_112
tilerow_block_113_j0:
	rjmp  tilerow_block_113
tilerow_block_114_j0:
	rjmp  tilerow_block_114
tilerow_block_115_j0:
	rjmp  tilerow_block_115
tilerow_block_119_j0:
	rjmp  tilerow_block_119
tilerow_block_120_j0:
	rjmp  tilerow_block_120
tilerow_block_121_j0:
	rjmp  tilerow_block_121
tilerow_block_122_j0:
	rjmp  tilerow_block_122
tilerow_block_127_j0:
	rjmp  tilerow_block_127
tilerow_block_128_j0:
	rjmp  tilerow_block_128
tilerow_block_134_j0:
	rjmp  tilerow_block_134
tilerow_block_135_j0:
	rjmp  tilerow_block_135
tilerow_block_136_j0:
	rjmp  tilerow_block_136
tilerow_block_137_j0:
	rjmp  tilerow_block_137
tilerow_block_142_j0:
	rjmp  tilerow_block_142
tilerow_block_143_j0:
	rjmp  tilerow_block_143
tilerow_block_144_j0:
	rjmp  tilerow_block_144
tilerow_block_145_j0:
	rjmp  tilerow_block_145
tilerow_block_149_j0:
	rjmp  tilerow_block_149
tilerow_block_150_j0:
	rjmp  tilerow_block_150
tilerow_block_151_j0:
	rjmp  tilerow_block_151
tilerow_block_152_j0:
	rjmp  tilerow_block_152
tilerow_block_155_j0:
	rjmp  tilerow_block_155
tilerow_block_158_j0:
	rjmp  tilerow_block_158
tilerow_block_159_j0:
	rjmp  tilerow_block_159
tilerow_block_160_j0:
	rjmp  tilerow_block_160
tilerow_block_161_j0:
	rjmp  tilerow_block_161
tilerow_block_163_j0:
	rjmp  tilerow_block_163
tilerow_block_164_j0:
	rjmp  tilerow_block_164
tilerow_block_165_j0:
	rjmp  tilerow_block_165
tilerow_block_166_j0:
	rjmp  tilerow_block_166
tilerow_block_171_j0:
	rjmp  tilerow_block_171
tilerow_block_172_j0:
	rjmp  tilerow_block_172
tilerow_block_173_j0:
	rjmp  tilerow_block_173
tilerow_block_174_j0:
	rjmp  tilerow_block_174
tilerow_block_179_j0:
	rjmp  tilerow_block_179
tilerow_block_180_j0:
	rjmp  tilerow_block_180
tilerow_block_181_j0:
	rjmp  tilerow_block_181
tilerow_block_186_j0:
	rjmp  tilerow_block_186
tilerow_block_187_j0:
	rjmp  tilerow_block_187
tilerow_block_188_j0:
	rjmp  tilerow_block_188
tilerow_block_193_j0:
	rjmp  tilerow_block_193
tilerow_block_194_j0:
	rjmp  tilerow_block_194
tilerow_block_195_j0:
	rjmp  tilerow_block_195
tilerow_block_196_j0:
	rjmp  tilerow_block_196
tilerow_block_200_j0:
	rjmp  tilerow_block_200
tilerow_block_201_j0:
	rjmp  tilerow_block_201
tilerow_block_202_j0:
	rjmp  tilerow_block_202
tilerow_block_206_j0:
	rjmp  tilerow_block_206

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
	ldi   ZL,      LB_SPR_B - 1 ; (1626) 254(HI):255(LO): Sprite conf B
	sbic  GPR0,    0       ; (1627)
	ldi   ZL,      LB_SPR_A - 1 ; (1628) 252(HI):253(LO): Sprite conf A
	out   STACKL,  ZL      ; (1629)
	ret                    ; (1633)

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
	rjmp  tilerow_common_1
tilerow_block_1:
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
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_11:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_108:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_129:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_197:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_198:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r13
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_204:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r6
	rjmp  tilerow_common_1
tilerow_block_236:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r13
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_314:
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
	rjmp  tilerow_common_1
tilerow_block_325:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r6
	rjmp  tilerow_common_1
tilerow_block_326:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_1
tilerow_block_327:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_1
tilerow_block_333:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_1
tilerow_block_354:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_1
tilerow_block_384:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r15
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r15
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r15
	st    X+,      r13
	rjmp  tilerow_common_1
tilerow_block_385:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r13
	rjmp  tilerow_common_1
tilerow_block_394:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r15
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r15
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r13
	rjmp  tilerow_common_1
tilerow_block_397:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r17
	st    X+,      r17
	out   PIXOUT,  r22
	st    X+,      r17
	st    X+,      r17
	st    X+,      r17
	out   PIXOUT,  r23
	st    X+,      r17
	st    X+,      r15
	rjmp  tilerow_common_1
tilerow_block_429:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r6
	rjmp  tilerow_common_1
tilerow_block_455:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r13
	rjmp  tilerow_common_1
tilerow_block_456:
	out   PIXOUT,  r1
	st    X+,      r16
	st    X+,      r15
	st    X+,      r16
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r16
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r16
	st    X+,      r13
	rjmp  tilerow_common_1
tilerow_block_459:
	out   PIXOUT,  r1
	st    X+,      r16
	st    X+,      r13
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r16
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r16
	st    X+,      r13
	rjmp  tilerow_common_1
tilerow_block_461:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r13
	st    X+,      r16
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r15
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r16
	st    X+,      r13
	rjmp  tilerow_common_1
tilerow_block_463:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r13
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r15
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r15
	st    X+,      r13
	rjmp  tilerow_common_1
tilerow_block_487:
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
	st    X+,      r5
	rjmp  tilerow_common_1
tilerow_block_491:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_1
tilerow_block_492:
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
	rjmp  tilerow_common_1
tilerow_block_493:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_1
tilerow_block_494:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_1
tilerow_block_498:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r12
	rjmp  tilerow_common_1
tilerow_block_501:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r6
	rjmp  tilerow_common_1
tilerow_block_502:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r6
	rjmp  tilerow_common_1
tilerow_block_510:
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
	rjmp  tilerow_common_1
tilerow_block_511:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r6
	rjmp  tilerow_common_1
tilerow_block_512:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r6
	rjmp  tilerow_common_1
tilerow_block_513:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r12
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r5
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_1
tilerow_block_514:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r12
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r5
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r6
	rjmp  tilerow_common_1
tilerow_block_516:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_1
tilerow_block_2:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_3:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r2
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_4:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r8
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_5:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r8
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r7
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_10:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_12:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_13:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r7
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_17:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_18:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r7
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_19:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_20:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_25:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_26:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r7
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_27:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_28:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r7
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_32:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r7
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_33:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_34:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_35:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r9
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_37:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r2
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_38:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r9
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_39:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r9
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_40:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r9
	st    X+,      r7
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_42:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r2
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_43:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r2
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_44:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r2
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_45:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r8
	st    X+,      r7
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_46:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_47:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r2
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r2
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_48:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r7
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_52:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r5
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r6
	rjmp  tilerow_common_1
tilerow_block_53:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r9
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r12
	rjmp  tilerow_common_1
tilerow_block_54:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r13
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r13
	rjmp  tilerow_common_1
tilerow_block_55:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r13
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r13
	rjmp  tilerow_common_1
tilerow_block_58:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r7
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r5
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r6
	rjmp  tilerow_common_1
tilerow_block_59:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r6
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r12
	rjmp  tilerow_common_1
tilerow_block_60:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r6
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r13
	rjmp  tilerow_common_1
tilerow_block_61:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r12
	rjmp  tilerow_common_1
tilerow_block_65:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r7
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_66:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r7
	st    X+,      r7
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_67:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_68:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r13
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_73:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r5
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r6
	rjmp  tilerow_common_1
tilerow_block_78:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r5
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r6
	rjmp  tilerow_common_1
tilerow_block_79:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r12
	rjmp  tilerow_common_1
tilerow_block_80:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r13
	rjmp  tilerow_common_1
tilerow_block_85:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r9
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_86:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_87:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r2
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r8
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_88:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r8
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_93:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r7
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r12
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_94:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r7
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_95:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r7
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_96:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_101:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r7
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r7
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_102:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r7
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_103:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r8
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_104:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_105:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_106:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r9
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r15
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_107:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r15
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_112:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r7
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_113:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r2
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r7
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_114:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_115:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r9
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_119:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r8
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_120:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_121:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_122:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r13
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r7
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_127:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_128:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r2
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_134:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_135:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r9
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r7
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_136:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r13
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r7
	st    X+,      r7
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r8
	rjmp  tilerow_common_1
tilerow_block_137:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r8
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r7
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_142:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r7
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_143:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r8
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r7
	st    X+,      r7
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_144:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r7
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r8
	st    X+,      r7
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_145:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r13
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r7
	st    X+,      r7
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_149:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r2
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_150:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r8
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_151:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_152:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_155:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_158:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r7
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r12
	st    X+,      r7
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_159:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r2
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r7
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r6
	rjmp  tilerow_common_1
tilerow_block_160:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r7
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_161:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_1
tilerow_block_163:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r7
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r7
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_164:
	out   PIXOUT,  r1
	st    X+,      r7
	st    X+,      r7
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r7
	st    X+,      r7
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_165:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r12
	st    X+,      r7
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r7
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_166:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_171:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r9
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_172:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r9
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r9
	st    X+,      r12
	st    X+,      r8
	out   PIXOUT,  r23
	st    X+,      r9
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_173:
	out   PIXOUT,  r1
	st    X+,      r8
	st    X+,      r9
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r8
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r8
	st    X+,      r9
	rjmp  tilerow_common_1
tilerow_block_174:
	out   PIXOUT,  r1
	st    X+,      r9
	st    X+,      r8
	st    X+,      r8
	out   PIXOUT,  r22
	st    X+,      r7
	st    X+,      r8
	st    X+,      r9
	out   PIXOUT,  r23
	st    X+,      r7
	st    X+,      r7
	rjmp  tilerow_common_1
tilerow_block_179:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r6
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r6
	rjmp  tilerow_common_1
tilerow_block_180:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r6
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r12
	rjmp  tilerow_common_1
tilerow_block_181:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r13
	rjmp  tilerow_common_1
tilerow_block_186:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r6
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_187:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_188:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r13
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r13
	rjmp  tilerow_common_1
tilerow_block_193:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r6
	rjmp  tilerow_common_1
tilerow_block_194:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r12
	rjmp  tilerow_common_1
tilerow_block_195:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r13
	rjmp  tilerow_common_1
tilerow_block_196:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r13
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r13
	rjmp  tilerow_common_1
tilerow_block_200:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r6
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_201:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r6
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r2
	rjmp  tilerow_common_1
tilerow_block_202:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r13
	rjmp  tilerow_common_1
tilerow_block_206:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r12
	rjmp  tilerow_common_1

.balign 512

tilerow_block_0_j1:
	rjmp  tilerow_block_0
tilerow_block_1_j1:
	rjmp  tilerow_block_1
tilerow_block_11_j1:
	rjmp  tilerow_block_11
tilerow_block_108_j1:
	rjmp  tilerow_block_108
tilerow_block_129_j1:
	rjmp  tilerow_block_129
tilerow_block_197_j1:
	rjmp  tilerow_block_197
tilerow_block_198_j1:
	rjmp  tilerow_block_198
tilerow_block_204_j1:
	rjmp  tilerow_block_204
tilerow_block_236_j1:
	rjmp  tilerow_block_236
tilerow_block_314_j1:
	rjmp  tilerow_block_314
tilerow_block_325_j1:
	rjmp  tilerow_block_325
tilerow_block_326_j1:
	rjmp  tilerow_block_326
tilerow_block_327_j1:
	rjmp  tilerow_block_327
tilerow_block_333_j1:
	rjmp  tilerow_block_333
tilerow_block_354_j1:
	rjmp  tilerow_block_354
tilerow_block_384_j1:
	rjmp  tilerow_block_384
tilerow_block_385_j1:
	rjmp  tilerow_block_385
tilerow_block_394_j1:
	rjmp  tilerow_block_394
tilerow_block_397_j1:
	rjmp  tilerow_block_397
tilerow_block_429_j1:
	rjmp  tilerow_block_429
tilerow_block_455_j1:
	rjmp  tilerow_block_455
tilerow_block_456_j1:
	rjmp  tilerow_block_456
tilerow_block_459_j1:
	rjmp  tilerow_block_459
tilerow_block_461_j1:
	rjmp  tilerow_block_461
tilerow_block_463_j1:
	rjmp  tilerow_block_463
tilerow_block_487_j1:
	rjmp  tilerow_block_487
tilerow_block_491_j1:
	rjmp  tilerow_block_491
tilerow_block_492_j1:
	rjmp  tilerow_block_492
tilerow_block_493_j1:
	rjmp  tilerow_block_493
tilerow_block_494_j1:
	rjmp  tilerow_block_494
tilerow_block_498_j1:
	rjmp  tilerow_block_498
tilerow_block_501_j1:
	rjmp  tilerow_block_501
tilerow_block_502_j1:
	rjmp  tilerow_block_502
tilerow_block_510_j1:
	rjmp  tilerow_block_510
tilerow_block_511_j1:
	rjmp  tilerow_block_511
tilerow_block_512_j1:
	rjmp  tilerow_block_512
tilerow_block_513_j1:
	rjmp  tilerow_block_513
tilerow_block_514_j1:
	rjmp  tilerow_block_514
tilerow_block_516_j1:
	rjmp  tilerow_block_516
tilerow_block_2_j1:
	rjmp  tilerow_block_2
tilerow_block_3_j1:
	rjmp  tilerow_block_3
tilerow_block_4_j1:
	rjmp  tilerow_block_4
tilerow_block_5_j1:
	rjmp  tilerow_block_5
tilerow_block_10_j1:
	rjmp  tilerow_block_10
tilerow_block_12_j1:
	rjmp  tilerow_block_12
tilerow_block_13_j1:
	rjmp  tilerow_block_13
tilerow_block_17_j1:
	rjmp  tilerow_block_17
tilerow_block_18_j1:
	rjmp  tilerow_block_18
tilerow_block_19_j1:
	rjmp  tilerow_block_19
tilerow_block_20_j1:
	rjmp  tilerow_block_20
tilerow_block_25_j1:
	rjmp  tilerow_block_25
tilerow_block_26_j1:
	rjmp  tilerow_block_26
tilerow_block_27_j1:
	rjmp  tilerow_block_27
tilerow_block_28_j1:
	rjmp  tilerow_block_28
tilerow_block_32_j1:
	rjmp  tilerow_block_32
tilerow_block_33_j1:
	rjmp  tilerow_block_33
tilerow_block_34_j1:
	rjmp  tilerow_block_34
tilerow_block_35_j1:
	rjmp  tilerow_block_35
tilerow_block_37_j1:
	rjmp  tilerow_block_37
tilerow_block_38_j1:
	rjmp  tilerow_block_38
tilerow_block_39_j1:
	rjmp  tilerow_block_39
tilerow_block_40_j1:
	rjmp  tilerow_block_40
tilerow_block_42_j1:
	rjmp  tilerow_block_42
tilerow_block_43_j1:
	rjmp  tilerow_block_43
tilerow_block_44_j1:
	rjmp  tilerow_block_44
tilerow_block_45_j1:
	rjmp  tilerow_block_45
tilerow_block_46_j1:
	rjmp  tilerow_block_46
tilerow_block_47_j1:
	rjmp  tilerow_block_47
tilerow_block_48_j1:
	rjmp  tilerow_block_48
tilerow_block_52_j1:
	rjmp  tilerow_block_52
tilerow_block_53_j1:
	rjmp  tilerow_block_53
tilerow_block_54_j1:
	rjmp  tilerow_block_54
tilerow_block_55_j1:
	rjmp  tilerow_block_55
tilerow_block_58_j1:
	rjmp  tilerow_block_58
tilerow_block_59_j1:
	rjmp  tilerow_block_59
tilerow_block_60_j1:
	rjmp  tilerow_block_60
tilerow_block_61_j1:
	rjmp  tilerow_block_61
tilerow_block_65_j1:
	rjmp  tilerow_block_65
tilerow_block_66_j1:
	rjmp  tilerow_block_66
tilerow_block_67_j1:
	rjmp  tilerow_block_67
tilerow_block_68_j1:
	rjmp  tilerow_block_68
tilerow_block_73_j1:
	rjmp  tilerow_block_73
tilerow_block_78_j1:
	rjmp  tilerow_block_78
tilerow_block_79_j1:
	rjmp  tilerow_block_79
tilerow_block_80_j1:
	rjmp  tilerow_block_80
tilerow_block_85_j1:
	rjmp  tilerow_block_85
tilerow_block_86_j1:
	rjmp  tilerow_block_86
tilerow_block_87_j1:
	rjmp  tilerow_block_87
tilerow_block_88_j1:
	rjmp  tilerow_block_88
tilerow_block_93_j1:
	rjmp  tilerow_block_93
tilerow_block_94_j1:
	rjmp  tilerow_block_94
tilerow_block_95_j1:
	rjmp  tilerow_block_95
tilerow_block_96_j1:
	rjmp  tilerow_block_96
tilerow_block_101_j1:
	rjmp  tilerow_block_101
tilerow_block_102_j1:
	rjmp  tilerow_block_102
tilerow_block_103_j1:
	rjmp  tilerow_block_103
tilerow_block_104_j1:
	rjmp  tilerow_block_104
tilerow_block_105_j1:
	rjmp  tilerow_block_105
tilerow_block_106_j1:
	rjmp  tilerow_block_106
tilerow_block_107_j1:
	rjmp  tilerow_block_107
tilerow_block_112_j1:
	rjmp  tilerow_block_112
tilerow_block_113_j1:
	rjmp  tilerow_block_113
tilerow_block_114_j1:
	rjmp  tilerow_block_114
tilerow_block_115_j1:
	rjmp  tilerow_block_115
tilerow_block_119_j1:
	rjmp  tilerow_block_119
tilerow_block_120_j1:
	rjmp  tilerow_block_120
tilerow_block_121_j1:
	rjmp  tilerow_block_121
tilerow_block_122_j1:
	rjmp  tilerow_block_122
tilerow_block_127_j1:
	rjmp  tilerow_block_127
tilerow_block_128_j1:
	rjmp  tilerow_block_128
tilerow_block_134_j1:
	rjmp  tilerow_block_134
tilerow_block_135_j1:
	rjmp  tilerow_block_135
tilerow_block_136_j1:
	rjmp  tilerow_block_136
tilerow_block_137_j1:
	rjmp  tilerow_block_137
tilerow_block_142_j1:
	rjmp  tilerow_block_142
tilerow_block_143_j1:
	rjmp  tilerow_block_143
tilerow_block_144_j1:
	rjmp  tilerow_block_144
tilerow_block_145_j1:
	rjmp  tilerow_block_145
tilerow_block_149_j1:
	rjmp  tilerow_block_149
tilerow_block_150_j1:
	rjmp  tilerow_block_150
tilerow_block_151_j1:
	rjmp  tilerow_block_151
tilerow_block_152_j1:
	rjmp  tilerow_block_152
tilerow_block_155_j1:
	rjmp  tilerow_block_155
tilerow_block_158_j1:
	rjmp  tilerow_block_158
tilerow_block_159_j1:
	rjmp  tilerow_block_159
tilerow_block_160_j1:
	rjmp  tilerow_block_160
tilerow_block_161_j1:
	rjmp  tilerow_block_161
tilerow_block_163_j1:
	rjmp  tilerow_block_163
tilerow_block_164_j1:
	rjmp  tilerow_block_164
tilerow_block_165_j1:
	rjmp  tilerow_block_165
tilerow_block_166_j1:
	rjmp  tilerow_block_166
tilerow_block_171_j1:
	rjmp  tilerow_block_171
tilerow_block_172_j1:
	rjmp  tilerow_block_172
tilerow_block_173_j1:
	rjmp  tilerow_block_173
tilerow_block_174_j1:
	rjmp  tilerow_block_174
tilerow_block_179_j1:
	rjmp  tilerow_block_179
tilerow_block_180_j1:
	rjmp  tilerow_block_180
tilerow_block_181_j1:
	rjmp  tilerow_block_181
tilerow_block_186_j1:
	rjmp  tilerow_block_186
tilerow_block_187_j1:
	rjmp  tilerow_block_187
tilerow_block_188_j1:
	rjmp  tilerow_block_188
tilerow_block_193_j1:
	rjmp  tilerow_block_193
tilerow_block_194_j1:
	rjmp  tilerow_block_194
tilerow_block_195_j1:
	rjmp  tilerow_block_195
tilerow_block_196_j1:
	rjmp  tilerow_block_196
tilerow_block_200_j1:
	rjmp  tilerow_block_200
tilerow_block_201_j1:
	rjmp  tilerow_block_201
tilerow_block_202_j1:
	rjmp  tilerow_block_202
tilerow_block_206_j1:
	rjmp  tilerow_block_206
tilerow_block_207_j1:
	rjmp  tilerow_block_207
tilerow_block_208_j1:
	rjmp  tilerow_block_208
tilerow_block_211_j1:
	rjmp  tilerow_block_211
tilerow_block_212_j1:
	rjmp  tilerow_block_212
tilerow_block_217_j1:
	rjmp  tilerow_block_217
tilerow_block_218_j1:
	rjmp  tilerow_block_218
tilerow_block_219_j1:
	rjmp  tilerow_block_219
tilerow_block_220_j1:
	rjmp  tilerow_block_220
tilerow_block_225_j1:
	rjmp  tilerow_block_225
tilerow_block_226_j1:
	rjmp  tilerow_block_226
tilerow_block_227_j1:
	rjmp  tilerow_block_227
tilerow_block_228_j1:
	rjmp  tilerow_block_228
tilerow_block_233_j1:
	rjmp  tilerow_block_233
tilerow_block_234_j1:
	rjmp  tilerow_block_234
tilerow_block_235_j1:
	rjmp  tilerow_block_235
tilerow_block_240_j1:
	rjmp  tilerow_block_240
tilerow_block_241_j1:
	rjmp  tilerow_block_241
tilerow_block_246_j1:
	rjmp  tilerow_block_246
tilerow_block_247_j1:
	rjmp  tilerow_block_247
tilerow_block_248_j1:
	rjmp  tilerow_block_248
tilerow_block_249_j1:
	rjmp  tilerow_block_249
tilerow_block_254_j1:
	rjmp  tilerow_block_254
tilerow_block_255_j1:
	rjmp  tilerow_block_255
tilerow_block_256_j1:
	rjmp  tilerow_block_256
tilerow_block_261_j1:
	rjmp  tilerow_block_261
tilerow_block_262_j1:
	rjmp  tilerow_block_262
tilerow_block_263_j1:
	rjmp  tilerow_block_263
tilerow_block_264_j1:
	rjmp  tilerow_block_264
tilerow_block_268_j1:
	rjmp  tilerow_block_268
tilerow_block_269_j1:
	rjmp  tilerow_block_269
tilerow_block_270_j1:
	rjmp  tilerow_block_270
tilerow_block_275_j1:
	rjmp  tilerow_block_275
tilerow_block_276_j1:
	rjmp  tilerow_block_276
tilerow_block_277_j1:
	rjmp  tilerow_block_277
tilerow_block_295_j1:
	rjmp  tilerow_block_295
tilerow_block_296_j1:
	rjmp  tilerow_block_296
tilerow_block_297_j1:
	rjmp  tilerow_block_297
tilerow_block_298_j1:
	rjmp  tilerow_block_298
tilerow_block_300_j1:
	rjmp  tilerow_block_300
tilerow_block_301_j1:
	rjmp  tilerow_block_301
tilerow_block_306_j1:
	rjmp  tilerow_block_306
tilerow_block_307_j1:
	rjmp  tilerow_block_307
tilerow_block_310_j1:
	rjmp  tilerow_block_310
tilerow_block_311_j1:
	rjmp  tilerow_block_311
tilerow_block_312_j1:
	rjmp  tilerow_block_312
tilerow_block_313_j1:
	rjmp  tilerow_block_313
tilerow_block_318_j1:
	rjmp  tilerow_block_318
tilerow_block_319_j1:
	rjmp  tilerow_block_319
tilerow_block_320_j1:
	rjmp  tilerow_block_320
tilerow_block_323_j1:
	rjmp  tilerow_block_323
tilerow_block_324_j1:
	rjmp  tilerow_block_324
tilerow_block_329_j1:
	rjmp  tilerow_block_329
tilerow_block_330_j1:
	rjmp  tilerow_block_330
tilerow_block_331_j1:
	rjmp  tilerow_block_331
tilerow_block_336_j1:
	rjmp  tilerow_block_336
tilerow_block_337_j1:
	rjmp  tilerow_block_337
tilerow_block_338_j1:
	rjmp  tilerow_block_338
tilerow_block_339_j1:
	rjmp  tilerow_block_339
tilerow_block_344_j1:
	rjmp  tilerow_block_344
tilerow_block_345_j1:
	rjmp  tilerow_block_345
tilerow_block_350_j1:
	rjmp  tilerow_block_350
tilerow_block_351_j1:
	rjmp  tilerow_block_351
tilerow_block_352_j1:
	rjmp  tilerow_block_352
tilerow_block_356_j1:
	rjmp  tilerow_block_356

tilerow_common_2:
	out   PIXOUT,  r0
	breq  tilerow_exit_c_2 ; Uses Z flag
	pop   r0
tilerow_entry_2:
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
	ijmp
tilerow_exit_c_2:
	brts  tilerow_exit_2   ; (1582 / 1621)
	mov   r22,     r17
	mov   r23,     r17
	movw  r0,      r22
	out   PIXOUT,  r17
	ld    ZL,      Y+
	set
	ijmp
tilerow_exit_2:
	sbic  GPR0,    1       ; (1622) Color 0 (bg) loading enabled?
	in    r2,      GPR1    ; (1623) If so, load it
	sbic  GPR0,    2       ; (1624) Color 15 (border) loading enabled?
	in    r17,     GPR1    ; (1625) If so, load it
	ldi   ZL,      LB_SPR_B - 1 ; (1626) 254(HI):255(LO): Sprite conf B
	sbic  GPR0,    0       ; (1627)
	ldi   ZL,      LB_SPR_A - 1 ; (1628) 252(HI):253(LO): Sprite conf A
	out   STACKL,  ZL      ; (1629)
	ret                    ; (1633)

tilerow_block_207:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r13
	rjmp  tilerow_common_2
tilerow_block_208:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r13
	rjmp  tilerow_common_2
tilerow_block_211:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r2
	rjmp  tilerow_common_2
tilerow_block_212:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r2
	rjmp  tilerow_common_2
tilerow_block_217:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r12
	rjmp  tilerow_common_2
tilerow_block_218:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_2
tilerow_block_219:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r5
	rjmp  tilerow_common_2
tilerow_block_220:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r12
	rjmp  tilerow_common_2
tilerow_block_225:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r5
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r13
	rjmp  tilerow_common_2
tilerow_block_226:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r5
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r2
	rjmp  tilerow_common_2
tilerow_block_227:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r2
	rjmp  tilerow_common_2
tilerow_block_228:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r13
	rjmp  tilerow_common_2
tilerow_block_233:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r12
	rjmp  tilerow_common_2
tilerow_block_234:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r5
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_2
tilerow_block_235:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r5
	rjmp  tilerow_common_2
tilerow_block_240:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r5
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r13
	rjmp  tilerow_common_2
tilerow_block_241:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r5
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r13
	rjmp  tilerow_common_2
tilerow_block_246:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r12
	rjmp  tilerow_common_2
tilerow_block_247:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r6
	rjmp  tilerow_common_2
tilerow_block_248:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r13
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r12
	rjmp  tilerow_common_2
tilerow_block_249:
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
	st    X+,      r13
	rjmp  tilerow_common_2
tilerow_block_254:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r6
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r13
	rjmp  tilerow_common_2
tilerow_block_255:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r6
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r2
	rjmp  tilerow_common_2
tilerow_block_256:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r13
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_2
tilerow_block_261:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r6
	rjmp  tilerow_common_2
tilerow_block_262:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r5
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_2
tilerow_block_263:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_2
tilerow_block_264:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_2
tilerow_block_268:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r12
	rjmp  tilerow_common_2
tilerow_block_269:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r5
	rjmp  tilerow_common_2
tilerow_block_270:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r12
	rjmp  tilerow_common_2
tilerow_block_275:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r5
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r13
	rjmp  tilerow_common_2
tilerow_block_276:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r12
	rjmp  tilerow_common_2
tilerow_block_277:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r6
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r13
	rjmp  tilerow_common_2
tilerow_block_295:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_2
tilerow_block_296:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_2
tilerow_block_297:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r5
	rjmp  tilerow_common_2
tilerow_block_298:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r13
	rjmp  tilerow_common_2
tilerow_block_300:
	out   PIXOUT,  r1
	st    X+,      r2
	st    X+,      r17
	st    X+,      r17
	out   PIXOUT,  r22
	st    X+,      r17
	st    X+,      r17
	st    X+,      r17
	out   PIXOUT,  r23
	st    X+,      r17
	st    X+,      r17
	rjmp  tilerow_common_2
tilerow_block_301:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r17
	st    X+,      r16
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r15
	st    X+,      r16
	out   PIXOUT,  r23
	st    X+,      r15
	st    X+,      r15
	rjmp  tilerow_common_2
tilerow_block_306:
	out   PIXOUT,  r1
	st    X+,      r16
	st    X+,      r17
	st    X+,      r16
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r16
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r15
	st    X+,      r17
	rjmp  tilerow_common_2
tilerow_block_307:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r15
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r15
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r16
	st    X+,      r15
	rjmp  tilerow_common_2
tilerow_block_310:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r2
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r17
	st    X+,      r17
	st    X+,      r17
	out   PIXOUT,  r23
	st    X+,      r17
	st    X+,      r17
	rjmp  tilerow_common_2
tilerow_block_311:
	out   PIXOUT,  r1
	st    X+,      r16
	st    X+,      r17
	st    X+,      r16
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r15
	st    X+,      r16
	out   PIXOUT,  r23
	st    X+,      r15
	st    X+,      r15
	rjmp  tilerow_common_2
tilerow_block_312:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r17
	st    X+,      r17
	out   PIXOUT,  r22
	st    X+,      r17
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r2
	st    X+,      r2
	rjmp  tilerow_common_2
tilerow_block_313:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r16
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r17
	st    X+,      r17
	out   PIXOUT,  r23
	st    X+,      r17
	st    X+,      r17
	rjmp  tilerow_common_2
tilerow_block_318:
	out   PIXOUT,  r1
	st    X+,      r4
	st    X+,      r4
	st    X+,      r3
	out   PIXOUT,  r22
	st    X+,      r3
	st    X+,      r3
	st    X+,      r4
	out   PIXOUT,  r23
	st    X+,      r4
	st    X+,      r4
	rjmp  tilerow_common_2
tilerow_block_319:
	out   PIXOUT,  r1
	st    X+,      r4
	st    X+,      r4
	st    X+,      r4
	out   PIXOUT,  r22
	st    X+,      r4
	st    X+,      r4
	st    X+,      r4
	out   PIXOUT,  r23
	st    X+,      r3
	st    X+,      r3
	rjmp  tilerow_common_2
tilerow_block_320:
	out   PIXOUT,  r1
	st    X+,      r4
	st    X+,      r3
	st    X+,      r3
	out   PIXOUT,  r22
	st    X+,      r4
	st    X+,      r4
	st    X+,      r4
	out   PIXOUT,  r23
	st    X+,      r4
	st    X+,      r4
	rjmp  tilerow_common_2
tilerow_block_323:
	out   PIXOUT,  r1
	st    X+,      r4
	st    X+,      r4
	st    X+,      r4
	out   PIXOUT,  r22
	st    X+,      r4
	st    X+,      r3
	st    X+,      r3
	out   PIXOUT,  r23
	st    X+,      r3
	st    X+,      r4
	rjmp  tilerow_common_2
tilerow_block_324:
	out   PIXOUT,  r1
	st    X+,      r3
	st    X+,      r4
	st    X+,      r4
	out   PIXOUT,  r22
	st    X+,      r4
	st    X+,      r4
	st    X+,      r4
	out   PIXOUT,  r23
	st    X+,      r4
	st    X+,      r3
	rjmp  tilerow_common_2
tilerow_block_329:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r6
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_2
tilerow_block_330:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r5
	rjmp  tilerow_common_2
tilerow_block_331:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_2
tilerow_block_336:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r6
	rjmp  tilerow_common_2
tilerow_block_337:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r13
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_2
tilerow_block_338:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r13
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r6
	rjmp  tilerow_common_2
tilerow_block_339:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r13
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_2
tilerow_block_344:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_2
tilerow_block_345:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_2
tilerow_block_350:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r13
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r6
	rjmp  tilerow_common_2
tilerow_block_351:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r6
	rjmp  tilerow_common_2
tilerow_block_352:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r6
	rjmp  tilerow_common_2
tilerow_block_356:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_2

.balign 512
tilerow_4_map:
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_2_j1
	rjmp  tilerow_block_10_j1
	rjmp  tilerow_block_17_j1
	rjmp  tilerow_block_25_j1
	rjmp  tilerow_block_32_j1
	rjmp  tilerow_block_37_j1
	rjmp  tilerow_block_42_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_52_j1
	rjmp  tilerow_block_58_j1
	rjmp  tilerow_block_65_j1
	rjmp  tilerow_block_73_j1
	rjmp  tilerow_block_78_j1
	rjmp  tilerow_block_85_j1
	rjmp  tilerow_block_93_j1
	rjmp  tilerow_block_101_j1
	rjmp  tilerow_block_1_j1
	rjmp  tilerow_block_112_j1
	rjmp  tilerow_block_119_j1
	rjmp  tilerow_block_127_j1
	rjmp  tilerow_block_134_j1
	rjmp  tilerow_block_142_j1
	rjmp  tilerow_block_149_j1
	rjmp  tilerow_block_155_j1
	rjmp  tilerow_block_158_j1
	rjmp  tilerow_block_163_j1
	rjmp  tilerow_block_171_j1
	rjmp  tilerow_block_179_j1
	rjmp  tilerow_block_186_j1
	rjmp  tilerow_block_193_j1
	rjmp  tilerow_block_200_j1
	rjmp  tilerow_block_193_j1
	rjmp  tilerow_block_211_j1
	rjmp  tilerow_block_217_j1
	rjmp  tilerow_block_225_j1
	rjmp  tilerow_block_233_j1
	rjmp  tilerow_block_240_j1
	rjmp  tilerow_block_246_j1
	rjmp  tilerow_block_254_j1
	rjmp  tilerow_block_261_j1
	rjmp  tilerow_block_268_j1
	rjmp  tilerow_block_275_j1
	rjmp  tilerow_block_78_j1
	rjmp  tilerow_block_73_j1
	rjmp  tilerow_block_78_j1
	rjmp  tilerow_block_73_j1
	rjmp  tilerow_block_295_j1
	rjmp  tilerow_block_300_j1
	rjmp  tilerow_block_306_j1
	rjmp  tilerow_block_310_j1
	rjmp  tilerow_block_312_j1
	rjmp  tilerow_block_314_j1
	rjmp  tilerow_block_323_j1
	rjmp  tilerow_block_327_j1
	rjmp  tilerow_block_336_j1
	rjmp  tilerow_block_344_j1
	rjmp  tilerow_block_350_j1
	rjmp  tilerow_block_356_j1
	rjmp  tilerow_block_363_j1
	rjmp  tilerow_block_370_j1
	rjmp  tilerow_block_378_j1
	rjmp  tilerow_block_386_j1
	rjmp  tilerow_block_390_j1
	rjmp  tilerow_block_386_j1
	rjmp  tilerow_block_400_j1
	rjmp  tilerow_block_408_j1
	rjmp  tilerow_block_397_j1
	rjmp  tilerow_block_419_j1
	rjmp  tilerow_block_426_j1
	rjmp  tilerow_block_432_j1
	rjmp  tilerow_block_439_j1
	rjmp  tilerow_block_432_j1
	rjmp  tilerow_block_451_j1
	rjmp  tilerow_block_458_j1
	rjmp  tilerow_block_460_j1
	rjmp  tilerow_block_461_j1
	rjmp  tilerow_block_451_j1
	rjmp  tilerow_block_78_j1
	rjmp  tilerow_block_479_j1
	rjmp  tilerow_block_484_j1
	rjmp  tilerow_block_490_j1
	rjmp  tilerow_block_495_j1
	rjmp  tilerow_block_493_j1
	rjmp  tilerow_block_204_j1
	rjmp  tilerow_block_195_j1
	rjmp  tilerow_block_507_j1
	rjmp  tilerow_block_514_j1
	rjmp  tilerow_block_514_j1
	rjmp  tilerow_block_519_j1
	rjmp  tilerow_block_522_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_525_j1
	rjmp  tilerow_block_532_j1
	rjmp  tilerow_block_536_j1
	rjmp  tilerow_block_543_j1
	rjmp  tilerow_block_484_j1
	rjmp  tilerow_block_484_j1
	rjmp  tilerow_block_484_j1
	rjmp  tilerow_block_484_j1
	rjmp  tilerow_block_558_j1
	rjmp  tilerow_block_564_j1
	rjmp  tilerow_block_569_j1
	rjmp  tilerow_block_574_j1
	rjmp  tilerow_block_582_j1
	rjmp  tilerow_block_582_j1
	rjmp  tilerow_block_582_j1
	rjmp  tilerow_block_582_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1


.balign 512
tilerow_5_map:
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_3_j1
	rjmp  tilerow_block_11_j1
	rjmp  tilerow_block_18_j1
	rjmp  tilerow_block_26_j1
	rjmp  tilerow_block_33_j1
	rjmp  tilerow_block_38_j1
	rjmp  tilerow_block_43_j1
	rjmp  tilerow_block_46_j1
	rjmp  tilerow_block_53_j1
	rjmp  tilerow_block_59_j1
	rjmp  tilerow_block_66_j1
	rjmp  tilerow_block_59_j1
	rjmp  tilerow_block_79_j1
	rjmp  tilerow_block_86_j1
	rjmp  tilerow_block_94_j1
	rjmp  tilerow_block_102_j1
	rjmp  tilerow_block_105_j1
	rjmp  tilerow_block_113_j1
	rjmp  tilerow_block_120_j1
	rjmp  tilerow_block_128_j1
	rjmp  tilerow_block_135_j1
	rjmp  tilerow_block_143_j1
	rjmp  tilerow_block_150_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_159_j1
	rjmp  tilerow_block_164_j1
	rjmp  tilerow_block_172_j1
	rjmp  tilerow_block_180_j1
	rjmp  tilerow_block_187_j1
	rjmp  tilerow_block_194_j1
	rjmp  tilerow_block_201_j1
	rjmp  tilerow_block_206_j1
	rjmp  tilerow_block_212_j1
	rjmp  tilerow_block_218_j1
	rjmp  tilerow_block_226_j1
	rjmp  tilerow_block_234_j1
	rjmp  tilerow_block_241_j1
	rjmp  tilerow_block_247_j1
	rjmp  tilerow_block_255_j1
	rjmp  tilerow_block_262_j1
	rjmp  tilerow_block_262_j1
	rjmp  tilerow_block_276_j1
	rjmp  tilerow_block_79_j1
	rjmp  tilerow_block_59_j1
	rjmp  tilerow_block_79_j1
	rjmp  tilerow_block_59_j1
	rjmp  tilerow_block_296_j1
	rjmp  tilerow_block_301_j1
	rjmp  tilerow_block_307_j1
	rjmp  tilerow_block_311_j1
	rjmp  tilerow_block_313_j1
	rjmp  tilerow_block_318_j1
	rjmp  tilerow_block_314_j1
	rjmp  tilerow_block_329_j1
	rjmp  tilerow_block_337_j1
	rjmp  tilerow_block_345_j1
	rjmp  tilerow_block_351_j1
	rjmp  tilerow_block_357_j1
	rjmp  tilerow_block_364_j1
	rjmp  tilerow_block_371_j1
	rjmp  tilerow_block_379_j1
	rjmp  tilerow_block_387_j1
	rjmp  tilerow_block_391_j1
	rjmp  tilerow_block_395_j1
	rjmp  tilerow_block_401_j1
	rjmp  tilerow_block_409_j1
	rjmp  tilerow_block_384_j1
	rjmp  tilerow_block_420_j1
	rjmp  tilerow_block_427_j1
	rjmp  tilerow_block_433_j1
	rjmp  tilerow_block_440_j1
	rjmp  tilerow_block_433_j1
	rjmp  tilerow_block_452_j1
	rjmp  tilerow_block_459_j1
	rjmp  tilerow_block_462_j1
	rjmp  tilerow_block_465_j1
	rjmp  tilerow_block_452_j1
	rjmp  tilerow_block_473_j1
	rjmp  tilerow_block_480_j1
	rjmp  tilerow_block_485_j1
	rjmp  tilerow_block_490_j1
	rjmp  tilerow_block_491_j1
	rjmp  tilerow_block_487_j1
	rjmp  tilerow_block_501_j1
	rjmp  tilerow_block_498_j1
	rjmp  tilerow_block_508_j1
	rjmp  tilerow_block_514_j1
	rjmp  tilerow_block_512_j1
	rjmp  tilerow_block_519_j1
	rjmp  tilerow_block_510_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_526_j1
	rjmp  tilerow_block_527_j1
	rjmp  tilerow_block_537_j1
	rjmp  tilerow_block_544_j1
	rjmp  tilerow_block_485_j1
	rjmp  tilerow_block_485_j1
	rjmp  tilerow_block_485_j1
	rjmp  tilerow_block_485_j1
	rjmp  tilerow_block_559_j1
	rjmp  tilerow_block_565_j1
	rjmp  tilerow_block_570_j1
	rjmp  tilerow_block_575_j1
	rjmp  tilerow_block_490_j1
	rjmp  tilerow_block_490_j1
	rjmp  tilerow_block_490_j1
	rjmp  tilerow_block_490_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1


.balign 512
tilerow_6_map:
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_4_j1
	rjmp  tilerow_block_12_j1
	rjmp  tilerow_block_19_j1
	rjmp  tilerow_block_27_j1
	rjmp  tilerow_block_34_j1
	rjmp  tilerow_block_39_j1
	rjmp  tilerow_block_44_j1
	rjmp  tilerow_block_47_j1
	rjmp  tilerow_block_54_j1
	rjmp  tilerow_block_60_j1
	rjmp  tilerow_block_67_j1
	rjmp  tilerow_block_60_j1
	rjmp  tilerow_block_80_j1
	rjmp  tilerow_block_87_j1
	rjmp  tilerow_block_95_j1
	rjmp  tilerow_block_103_j1
	rjmp  tilerow_block_106_j1
	rjmp  tilerow_block_114_j1
	rjmp  tilerow_block_121_j1
	rjmp  tilerow_block_129_j1
	rjmp  tilerow_block_136_j1
	rjmp  tilerow_block_144_j1
	rjmp  tilerow_block_151_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_160_j1
	rjmp  tilerow_block_165_j1
	rjmp  tilerow_block_173_j1
	rjmp  tilerow_block_181_j1
	rjmp  tilerow_block_80_j1
	rjmp  tilerow_block_195_j1
	rjmp  tilerow_block_60_j1
	rjmp  tilerow_block_207_j1
	rjmp  tilerow_block_198_j1
	rjmp  tilerow_block_219_j1
	rjmp  tilerow_block_227_j1
	rjmp  tilerow_block_235_j1
	rjmp  tilerow_block_227_j1
	rjmp  tilerow_block_248_j1
	rjmp  tilerow_block_256_j1
	rjmp  tilerow_block_263_j1
	rjmp  tilerow_block_269_j1
	rjmp  tilerow_block_277_j1
	rjmp  tilerow_block_80_j1
	rjmp  tilerow_block_60_j1
	rjmp  tilerow_block_80_j1
	rjmp  tilerow_block_60_j1
	rjmp  tilerow_block_297_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_319_j1
	rjmp  tilerow_block_324_j1
	rjmp  tilerow_block_330_j1
	rjmp  tilerow_block_338_j1
	rjmp  tilerow_block_326_j1
	rjmp  tilerow_block_333_j1
	rjmp  tilerow_block_354_j1
	rjmp  tilerow_block_365_j1
	rjmp  tilerow_block_372_j1
	rjmp  tilerow_block_380_j1
	rjmp  tilerow_block_388_j1
	rjmp  tilerow_block_392_j1
	rjmp  tilerow_block_396_j1
	rjmp  tilerow_block_402_j1
	rjmp  tilerow_block_402_j1
	rjmp  tilerow_block_394_j1
	rjmp  tilerow_block_421_j1
	rjmp  tilerow_block_428_j1
	rjmp  tilerow_block_434_j1
	rjmp  tilerow_block_440_j1
	rjmp  tilerow_block_446_j1
	rjmp  tilerow_block_453_j1
	rjmp  tilerow_block_460_j1
	rjmp  tilerow_block_463_j1
	rjmp  tilerow_block_456_j1
	rjmp  tilerow_block_453_j1
	rjmp  tilerow_block_474_j1
	rjmp  tilerow_block_481_j1
	rjmp  tilerow_block_486_j1
	rjmp  tilerow_block_491_j1
	rjmp  tilerow_block_491_j1
	rjmp  tilerow_block_494_j1
	rjmp  tilerow_block_502_j1
	rjmp  tilerow_block_505_j1
	rjmp  tilerow_block_509_j1
	rjmp  tilerow_block_514_j1
	rjmp  tilerow_block_511_j1
	rjmp  tilerow_block_519_j1
	rjmp  tilerow_block_511_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_527_j1
	rjmp  tilerow_block_533_j1
	rjmp  tilerow_block_538_j1
	rjmp  tilerow_block_545_j1
	rjmp  tilerow_block_486_j1
	rjmp  tilerow_block_486_j1
	rjmp  tilerow_block_486_j1
	rjmp  tilerow_block_486_j1
	rjmp  tilerow_block_560_j1
	rjmp  tilerow_block_566_j1
	rjmp  tilerow_block_571_j1
	rjmp  tilerow_block_576_j1
	rjmp  tilerow_block_491_j1
	rjmp  tilerow_block_491_j1
	rjmp  tilerow_block_491_j1
	rjmp  tilerow_block_491_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1


.balign 512
tilerow_7_map:
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_5_j1
	rjmp  tilerow_block_13_j1
	rjmp  tilerow_block_20_j1
	rjmp  tilerow_block_28_j1
	rjmp  tilerow_block_35_j1
	rjmp  tilerow_block_40_j1
	rjmp  tilerow_block_45_j1
	rjmp  tilerow_block_48_j1
	rjmp  tilerow_block_55_j1
	rjmp  tilerow_block_61_j1
	rjmp  tilerow_block_68_j1
	rjmp  tilerow_block_61_j1
	rjmp  tilerow_block_55_j1
	rjmp  tilerow_block_88_j1
	rjmp  tilerow_block_96_j1
	rjmp  tilerow_block_104_j1
	rjmp  tilerow_block_107_j1
	rjmp  tilerow_block_115_j1
	rjmp  tilerow_block_122_j1
	rjmp  tilerow_block_108_j1
	rjmp  tilerow_block_137_j1
	rjmp  tilerow_block_145_j1
	rjmp  tilerow_block_152_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_161_j1
	rjmp  tilerow_block_166_j1
	rjmp  tilerow_block_174_j1
	rjmp  tilerow_block_61_j1
	rjmp  tilerow_block_188_j1
	rjmp  tilerow_block_196_j1
	rjmp  tilerow_block_202_j1
	rjmp  tilerow_block_208_j1
	rjmp  tilerow_block_197_j1
	rjmp  tilerow_block_220_j1
	rjmp  tilerow_block_228_j1
	rjmp  tilerow_block_220_j1
	rjmp  tilerow_block_228_j1
	rjmp  tilerow_block_249_j1
	rjmp  tilerow_block_236_j1
	rjmp  tilerow_block_264_j1
	rjmp  tilerow_block_270_j1
	rjmp  tilerow_block_61_j1
	rjmp  tilerow_block_55_j1
	rjmp  tilerow_block_61_j1
	rjmp  tilerow_block_55_j1
	rjmp  tilerow_block_61_j1
	rjmp  tilerow_block_298_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_320_j1
	rjmp  tilerow_block_314_j1
	rjmp  tilerow_block_331_j1
	rjmp  tilerow_block_339_j1
	rjmp  tilerow_block_325_j1
	rjmp  tilerow_block_352_j1
	rjmp  tilerow_block_358_j1
	rjmp  tilerow_block_366_j1
	rjmp  tilerow_block_373_j1
	rjmp  tilerow_block_381_j1
	rjmp  tilerow_block_389_j1
	rjmp  tilerow_block_393_j1
	rjmp  tilerow_block_393_j1
	rjmp  tilerow_block_403_j1
	rjmp  tilerow_block_410_j1
	rjmp  tilerow_block_385_j1
	rjmp  tilerow_block_422_j1
	rjmp  tilerow_block_429_j1
	rjmp  tilerow_block_435_j1
	rjmp  tilerow_block_441_j1
	rjmp  tilerow_block_422_j1
	rjmp  tilerow_block_454_j1
	rjmp  tilerow_block_456_j1
	rjmp  tilerow_block_456_j1
	rjmp  tilerow_block_455_j1
	rjmp  tilerow_block_454_j1
	rjmp  tilerow_block_55_j1
	rjmp  tilerow_block_55_j1
	rjmp  tilerow_block_435_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_503_j1
	rjmp  tilerow_block_506_j1
	rjmp  tilerow_block_506_j1
	rjmp  tilerow_block_513_j1
	rjmp  tilerow_block_516_j1
	rjmp  tilerow_block_516_j1
	rjmp  tilerow_block_516_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_528_j1
	rjmp  tilerow_block_534_j1
	rjmp  tilerow_block_539_j1
	rjmp  tilerow_block_534_j1
	rjmp  tilerow_block_435_j1
	rjmp  tilerow_block_435_j1
	rjmp  tilerow_block_435_j1
	rjmp  tilerow_block_435_j1
	rjmp  tilerow_block_561_j1
	rjmp  tilerow_block_567_j1
	rjmp  tilerow_block_572_j1
	rjmp  tilerow_block_577_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_492_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1
	rjmp  tilerow_block_0_j1


.balign 512

tilerow_block_357:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r5
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r6
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r6
	rjmp  tilerow_common_3
tilerow_block_358:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r5
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_3
tilerow_block_363:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r17
	st    X+,      r17
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r17
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r17
	st    X+,      r17
	rjmp  tilerow_common_3
tilerow_block_364:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r16
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r15
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r17
	st    X+,      r16
	rjmp  tilerow_common_3
tilerow_block_365:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r15
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r15
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r17
	st    X+,      r15
	rjmp  tilerow_common_3
tilerow_block_366:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r15
	st    X+,      r13
	rjmp  tilerow_common_3
tilerow_block_370:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r15
	st    X+,      r16
	out   PIXOUT,  r22
	st    X+,      r17
	st    X+,      r17
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r17
	st    X+,      r17
	rjmp  tilerow_common_3
tilerow_block_371:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r13
	st    X+,      r17
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r15
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r17
	st    X+,      r16
	rjmp  tilerow_common_3
tilerow_block_372:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r13
	st    X+,      r17
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r15
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r17
	st    X+,      r15
	rjmp  tilerow_common_3
tilerow_block_373:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r13
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r15
	st    X+,      r13
	rjmp  tilerow_common_3
tilerow_block_378:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r15
	st    X+,      r16
	out   PIXOUT,  r22
	st    X+,      r17
	st    X+,      r17
	st    X+,      r17
	out   PIXOUT,  r23
	st    X+,      r17
	st    X+,      r13
	rjmp  tilerow_common_3
tilerow_block_379:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r13
	st    X+,      r17
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r15
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r15
	st    X+,      r13
	rjmp  tilerow_common_3
tilerow_block_380:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r13
	st    X+,      r17
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r15
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r15
	st    X+,      r13
	rjmp  tilerow_common_3
tilerow_block_381:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r13
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r13
	rjmp  tilerow_common_3
tilerow_block_386:
	out   PIXOUT,  r1
	st    X+,      r16
	st    X+,      r17
	st    X+,      r17
	out   PIXOUT,  r22
	st    X+,      r17
	st    X+,      r16
	st    X+,      r17
	out   PIXOUT,  r23
	st    X+,      r17
	st    X+,      r17
	rjmp  tilerow_common_3
tilerow_block_387:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r16
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r17
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r16
	st    X+,      r15
	rjmp  tilerow_common_3
tilerow_block_388:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r15
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r17
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r15
	st    X+,      r15
	rjmp  tilerow_common_3
tilerow_block_389:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r15
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r13
	rjmp  tilerow_common_3
tilerow_block_390:
	out   PIXOUT,  r1
	st    X+,      r16
	st    X+,      r17
	st    X+,      r17
	out   PIXOUT,  r22
	st    X+,      r17
	st    X+,      r16
	st    X+,      r17
	out   PIXOUT,  r23
	st    X+,      r17
	st    X+,      r14
	rjmp  tilerow_common_3
tilerow_block_391:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r15
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r17
	st    X+,      r16
	out   PIXOUT,  r23
	st    X+,      r15
	st    X+,      r13
	rjmp  tilerow_common_3
tilerow_block_392:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r15
	st    X+,      r14
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r17
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r15
	st    X+,      r13
	rjmp  tilerow_common_3
tilerow_block_393:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r15
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r13
	rjmp  tilerow_common_3
tilerow_block_395:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r15
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r17
	st    X+,      r16
	out   PIXOUT,  r23
	st    X+,      r15
	st    X+,      r15
	rjmp  tilerow_common_3
tilerow_block_396:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r15
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r17
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r15
	st    X+,      r15
	rjmp  tilerow_common_3
tilerow_block_400:
	out   PIXOUT,  r1
	st    X+,      r16
	st    X+,      r14
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r14
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r12
	rjmp  tilerow_common_3
tilerow_block_401:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r16
	st    X+,      r17
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r14
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r12
	rjmp  tilerow_common_3
tilerow_block_402:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r15
	st    X+,      r17
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r15
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r13
	rjmp  tilerow_common_3
tilerow_block_403:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r16
	st    X+,      r17
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r15
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r12
	rjmp  tilerow_common_3
tilerow_block_408:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r17
	st    X+,      r17
	out   PIXOUT,  r22
	st    X+,      r17
	st    X+,      r16
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r15
	st    X+,      r13
	rjmp  tilerow_common_3
tilerow_block_409:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r16
	st    X+,      r17
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r15
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r13
	rjmp  tilerow_common_3
tilerow_block_410:
	out   PIXOUT,  r1
	st    X+,      r17
	st    X+,      r16
	st    X+,      r17
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r14
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r12
	rjmp  tilerow_common_3
tilerow_block_419:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r15
	st    X+,      r14
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r15
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r15
	st    X+,      r14
	rjmp  tilerow_common_3
tilerow_block_420:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r14
	st    X+,      r14
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r15
	st    X+,      r14
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r14
	rjmp  tilerow_common_3
tilerow_block_421:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r14
	st    X+,      r14
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r14
	st    X+,      r14
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r14
	rjmp  tilerow_common_3
tilerow_block_422:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r13
	rjmp  tilerow_common_3
tilerow_block_426:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r15
	st    X+,      r14
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r15
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r13
	rjmp  tilerow_common_3
tilerow_block_427:
	out   PIXOUT,  r1
	st    X+,      r14
	st    X+,      r14
	st    X+,      r14
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r14
	st    X+,      r14
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r13
	rjmp  tilerow_common_3
tilerow_block_428:
	out   PIXOUT,  r1
	st    X+,      r14
	st    X+,      r14
	st    X+,      r14
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r14
	st    X+,      r14
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r12
	rjmp  tilerow_common_3
tilerow_block_432:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r15
	st    X+,      r14
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r15
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r15
	rjmp  tilerow_common_3
tilerow_block_433:
	out   PIXOUT,  r1
	st    X+,      r14
	st    X+,      r14
	st    X+,      r14
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r15
	st    X+,      r14
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r14
	rjmp  tilerow_common_3
tilerow_block_434:
	out   PIXOUT,  r1
	st    X+,      r14
	st    X+,      r14
	st    X+,      r14
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r14
	st    X+,      r14
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r14
	rjmp  tilerow_common_3
tilerow_block_435:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r13
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r12
	rjmp  tilerow_common_3
tilerow_block_439:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r13
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r15
	st    X+,      r15
	rjmp  tilerow_common_3
tilerow_block_440:
	out   PIXOUT,  r1
	st    X+,      r14
	st    X+,      r12
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r15
	st    X+,      r14
	rjmp  tilerow_common_3
tilerow_block_441:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r13
	st    X+,      r2
	out   PIXOUT,  r22
	st    X+,      r2
	st    X+,      r2
	st    X+,      r2
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r12
	rjmp  tilerow_common_3
tilerow_block_446:
	out   PIXOUT,  r1
	st    X+,      r14
	st    X+,      r14
	st    X+,      r14
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r14
	st    X+,      r14
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r14
	rjmp  tilerow_common_3
tilerow_block_451:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r13
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r6
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r12
	rjmp  tilerow_common_3
tilerow_block_452:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r13
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r5
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r5
	rjmp  tilerow_common_3
tilerow_block_453:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r5
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r12
	rjmp  tilerow_common_3
tilerow_block_454:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r6
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r13
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r6
	rjmp  tilerow_common_3
tilerow_block_458:
	out   PIXOUT,  r1
	st    X+,      r16
	st    X+,      r13
	st    X+,      r16
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r15
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r16
	st    X+,      r13
	rjmp  tilerow_common_3
tilerow_block_460:
	out   PIXOUT,  r1
	st    X+,      r16
	st    X+,      r13
	st    X+,      r16
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r15
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r15
	st    X+,      r13
	rjmp  tilerow_common_3
tilerow_block_462:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r13
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r16
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r16
	st    X+,      r13
	rjmp  tilerow_common_3
tilerow_block_465:
	out   PIXOUT,  r1
	st    X+,      r16
	st    X+,      r13
	st    X+,      r16
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r16
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r15
	st    X+,      r13
	rjmp  tilerow_common_3
tilerow_block_473:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r12
	rjmp  tilerow_common_3
tilerow_block_474:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r13
	rjmp  tilerow_common_3
tilerow_block_479:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r13
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r5
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r6
	rjmp  tilerow_common_3
tilerow_block_480:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r12
	st    X+,      r13
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r12
	rjmp  tilerow_common_3
tilerow_block_481:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r12
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r13
	rjmp  tilerow_common_3
tilerow_block_484:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r15
	st    X+,      r14
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r13
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r15
	rjmp  tilerow_common_3
tilerow_block_485:
	out   PIXOUT,  r1
	st    X+,      r14
	st    X+,      r14
	st    X+,      r14
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r13
	st    X+,      r14
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r14
	rjmp  tilerow_common_3
tilerow_block_486:
	out   PIXOUT,  r1
	st    X+,      r14
	st    X+,      r14
	st    X+,      r14
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r13
	st    X+,      r14
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r14
	rjmp  tilerow_common_3
tilerow_block_490:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_3
tilerow_block_495:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r6
	rjmp  tilerow_common_3

.balign 512

tilerow_block_357_j1:
	rjmp  tilerow_block_357
tilerow_block_358_j1:
	rjmp  tilerow_block_358
tilerow_block_363_j1:
	rjmp  tilerow_block_363
tilerow_block_364_j1:
	rjmp  tilerow_block_364
tilerow_block_365_j1:
	rjmp  tilerow_block_365
tilerow_block_366_j1:
	rjmp  tilerow_block_366
tilerow_block_370_j1:
	rjmp  tilerow_block_370
tilerow_block_371_j1:
	rjmp  tilerow_block_371
tilerow_block_372_j1:
	rjmp  tilerow_block_372
tilerow_block_373_j1:
	rjmp  tilerow_block_373
tilerow_block_378_j1:
	rjmp  tilerow_block_378
tilerow_block_379_j1:
	rjmp  tilerow_block_379
tilerow_block_380_j1:
	rjmp  tilerow_block_380
tilerow_block_381_j1:
	rjmp  tilerow_block_381
tilerow_block_386_j1:
	rjmp  tilerow_block_386
tilerow_block_387_j1:
	rjmp  tilerow_block_387
tilerow_block_388_j1:
	rjmp  tilerow_block_388
tilerow_block_389_j1:
	rjmp  tilerow_block_389
tilerow_block_390_j1:
	rjmp  tilerow_block_390
tilerow_block_391_j1:
	rjmp  tilerow_block_391
tilerow_block_392_j1:
	rjmp  tilerow_block_392
tilerow_block_393_j1:
	rjmp  tilerow_block_393
tilerow_block_395_j1:
	rjmp  tilerow_block_395
tilerow_block_396_j1:
	rjmp  tilerow_block_396
tilerow_block_400_j1:
	rjmp  tilerow_block_400
tilerow_block_401_j1:
	rjmp  tilerow_block_401
tilerow_block_402_j1:
	rjmp  tilerow_block_402
tilerow_block_403_j1:
	rjmp  tilerow_block_403
tilerow_block_408_j1:
	rjmp  tilerow_block_408
tilerow_block_409_j1:
	rjmp  tilerow_block_409
tilerow_block_410_j1:
	rjmp  tilerow_block_410
tilerow_block_419_j1:
	rjmp  tilerow_block_419
tilerow_block_420_j1:
	rjmp  tilerow_block_420
tilerow_block_421_j1:
	rjmp  tilerow_block_421
tilerow_block_422_j1:
	rjmp  tilerow_block_422
tilerow_block_426_j1:
	rjmp  tilerow_block_426
tilerow_block_427_j1:
	rjmp  tilerow_block_427
tilerow_block_428_j1:
	rjmp  tilerow_block_428
tilerow_block_432_j1:
	rjmp  tilerow_block_432
tilerow_block_433_j1:
	rjmp  tilerow_block_433
tilerow_block_434_j1:
	rjmp  tilerow_block_434
tilerow_block_435_j1:
	rjmp  tilerow_block_435
tilerow_block_439_j1:
	rjmp  tilerow_block_439
tilerow_block_440_j1:
	rjmp  tilerow_block_440
tilerow_block_441_j1:
	rjmp  tilerow_block_441
tilerow_block_446_j1:
	rjmp  tilerow_block_446
tilerow_block_451_j1:
	rjmp  tilerow_block_451
tilerow_block_452_j1:
	rjmp  tilerow_block_452
tilerow_block_453_j1:
	rjmp  tilerow_block_453
tilerow_block_454_j1:
	rjmp  tilerow_block_454
tilerow_block_458_j1:
	rjmp  tilerow_block_458
tilerow_block_460_j1:
	rjmp  tilerow_block_460
tilerow_block_462_j1:
	rjmp  tilerow_block_462
tilerow_block_465_j1:
	rjmp  tilerow_block_465
tilerow_block_473_j1:
	rjmp  tilerow_block_473
tilerow_block_474_j1:
	rjmp  tilerow_block_474
tilerow_block_479_j1:
	rjmp  tilerow_block_479
tilerow_block_480_j1:
	rjmp  tilerow_block_480
tilerow_block_481_j1:
	rjmp  tilerow_block_481
tilerow_block_484_j1:
	rjmp  tilerow_block_484
tilerow_block_485_j1:
	rjmp  tilerow_block_485
tilerow_block_486_j1:
	rjmp  tilerow_block_486
tilerow_block_490_j1:
	rjmp  tilerow_block_490
tilerow_block_495_j1:
	rjmp  tilerow_block_495
tilerow_block_503_j1:
	rjmp  tilerow_block_503
tilerow_block_505_j1:
	rjmp  tilerow_block_505
tilerow_block_506_j1:
	rjmp  tilerow_block_506
tilerow_block_507_j1:
	rjmp  tilerow_block_507
tilerow_block_508_j1:
	rjmp  tilerow_block_508
tilerow_block_509_j1:
	rjmp  tilerow_block_509
tilerow_block_519_j1:
	rjmp  tilerow_block_519
tilerow_block_522_j1:
	rjmp  tilerow_block_522
tilerow_block_525_j1:
	rjmp  tilerow_block_525
tilerow_block_526_j1:
	rjmp  tilerow_block_526
tilerow_block_527_j1:
	rjmp  tilerow_block_527
tilerow_block_528_j1:
	rjmp  tilerow_block_528
tilerow_block_532_j1:
	rjmp  tilerow_block_532
tilerow_block_533_j1:
	rjmp  tilerow_block_533
tilerow_block_534_j1:
	rjmp  tilerow_block_534
tilerow_block_536_j1:
	rjmp  tilerow_block_536
tilerow_block_537_j1:
	rjmp  tilerow_block_537
tilerow_block_538_j1:
	rjmp  tilerow_block_538
tilerow_block_539_j1:
	rjmp  tilerow_block_539
tilerow_block_543_j1:
	rjmp  tilerow_block_543
tilerow_block_544_j1:
	rjmp  tilerow_block_544
tilerow_block_545_j1:
	rjmp  tilerow_block_545
tilerow_block_558_j1:
	rjmp  tilerow_block_558
tilerow_block_559_j1:
	rjmp  tilerow_block_559
tilerow_block_560_j1:
	rjmp  tilerow_block_560
tilerow_block_561_j1:
	rjmp  tilerow_block_561
tilerow_block_564_j1:
	rjmp  tilerow_block_564
tilerow_block_565_j1:
	rjmp  tilerow_block_565
tilerow_block_566_j1:
	rjmp  tilerow_block_566
tilerow_block_567_j1:
	rjmp  tilerow_block_567
tilerow_block_569_j1:
	rjmp  tilerow_block_569
tilerow_block_570_j1:
	rjmp  tilerow_block_570
tilerow_block_571_j1:
	rjmp  tilerow_block_571
tilerow_block_572_j1:
	rjmp  tilerow_block_572
tilerow_block_574_j1:
	rjmp  tilerow_block_574
tilerow_block_575_j1:
	rjmp  tilerow_block_575
tilerow_block_576_j1:
	rjmp  tilerow_block_576
tilerow_block_577_j1:
	rjmp  tilerow_block_577
tilerow_block_582_j1:
	rjmp  tilerow_block_582

tilerow_common_3:
	out   PIXOUT,  r0
	breq  tilerow_exit_c_3 ; Uses Z flag
	pop   r0
tilerow_entry_3:
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
	ijmp
tilerow_exit_c_3:
	brts  tilerow_exit_3   ; (1582 / 1621)
	mov   r22,     r17
	mov   r23,     r17
	movw  r0,      r22
	out   PIXOUT,  r17
	ld    ZL,      Y+
	set
	ijmp
tilerow_exit_3:
	sbic  GPR0,    1       ; (1622) Color 0 (bg) loading enabled?
	in    r2,      GPR1    ; (1623) If so, load it
	sbic  GPR0,    2       ; (1624) Color 15 (border) loading enabled?
	in    r17,     GPR1    ; (1625) If so, load it
	ldi   ZL,      LB_SPR_B - 1 ; (1626) 254(HI):255(LO): Sprite conf B
	sbic  GPR0,    0       ; (1627)
	ldi   ZL,      LB_SPR_A - 1 ; (1628) 252(HI):253(LO): Sprite conf A
	out   STACKL,  ZL      ; (1629)
	ret                    ; (1633)

tilerow_block_503:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r5
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_3
tilerow_block_505:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r12
	rjmp  tilerow_common_3
tilerow_block_506:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_3
tilerow_block_507:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r6
	rjmp  tilerow_common_3
tilerow_block_508:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r13
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r5
	rjmp  tilerow_common_3
tilerow_block_509:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r6
	rjmp  tilerow_common_3
tilerow_block_519:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r5
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r5
	st    X+,      r5
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_3
tilerow_block_522:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r12
	st    X+,      r12
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_3
tilerow_block_525:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r15
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r15
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r15
	rjmp  tilerow_common_3
tilerow_block_526:
	out   PIXOUT,  r1
	st    X+,      r14
	st    X+,      r14
	st    X+,      r14
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r10
	st    X+,      r14
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r14
	rjmp  tilerow_common_3
tilerow_block_527:
	out   PIXOUT,  r1
	st    X+,      r14
	st    X+,      r14
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r10
	st    X+,      r14
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r14
	rjmp  tilerow_common_3
tilerow_block_528:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r16
	st    X+,      r10
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r12
	rjmp  tilerow_common_3
tilerow_block_532:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r15
	st    X+,      r14
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r10
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r15
	rjmp  tilerow_common_3
tilerow_block_533:
	out   PIXOUT,  r1
	st    X+,      r14
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r15
	st    X+,      r10
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r14
	rjmp  tilerow_common_3
tilerow_block_534:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r14
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r10
	st    X+,      r13
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r12
	rjmp  tilerow_common_3
tilerow_block_536:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r15
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r10
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r15
	rjmp  tilerow_common_3
tilerow_block_537:
	out   PIXOUT,  r1
	st    X+,      r14
	st    X+,      r14
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r16
	st    X+,      r10
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r14
	rjmp  tilerow_common_3
tilerow_block_538:
	out   PIXOUT,  r1
	st    X+,      r14
	st    X+,      r14
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r10
	st    X+,      r14
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r14
	rjmp  tilerow_common_3
tilerow_block_539:
	out   PIXOUT,  r1
	st    X+,      r13
	st    X+,      r10
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r23
	st    X+,      r13
	st    X+,      r12
	rjmp  tilerow_common_3
tilerow_block_543:
	out   PIXOUT,  r1
	st    X+,      r15
	st    X+,      r15
	st    X+,      r14
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r15
	st    X+,      r15
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r15
	rjmp  tilerow_common_3
tilerow_block_544:
	out   PIXOUT,  r1
	st    X+,      r14
	st    X+,      r14
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r14
	st    X+,      r14
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r14
	rjmp  tilerow_common_3
tilerow_block_545:
	out   PIXOUT,  r1
	st    X+,      r14
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r23
	st    X+,      r14
	st    X+,      r14
	rjmp  tilerow_common_3
tilerow_block_558:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r5
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_3
tilerow_block_559:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r6
	rjmp  tilerow_common_3
tilerow_block_560:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r6
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r10
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_3
tilerow_block_561:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_3
tilerow_block_564:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r6
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_3
tilerow_block_565:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r12
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r15
	st    X+,      r10
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r6
	rjmp  tilerow_common_3
tilerow_block_566:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r6
	st    X+,      r10
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_3
tilerow_block_567:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r6
	st    X+,      r16
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r16
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_3
tilerow_block_569:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r10
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_3
tilerow_block_570:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r12
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r6
	st    X+,      r10
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r6
	rjmp  tilerow_common_3
tilerow_block_571:
	out   PIXOUT,  r1
	st    X+,      r12
	st    X+,      r10
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r15
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_3
tilerow_block_572:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r10
	st    X+,      r16
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r10
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_3
tilerow_block_574:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r6
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r6
	st    X+,      r10
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_3
tilerow_block_575:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r10
	st    X+,      r15
	out   PIXOUT,  r22
	st    X+,      r6
	st    X+,      r10
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r12
	st    X+,      r6
	rjmp  tilerow_common_3
tilerow_block_576:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r10
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r10
	st    X+,      r6
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_3
tilerow_block_577:
	out   PIXOUT,  r1
	st    X+,      r5
	st    X+,      r6
	st    X+,      r10
	out   PIXOUT,  r22
	st    X+,      r16
	st    X+,      r10
	st    X+,      r6
	out   PIXOUT,  r23
	st    X+,      r5
	st    X+,      r5
	rjmp  tilerow_common_3
tilerow_block_582:
	out   PIXOUT,  r1
	st    X+,      r6
	st    X+,      r12
	st    X+,      r6
	out   PIXOUT,  r22
	st    X+,      r13
	st    X+,      r6
	st    X+,      r12
	out   PIXOUT,  r23
	st    X+,      r6
	st    X+,      r6
	rjmp  tilerow_common_3
