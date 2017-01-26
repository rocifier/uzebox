
;
; Mode 72 character ROM (2048 bytes, 256 byte aligned)
;

#ifndef M72_ALIGNED_SEC
#define M72_ALIGNED_SEC .text
#endif


.section M72_ALIGNED_SEC


.global charrom

.balign 256

charrom:

	.byte 0x3C, 0x18, 0x7C, 0x3C, 0x78, 0x7E, 0x7E, 0x3C, 0x66, 0x3C, 0x1E, 0x66, 0x60, 0x63, 0x66, 0x3C
	.byte 0x7C, 0x3C, 0x7C, 0x3C, 0x7E, 0x66, 0x66, 0x63, 0x66, 0x66, 0x7E, 0x3C, 0x0C, 0x3C, 0x00, 0x00
	.byte 0x00, 0x18, 0x66, 0x66, 0x18, 0x62, 0x3C, 0x06, 0x0C, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x3C, 0x18, 0x3C, 0x3C, 0x06, 0x7E, 0x3C, 0x7E, 0x3C, 0x3C, 0x00, 0x00, 0x0E, 0x00, 0x70, 0x3C
	.byte 0x00, 0x08, 0x18, 0x00, 0x00, 0x00, 0x00, 0x30, 0x0C, 0x00, 0x18, 0x18, 0xC0, 0xC0, 0x03, 0xFF
	.byte 0xFF, 0x00, 0x00, 0x36, 0x60, 0x00, 0xC3, 0x00, 0x18, 0x06, 0x08, 0x18, 0xC0, 0x18, 0x00, 0xFF
	.byte 0x00, 0xF0, 0x00, 0xFF, 0x00, 0xC0, 0xCC, 0x03, 0x00, 0xFF, 0x03, 0x18, 0x00, 0x18, 0x00, 0x00
	.byte 0x00, 0x18, 0x00, 0x18, 0xC0, 0xE0, 0x07, 0xFF, 0xFF, 0x00, 0x03, 0x00, 0x0F, 0x18, 0xF0, 0xF0
	.byte 0xC3, 0xE7, 0x83, 0xC3, 0x87, 0x81, 0x81, 0xC3, 0x99, 0xC3, 0xE1, 0x99, 0x9F, 0x9C, 0x99, 0xC3
	.byte 0x83, 0xC3, 0x83, 0xC3, 0x81, 0x99, 0x99, 0x9C, 0x99, 0x99, 0x81, 0xC3, 0xF3, 0xC3, 0xFF, 0xFF
	.byte 0xFF, 0xE7, 0x99, 0x99, 0xE7, 0x9D, 0xC3, 0xF9, 0xF3, 0xCF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
	.byte 0xC3, 0xE7, 0xC3, 0xC3, 0xF9, 0x81, 0xC3, 0x81, 0xC3, 0xC3, 0xFF, 0xFF, 0xF1, 0xFF, 0x8F, 0xC3
	.byte 0xFF, 0xF7, 0xE7, 0xFF, 0xFF, 0xFF, 0xFF, 0xCF, 0xF3, 0xFF, 0xE7, 0xE7, 0x3F, 0x3F, 0xFC, 0x00
	.byte 0x00, 0xFF, 0xFF, 0xC9, 0x9F, 0xFF, 0x3C, 0xFF, 0xE7, 0xF9, 0xF7, 0xE7, 0x3F, 0xE7, 0xFF, 0x00
	.byte 0xFF, 0x0F, 0xFF, 0x00, 0xFF, 0x3F, 0x33, 0xFC, 0xFF, 0x00, 0xFC, 0xE7, 0xFF, 0xE7, 0xFF, 0xFF
	.byte 0xFF, 0xE7, 0xFF, 0xE7, 0x3F, 0x1F, 0xF8, 0x00, 0x00, 0xFF, 0xFC, 0xFF, 0xF0, 0xE7, 0x0F, 0x0F
	.byte 0x66, 0x3C, 0x66, 0x66, 0x6C, 0x60, 0x60, 0x66, 0x66, 0x18, 0x0C, 0x6C, 0x60, 0x77, 0x76, 0x66
	.byte 0x66, 0x66, 0x66, 0x66, 0x18, 0x66, 0x66, 0x63, 0x66, 0x66, 0x06, 0x30, 0x12, 0x0C, 0x18, 0x10
	.byte 0x00, 0x18, 0x66, 0x66, 0x3E, 0x66, 0x66, 0x0C, 0x18, 0x18, 0x66, 0x18, 0x00, 0x00, 0x00, 0x03
	.byte 0x66, 0x18, 0x66, 0x66, 0x0E, 0x60, 0x66, 0x66, 0x66, 0x66, 0x00, 0x00, 0x18, 0x00, 0x18, 0x66
	.byte 0x00, 0x1C, 0x18, 0x00, 0x00, 0xFF, 0x00, 0x30, 0x0C, 0x00, 0x18, 0x18, 0xC0, 0xE0, 0x07, 0xFF
	.byte 0xFF, 0x3C, 0x00, 0x7F, 0x60, 0x00, 0xE7, 0x3C, 0x18, 0x06, 0x1C, 0x18, 0xC0, 0x18, 0x00, 0x7F
	.byte 0x00, 0xF0, 0x00, 0x00, 0x00, 0xC0, 0xCC, 0x03, 0x00, 0xFE, 0x03, 0x18, 0x00, 0x18, 0x00, 0x00
	.byte 0x00, 0x18, 0x00, 0x18, 0xC0, 0xE0, 0x07, 0xFF, 0xFF, 0x00, 0x03, 0x00, 0x0F, 0x18, 0xF0, 0xF0
	.byte 0x99, 0xC3, 0x99, 0x99, 0x93, 0x9F, 0x9F, 0x99, 0x99, 0xE7, 0xF3, 0x93, 0x9F, 0x88, 0x89, 0x99
	.byte 0x99, 0x99, 0x99, 0x99, 0xE7, 0x99, 0x99, 0x9C, 0x99, 0x99, 0xF9, 0xCF, 0xED, 0xF3, 0xE7, 0xEF
	.byte 0xFF, 0xE7, 0x99, 0x99, 0xC1, 0x99, 0x99, 0xF3, 0xE7, 0xE7, 0x99, 0xE7, 0xFF, 0xFF, 0xFF, 0xFC
	.byte 0x99, 0xE7, 0x99, 0x99, 0xF1, 0x9F, 0x99, 0x99, 0x99, 0x99, 0xFF, 0xFF, 0xE7, 0xFF, 0xE7, 0x99
	.byte 0xFF, 0xE3, 0xE7, 0xFF, 0xFF, 0x00, 0xFF, 0xCF, 0xF3, 0xFF, 0xE7, 0xE7, 0x3F, 0x1F, 0xF8, 0x00
	.byte 0x00, 0xC3, 0xFF, 0x80, 0x9F, 0xFF, 0x18, 0xC3, 0xE7, 0xF9, 0xE3, 0xE7, 0x3F, 0xE7, 0xFF, 0x80
	.byte 0xFF, 0x0F, 0xFF, 0xFF, 0xFF, 0x3F, 0x33, 0xFC, 0xFF, 0x01, 0xFC, 0xE7, 0xFF, 0xE7, 0xFF, 0xFF
	.byte 0xFF, 0xE7, 0xFF, 0xE7, 0x3F, 0x1F, 0xF8, 0x00, 0x00, 0xFF, 0xFC, 0xFF, 0xF0, 0xE7, 0x0F, 0x0F
	.byte 0x6E, 0x66, 0x66, 0x60, 0x66, 0x60, 0x60, 0x60, 0x66, 0x18, 0x0C, 0x78, 0x60, 0x7F, 0x7E, 0x66
	.byte 0x66, 0x66, 0x66, 0x60, 0x18, 0x66, 0x66, 0x63, 0x3C, 0x66, 0x0C, 0x30, 0x30, 0x0C, 0x3C, 0x30
	.byte 0x00, 0x18, 0x66, 0xFF, 0x60, 0x0C, 0x3C, 0x18, 0x30, 0x0C, 0x3C, 0x18, 0x00, 0x00, 0x00, 0x06
	.byte 0x6E, 0x38, 0x06, 0x06, 0x1E, 0x7C, 0x60, 0x0C, 0x66, 0x66, 0x18, 0x18, 0x30, 0x7E, 0x0C, 0x06
	.byte 0x00, 0x3E, 0x18, 0x00, 0xFF, 0xFF, 0x00, 0x30, 0x0C, 0x00, 0x1C, 0x38, 0xC0, 0x70, 0x0E, 0xC0
	.byte 0x03, 0x7E, 0x00, 0x7F, 0x60, 0x00, 0x7E, 0x7E, 0x66, 0x06, 0x3E, 0x18, 0x30, 0x18, 0x03, 0x3F
	.byte 0x00, 0xF0, 0x00, 0x00, 0x00, 0xC0, 0x33, 0x03, 0x00, 0xFC, 0x03, 0x18, 0x00, 0x18, 0x00, 0x00
	.byte 0x00, 0x18, 0x00, 0x18, 0xC0, 0xE0, 0x07, 0x00, 0xFF, 0x00, 0x03, 0x00, 0x0F, 0x18, 0xF0, 0xF0
	.byte 0x91, 0x99, 0x99, 0x9F, 0x99, 0x9F, 0x9F, 0x9F, 0x99, 0xE7, 0xF3, 0x87, 0x9F, 0x80, 0x81, 0x99
	.byte 0x99, 0x99, 0x99, 0x9F, 0xE7, 0x99, 0x99, 0x9C, 0xC3, 0x99, 0xF3, 0xCF, 0xCF, 0xF3, 0xC3, 0xCF
	.byte 0xFF, 0xE7, 0x99, 0x00, 0x9F, 0xF3, 0xC3, 0xE7, 0xCF, 0xF3, 0xC3, 0xE7, 0xFF, 0xFF, 0xFF, 0xF9
	.byte 0x91, 0xC7, 0xF9, 0xF9, 0xE1, 0x83, 0x9F, 0xF3, 0x99, 0x99, 0xE7, 0xE7, 0xCF, 0x81, 0xF3, 0xF9
	.byte 0xFF, 0xC1, 0xE7, 0xFF, 0x00, 0x00, 0xFF, 0xCF, 0xF3, 0xFF, 0xE3, 0xC7, 0x3F, 0x8F, 0xF1, 0x3F
	.byte 0xFC, 0x81, 0xFF, 0x80, 0x9F, 0xFF, 0x81, 0x81, 0x99, 0xF9, 0xC1, 0xE7, 0xCF, 0xE7, 0xFC, 0xC0
	.byte 0xFF, 0x0F, 0xFF, 0xFF, 0xFF, 0x3F, 0xCC, 0xFC, 0xFF, 0x03, 0xFC, 0xE7, 0xFF, 0xE7, 0xFF, 0xFF
	.byte 0xFF, 0xE7, 0xFF, 0xE7, 0x3F, 0x1F, 0xF8, 0xFF, 0x00, 0xFF, 0xFC, 0xFF, 0xF0, 0xE7, 0x0F, 0x0F
	.byte 0x6E, 0x7E, 0x7C, 0x60, 0x66, 0x78, 0x78, 0x6E, 0x7E, 0x18, 0x0C, 0x70, 0x60, 0x6B, 0x7E, 0x66
	.byte 0x7C, 0x66, 0x7C, 0x3C, 0x18, 0x66, 0x66, 0x6B, 0x18, 0x3C, 0x18, 0x30, 0x7C, 0x0C, 0x7E, 0x7F
	.byte 0x00, 0x18, 0x00, 0x66, 0x3C, 0x18, 0x38, 0x00, 0x30, 0x0C, 0xFF, 0x7E, 0x00, 0x7E, 0x00, 0x0C
	.byte 0x76, 0x18, 0x0C, 0x1C, 0x66, 0x06, 0x7C, 0x18, 0x3C, 0x3E, 0x00, 0x00, 0x60, 0x00, 0x06, 0x0C
	.byte 0xFF, 0x7F, 0x18, 0xFF, 0xFF, 0x00, 0x00, 0x30, 0x0C, 0xE0, 0x0F, 0xF0, 0xC0, 0x38, 0x1C, 0xC0
	.byte 0x03, 0x7E, 0x00, 0x7F, 0x60, 0x07, 0x3C, 0x66, 0x66, 0x06, 0x7F, 0xFF, 0x30, 0x18, 0x3E, 0x1F
	.byte 0x00, 0xF0, 0x00, 0x00, 0x00, 0xC0, 0x33, 0x03, 0x00, 0xF8, 0x03, 0x1F, 0x00, 0x1F, 0xF8, 0x00
	.byte 0x1F, 0xFF, 0xFF, 0xF8, 0xC0, 0xE0, 0x07, 0x00, 0x00, 0x00, 0x03, 0x00, 0x0F, 0xF8, 0xF0, 0xF0
	.byte 0x91, 0x81, 0x83, 0x9F, 0x99, 0x87, 0x87, 0x91, 0x81, 0xE7, 0xF3, 0x8F, 0x9F, 0x94, 0x81, 0x99
	.byte 0x83, 0x99, 0x83, 0xC3, 0xE7, 0x99, 0x99, 0x94, 0xE7, 0xC3, 0xE7, 0xCF, 0x83, 0xF3, 0x81, 0x80
	.byte 0xFF, 0xE7, 0xFF, 0x99, 0xC3, 0xE7, 0xC7, 0xFF, 0xCF, 0xF3, 0x00, 0x81, 0xFF, 0x81, 0xFF, 0xF3
	.byte 0x89, 0xE7, 0xF3, 0xE3, 0x99, 0xF9, 0x83, 0xE7, 0xC3, 0xC1, 0xFF, 0xFF, 0x9F, 0xFF, 0xF9, 0xF3
	.byte 0x00, 0x80, 0xE7, 0x00, 0x00, 0xFF, 0xFF, 0xCF, 0xF3, 0x1F, 0xF0, 0x0F, 0x3F, 0xC7, 0xE3, 0x3F
	.byte 0xFC, 0x81, 0xFF, 0x80, 0x9F, 0xF8, 0xC3, 0x99, 0x99, 0xF9, 0x80, 0x00, 0xCF, 0xE7, 0xC1, 0xE0
	.byte 0xFF, 0x0F, 0xFF, 0xFF, 0xFF, 0x3F, 0xCC, 0xFC, 0xFF, 0x07, 0xFC, 0xE0, 0xFF, 0xE0, 0x07, 0xFF
	.byte 0xE0, 0x00, 0x00, 0x07, 0x3F, 0x1F, 0xF8, 0xFF, 0xFF, 0xFF, 0xFC, 0xFF, 0xF0, 0x07, 0x0F, 0x0F
	.byte 0x60, 0x66, 0x66, 0x60, 0x66, 0x60, 0x60, 0x66, 0x66, 0x18, 0x0C, 0x78, 0x60, 0x63, 0x6E, 0x66
	.byte 0x60, 0x66, 0x78, 0x06, 0x18, 0x66, 0x66, 0x7F, 0x3C, 0x18, 0x30, 0x30, 0x30, 0x0C, 0x18, 0x7F
	.byte 0x00, 0x00, 0x00, 0xFF, 0x06, 0x30, 0x67, 0x00, 0x30, 0x0C, 0x3C, 0x18, 0x00, 0x00, 0x00, 0x18
	.byte 0x66, 0x18, 0x30, 0x06, 0x7F, 0x06, 0x66, 0x18, 0x66, 0x06, 0x00, 0x00, 0x30, 0x7E, 0x0C, 0x18
	.byte 0xFF, 0x7F, 0x18, 0xFF, 0x00, 0x00, 0xFF, 0x30, 0x0C, 0xF0, 0x07, 0xE0, 0xC0, 0x1C, 0x38, 0xC0
	.byte 0x03, 0x7E, 0x00, 0x3E, 0x60, 0x0F, 0x3C, 0x66, 0x18, 0x06, 0x3E, 0xFF, 0xC0, 0x18, 0x76, 0x0F
	.byte 0x00, 0xF0, 0xFF, 0x00, 0x00, 0xC0, 0xCC, 0x03, 0xCC, 0xF0, 0x03, 0x1F, 0x0F, 0x1F, 0xF8, 0x00
	.byte 0x1F, 0xFF, 0xFF, 0xF8, 0xC0, 0xE0, 0x07, 0x00, 0x00, 0x00, 0x03, 0xF0, 0x00, 0xF8, 0x00, 0x0F
	.byte 0x9F, 0x99, 0x99, 0x9F, 0x99, 0x9F, 0x9F, 0x99, 0x99, 0xE7, 0xF3, 0x87, 0x9F, 0x9C, 0x91, 0x99
	.byte 0x9F, 0x99, 0x87, 0xF9, 0xE7, 0x99, 0x99, 0x80, 0xC3, 0xE7, 0xCF, 0xCF, 0xCF, 0xF3, 0xE7, 0x80
	.byte 0xFF, 0xFF, 0xFF, 0x00, 0xF9, 0xCF, 0x98, 0xFF, 0xCF, 0xF3, 0xC3, 0xE7, 0xFF, 0xFF, 0xFF, 0xE7
	.byte 0x99, 0xE7, 0xCF, 0xF9, 0x80, 0xF9, 0x99, 0xE7, 0x99, 0xF9, 0xFF, 0xFF, 0xCF, 0x81, 0xF3, 0xE7
	.byte 0x00, 0x80, 0xE7, 0x00, 0xFF, 0xFF, 0x00, 0xCF, 0xF3, 0x0F, 0xF8, 0x1F, 0x3F, 0xE3, 0xC7, 0x3F
	.byte 0xFC, 0x81, 0xFF, 0xC1, 0x9F, 0xF0, 0xC3, 0x99, 0xE7, 0xF9, 0xC1, 0x00, 0x3F, 0xE7, 0x89, 0xF0
	.byte 0xFF, 0x0F, 0x00, 0xFF, 0xFF, 0x3F, 0x33, 0xFC, 0x33, 0x0F, 0xFC, 0xE0, 0xF0, 0xE0, 0x07, 0xFF
	.byte 0xE0, 0x00, 0x00, 0x07, 0x3F, 0x1F, 0xF8, 0xFF, 0xFF, 0xFF, 0xFC, 0x0F, 0xFF, 0x07, 0xFF, 0xF0
	.byte 0x62, 0x66, 0x66, 0x66, 0x6C, 0x60, 0x60, 0x66, 0x66, 0x18, 0x6C, 0x6C, 0x60, 0x63, 0x66, 0x66
	.byte 0x60, 0x3C, 0x6C, 0x66, 0x18, 0x66, 0x3C, 0x77, 0x66, 0x18, 0x60, 0x30, 0x62, 0x0C, 0x18, 0x30
	.byte 0x00, 0x00, 0x00, 0x66, 0x7C, 0x66, 0x66, 0x00, 0x18, 0x18, 0x66, 0x18, 0x18, 0x00, 0x18, 0x30
	.byte 0x66, 0x18, 0x60, 0x66, 0x06, 0x66, 0x66, 0x18, 0x66, 0x66, 0x18, 0x18, 0x18, 0x00, 0x18, 0x00
	.byte 0x00, 0x1C, 0x18, 0x00, 0x00, 0x00, 0xFF, 0x30, 0x0C, 0x38, 0x00, 0x00, 0xC0, 0x0E, 0x70, 0xC0
	.byte 0x03, 0x7E, 0xFF, 0x1C, 0x60, 0x1C, 0x7E, 0x7E, 0x18, 0x06, 0x1C, 0x18, 0xC0, 0x18, 0x36, 0x07
	.byte 0x00, 0xF0, 0xFF, 0x00, 0x00, 0xC0, 0xCC, 0x03, 0xCC, 0xE0, 0x03, 0x18, 0x0F, 0x00, 0x18, 0x00
	.byte 0x18, 0x00, 0x18, 0x18, 0xC0, 0xE0, 0x07, 0x00, 0x00, 0xFF, 0x03, 0xF0, 0x00, 0x00, 0x00, 0x0F
	.byte 0x9D, 0x99, 0x99, 0x99, 0x93, 0x9F, 0x9F, 0x99, 0x99, 0xE7, 0x93, 0x93, 0x9F, 0x9C, 0x99, 0x99
	.byte 0x9F, 0xC3, 0x93, 0x99, 0xE7, 0x99, 0xC3, 0x88, 0x99, 0xE7, 0x9F, 0xCF, 0x9D, 0xF3, 0xE7, 0xCF
	.byte 0xFF, 0xFF, 0xFF, 0x99, 0x83, 0x99, 0x99, 0xFF, 0xE7, 0xE7, 0x99, 0xE7, 0xE7, 0xFF, 0xE7, 0xCF
	.byte 0x99, 0xE7, 0x9F, 0x99, 0xF9, 0x99, 0x99, 0xE7, 0x99, 0x99, 0xE7, 0xE7, 0xE7, 0xFF, 0xE7, 0xFF
	.byte 0xFF, 0xE3, 0xE7, 0xFF, 0xFF, 0xFF, 0x00, 0xCF, 0xF3, 0xC7, 0xFF, 0xFF, 0x3F, 0xF1, 0x8F, 0x3F
	.byte 0xFC, 0x81, 0x00, 0xE3, 0x9F, 0xE3, 0x81, 0x81, 0xE7, 0xF9, 0xE3, 0xE7, 0x3F, 0xE7, 0xC9, 0xF8
	.byte 0xFF, 0x0F, 0x00, 0xFF, 0xFF, 0x3F, 0x33, 0xFC, 0x33, 0x1F, 0xFC, 0xE7, 0xF0, 0xFF, 0xE7, 0xFF
	.byte 0xE7, 0xFF, 0xE7, 0xE7, 0x3F, 0x1F, 0xF8, 0xFF, 0xFF, 0x00, 0xFC, 0x0F, 0xFF, 0xFF, 0xFF, 0xF0
	.byte 0x3C, 0x66, 0x7C, 0x3C, 0x78, 0x7E, 0x60, 0x3C, 0x66, 0x3C, 0x38, 0x66, 0x7E, 0x63, 0x66, 0x3C
	.byte 0x60, 0x0E, 0x66, 0x3C, 0x18, 0x3C, 0x18, 0x63, 0x66, 0x18, 0x7E, 0x3C, 0xFC, 0x3C, 0x18, 0x10
	.byte 0x00, 0x18, 0x00, 0x66, 0x18, 0x46, 0x3F, 0x00, 0x0C, 0x30, 0x00, 0x00, 0x18, 0x00, 0x18, 0x60
	.byte 0x3C, 0x7E, 0x7E, 0x3C, 0x06, 0x3C, 0x3C, 0x18, 0x3C, 0x3C, 0x00, 0x18, 0x0E, 0x00, 0x70, 0x18
	.byte 0x00, 0x3E, 0x18, 0x00, 0x00, 0x00, 0x00, 0x30, 0x0C, 0x18, 0x00, 0x00, 0xFF, 0x07, 0xE0, 0xC0
	.byte 0x03, 0x3C, 0xFF, 0x08, 0x60, 0x18, 0xE7, 0x3C, 0x3C, 0x06, 0x08, 0x18, 0x30, 0x18, 0x36, 0x03
	.byte 0x00, 0xF0, 0xFF, 0x00, 0x00, 0xC0, 0x33, 0x03, 0x33, 0xC0, 0x03, 0x18, 0x0F, 0x00, 0x18, 0xFF
	.byte 0x18, 0x00, 0x18, 0x18, 0xC0, 0xE0, 0x07, 0x00, 0x00, 0xFF, 0xFF, 0xF0, 0x00, 0x00, 0x00, 0x0F
	.byte 0xC3, 0x99, 0x83, 0xC3, 0x87, 0x81, 0x9F, 0xC3, 0x99, 0xC3, 0xC7, 0x99, 0x81, 0x9C, 0x99, 0xC3
	.byte 0x9F, 0xF1, 0x99, 0xC3, 0xE7, 0xC3, 0xE7, 0x9C, 0x99, 0xE7, 0x81, 0xC3, 0x03, 0xC3, 0xE7, 0xEF
	.byte 0xFF, 0xE7, 0xFF, 0x99, 0xE7, 0xB9, 0xC0, 0xFF, 0xF3, 0xCF, 0xFF, 0xFF, 0xE7, 0xFF, 0xE7, 0x9F
	.byte 0xC3, 0x81, 0x81, 0xC3, 0xF9, 0xC3, 0xC3, 0xE7, 0xC3, 0xC3, 0xFF, 0xE7, 0xF1, 0xFF, 0x8F, 0xE7
	.byte 0xFF, 0xC1, 0xE7, 0xFF, 0xFF, 0xFF, 0xFF, 0xCF, 0xF3, 0xE7, 0xFF, 0xFF, 0x00, 0xF8, 0x1F, 0x3F
	.byte 0xFC, 0xC3, 0x00, 0xF7, 0x9F, 0xE7, 0x18, 0xC3, 0xC3, 0xF9, 0xF7, 0xE7, 0xCF, 0xE7, 0xC9, 0xFC
	.byte 0xFF, 0x0F, 0x00, 0xFF, 0xFF, 0x3F, 0xCC, 0xFC, 0xCC, 0x3F, 0xFC, 0xE7, 0xF0, 0xFF, 0xE7, 0x00
	.byte 0xE7, 0xFF, 0xE7, 0xE7, 0x3F, 0x1F, 0xF8, 0xFF, 0xFF, 0x00, 0x00, 0x0F, 0xFF, 0xFF, 0xFF, 0xF0
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x18, 0x00, 0x00, 0x00, 0x00, 0x30, 0x0C, 0x18, 0x00, 0x00, 0xFF, 0x03, 0xC0, 0xC0
	.byte 0x03, 0x00, 0x00, 0x00, 0x60, 0x18, 0xC3, 0x00, 0x00, 0x06, 0x00, 0x18, 0x30, 0x18, 0x00, 0x01
	.byte 0x00, 0xF0, 0xFF, 0x00, 0xFF, 0xC0, 0x33, 0x03, 0x33, 0x80, 0x03, 0x18, 0x0F, 0x00, 0x18, 0xFF
	.byte 0x18, 0x00, 0x18, 0x18, 0xC0, 0xE0, 0x07, 0x00, 0x00, 0xFF, 0xFF, 0xF0, 0x00, 0x00, 0x00, 0x0F
	.byte 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
	.byte 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xE7, 0xFF
	.byte 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xCF, 0xFF, 0xFF, 0xFF
	.byte 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xCF, 0xFF, 0xFF, 0xFF, 0xFF
	.byte 0xFF, 0xFF, 0xE7, 0xFF, 0xFF, 0xFF, 0xFF, 0xCF, 0xF3, 0xE7, 0xFF, 0xFF, 0x00, 0xFC, 0x3F, 0x3F
	.byte 0xFC, 0xFF, 0xFF, 0xFF, 0x9F, 0xE7, 0x3C, 0xFF, 0xFF, 0xF9, 0xFF, 0xE7, 0xCF, 0xE7, 0xFF, 0xFE
	.byte 0xFF, 0x0F, 0x00, 0xFF, 0x00, 0x3F, 0xCC, 0xFC, 0xCC, 0x7F, 0xFC, 0xE7, 0xF0, 0xFF, 0xE7, 0x00
	.byte 0xE7, 0xFF, 0xE7, 0xE7, 0x3F, 0x1F, 0xF8, 0xFF, 0xFF, 0x00, 0x00, 0x0F, 0xFF, 0xFF, 0xFF, 0xF0

