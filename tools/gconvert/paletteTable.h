#ifndef PALETTE_TABLE_H_
#define PALETTE_TABLE_H_

// Which palette index is stored at each entry in the LUT?
const unsigned char PaletteEncodingTable[] =
{
	0x0, 0x0, 0x1, 0x1, 0x2, 0x2, 0x3, 0x3, 0x4, 0x4, 0x5, 0x5, 0x6, 0x6, 0x7,
	0x7, 0x8, 0x8, 0x9, 0x9, 0xA, 0xA, 0xB, 0xB, 0xC, 0xC, 0xD, 0xD, 0xE, 0xE,
	0x1, 0x3, 0x5, 0x7, 0x9, 0xB, 0xD, 0x2, 0x4, 0x6, 0x8, 0xA, 0xC, 0xE, 0x2,
	0x5, 0x8, 0xB, 0xE, 0x3, 0x6, 0x9, 0xC, 0x1, 0x4, 0x7, 0xA, 0xD, 0x1, 0x5,
	0x9, 0xD, 0x3, 0x7, 0xB, 0x2, 0x6, 0xA, 0xE, 0x4, 0x8, 0xC, 0x2, 0x7, 0xC,
	0x3, 0x8, 0xD, 0x4, 0x9, 0xE, 0x5, 0xA, 0x1, 0x6, 0xB, 0x1, 0x7, 0xD, 0x5,
	0xB, 0x3, 0x9, 0x2, 0x8, 0xE, 0x6, 0xC, 0x4, 0xA, 0x2, 0x9, 0x1, 0x8, 0x3,
	0xA, 0x4, 0xB, 0x5, 0xC, 0x6, 0xD, 0x7, 0xE, 0x7, 0x1, 0x9, 0x3, 0xB, 0x4,
	0xC, 0x5, 0xD, 0x6, 0xE, 0x8, 0x2, 0xA, 0x3, 0xC, 0x7, 0x2, 0xB, 0x6, 0x1,
	0xA, 0x5, 0xE, 0x9, 0x4, 0xD, 0x8, 0x1, 0xB, 0x7, 0x3, 0xD, 0x9, 0x5, 0x2,
	0xC, 0x8, 0x4, 0xE, 0xA, 0x6, 0x2, 0xD, 0xA, 0x7, 0x4, 0x1, 0xC, 0x9, 0x6,
	0x3, 0xE, 0xB, 0x8, 0x5, 0x1, 0xD, 0xB, 0x9, 0x7, 0x5, 0x3, 0x2, 0xE, 0xC,
	0xA, 0x8, 0x6, 0x4, 0x2, 0x1, 0xE, 0xD, 0xC, 0xB, 0xA, 0x9, 0x8, 0x7, 0x6,
	0x5, 0x4, 0x3, 0x1, 0x0, 0x2, 0x0, 0x3, 0x0, 0x4, 0x0, 0x5, 0x0, 0x6, 0x0,
	0x7, 0x0, 0x8, 0x0, 0x9, 0x0, 0xA, 0x0, 0xB, 0x0, 0xC, 0x0, 0xD, 0x0, 0xE, 0x0
};

// Convert from standard 16 colour 4bpp to 15 colour palette encoded:
const unsigned char PaletteConversionTable[] =
{
	0x00,0xC6,0xC8,0xCA,0xCC,0xCE,0xD0,0xD2,0xD4,0xD6,0xD8,0xDA,0xDC,0xDE,0xE0,0x00,
	0x01,0x02,0xB8,0xC5,0xA0,0xA9,0x85,0x72,0x8D,0x65,0x52,0x55,0x34,0x39,0x1D,0x00,
	0xC7,0x03,0x04,0xB0,0xB7,0x94,0x9B,0x82,0x7D,0x5C,0x63,0x40,0x47,0x24,0x2B,0x00,
	0xC9,0x1E,0x05,0x06,0xC4,0xAF,0xA4,0x90,0x67,0x74,0x7F,0x5A,0x4A,0x3D,0x30,0x00,
	0xCB,0x35,0x25,0x07,0x08,0xC3,0xB6,0x9F,0x97,0x8A,0x69,0x76,0x61,0x4D,0x44,0x00,
	0xCD,0x3A,0x2C,0x1F,0x09,0x0A,0xC2,0xAE,0xA8,0x93,0x87,0x6B,0x78,0x58,0x50,0x00,
	0xCF,0x53,0x41,0x31,0x26,0x0B,0x0C,0xC1,0xB5,0xA3,0x9A,0x84,0x6D,0x7A,0x5F,0x00,
	0xD1,0x56,0x48,0x3E,0x36,0x20,0x0D,0x0E,0xC0,0xAD,0x9E,0x8F,0x81,0x6F,0x71,0x00,
	0xD3,0x66,0x5D,0x4B,0x45,0x2D,0x27,0x0F,0x10,0xBF,0xB4,0xA7,0x96,0x8C,0x7C,0x00,
	0xD5,0x73,0x64,0x5B,0x4E,0x3B,0x32,0x21,0x11,0x12,0xBE,0xAC,0xA2,0x92,0x89,0x00,
	0xD7,0x86,0x7E,0x68,0x62,0x51,0x42,0x37,0x28,0x13,0x14,0xBD,0xB3,0x9D,0x99,0x00,
	0xD9,0x8E,0x83,0x75,0x6A,0x59,0x54,0x3F,0x2E,0x22,0x15,0x16,0xBC,0xAB,0xA6,0x00,
	0xDB,0xA1,0x95,0x80,0x77,0x6C,0x60,0x49,0x46,0x33,0x29,0x17,0x18,0xBB,0xB2,0x00,
	0xDD,0xAA,0x9C,0x91,0x8B,0x79,0x6E,0x57,0x4C,0x3C,0x38,0x23,0x19,0x1A,0xBA,0x00,
	0xDF,0xB9,0xB1,0xA5,0x98,0x88,0x7B,0x70,0x5E,0x4F,0x43,0x2F,0x2A,0x1B,0x1C,0x00,
	0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
};

#endif