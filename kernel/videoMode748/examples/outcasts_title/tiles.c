/*
 *  Mode 74 Multicolor tests
 *  Copyright (C) 2015 Sandor Zsuga (Jubatian)
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
*/


#include <avr/io.h>
#include <avr/pgmspace.h>
#include "m74cfg.h"



/* +0x0000: Tile row descriptor table */

const unsigned char res_tdesc[128] __attribute__ ((section (".tiles"))) = {
 0x00U,             /* Row mode 0, 24 tiles wide */
 0x00U,             /* Tiles 0x00 - 0x3F */
 0x00U + 0xF8U,     /* Tiles 0x40 - 0x7F */
 0x00U + 0x10U,     /* Tiles 0x80 - 0xBF */
 0x07U + 0x08U,     /* Tiles 0xC0 - 0xFF */

 0x0BU,             /* Row mode 3, 22 tiles wide */
 RES_FONT_OFF >> 8, /* 1bpp tiles */
 0x0AU,             /* Fg. and Bg. colors */
 (0x0F00U - (9U * 39U) - 2304U) & 0xFFU,
 (0x0F00U - (9U * 39U) - 2304U) >> 8
};


/* +0x0080: Tile row descriptors (screen) */

const unsigned char res_screen_00[32] __attribute__ ((section (".tiles"))) = {
 0x05U, 0x05U, 0x05U, 0x05U, 0x05U, 0x05U, 0x05U, 0x05U,
 0x05U, 0x05U, 0x05U, 0x05U, 0x05U, 0x05U, 0x05U, 0x05U,
 0x05U, 0x05U, 0x05U, 0x05U, 0x05U, 0x05U, 0x05U, 0x05U,
 0x05U, 0x05U, 0x05U, 0x05U, 0x05U, 0x05U, 0x05U, 0x05U
};


/* +0x00A0: Unused */

const unsigned char res_dummy_00[64] __attribute__ ((section (".tiles"))) = {};


/* +0x00E0: 4bpp image palette */

const unsigned char res_pal_00[16] __attribute__ ((section (".tiles"))) = {
 0x0AU, 0x11U, 0x52U, 0x13U, 0x1AU, 0x9BU, 0x5CU, 0x63U,
 0xA4U, 0xADU, 0xB6U, 0x7FU, 0xFFU, 0xFFU, 0xFFU, 0xFFU
};


/* +0x00F0: Unused */

const unsigned char res_dummy_01[16] __attribute__ ((section (".tiles"))) = {};



/* +0x0100: 1bpp image data (2048 bytes); row increment: 256 bytes (64) */

const unsigned char res_font[] __attribute__ ((section (".tiles"))) = {
 0x28, 0x10, 0x50, 0x50, 0x50, 0x28, 0x10, 0x10, 0x00, 0x00, 0x7C, 0xF8, 0x14, 0xA0, 0x00, 0xFC,
 0x80, 0x08, 0x50, 0x50, 0x50, 0x28, 0x10, 0x10, 0x20, 0x20, 0x00, 0x00, 0x10, 0x10, 0x10, 0x10,
 0x00, 0x20, 0x50, 0x50, 0x70, 0x90, 0x20, 0x20, 0x18, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10,
 0x70, 0x10, 0x70, 0x70, 0x30, 0xF8, 0x70, 0xF8, 0x70, 0x70, 0x00, 0x00, 0x18, 0x00, 0xC0, 0x70,
 0x70, 0x20, 0xF0, 0x70, 0xF0, 0xF8, 0xF8, 0x70, 0x88, 0x70, 0xF8, 0x98, 0x80, 0x88, 0x88, 0x70,
 0xF0, 0x70, 0xF0, 0x70, 0xF8, 0x88, 0x88, 0x88, 0x88, 0x88, 0xF8, 0x38, 0x80, 0xE0, 0x20, 0x00,
 0x20, 0x00, 0x80, 0x00, 0x08, 0x00, 0x30, 0x00, 0x80, 0x20, 0x10, 0x80, 0x60, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x20, 0xC0, 0x40, 0x00,
 0x00, 0x00, 0x00, 0x1F, 0xF8, 0x05, 0xA0, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x1F, 0xF8, 0x05, 0xA0, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x70, 0x20, 0x88, 0x00, 0xD8, 0x50, 0xA8, 0x20, 0x7C, 0xF8, 0x44, 0x88, 0x14, 0xA0, 0x00, 0x48,
 0xC0, 0x18, 0x70, 0x00, 0x70, 0x50, 0x70, 0x20, 0x70, 0x20, 0x20, 0x20, 0xF8, 0x20, 0x70, 0x20,
 0x00, 0x20, 0x50, 0x50, 0xA8, 0xB0, 0x50, 0x60, 0x30, 0x60, 0xA8, 0x20, 0x00, 0x00, 0x00, 0x30,
 0xD8, 0x30, 0x98, 0x98, 0x60, 0x88, 0xC8, 0x98, 0x88, 0x98, 0x00, 0x00, 0x30, 0x00, 0x60, 0x98,
 0x88, 0x70, 0x88, 0xC8, 0x98, 0x88, 0x88, 0xC8, 0x88, 0x20, 0x88, 0xB0, 0x80, 0xD8, 0xC8, 0xD8,
 0x88, 0xD8, 0x88, 0x88, 0xA8, 0x88, 0x88, 0x88, 0xD8, 0xD8, 0x98, 0x20, 0xC0, 0x20, 0x70, 0x00,
 0x30, 0x00, 0x80, 0x00, 0x08, 0x00, 0x48, 0x00, 0x80, 0x00, 0x00, 0x80, 0x20, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x20, 0x20, 0xE8, 0x00,
 0x00, 0x1F, 0xF8, 0x11, 0x88, 0x05, 0xA0, 0x00, 0x24, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x1F, 0xF8, 0x11, 0x88, 0x05, 0xA0, 0x00, 0x24, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0xD8, 0x70, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88, 0x44, 0x88, 0x44, 0x88, 0x1C, 0xE0, 0x00, 0x48,
 0xE0, 0x38, 0xD8, 0x70, 0xD8, 0x70, 0xD8, 0x70, 0xF8, 0x20, 0x30, 0x60, 0x80, 0x70, 0x20, 0x70,
 0x00, 0x20, 0x50, 0xF8, 0xA0, 0x20, 0x50, 0x40, 0x20, 0x20, 0xF8, 0x20, 0x00, 0x00, 0x00, 0x20,
 0x88, 0x70, 0x18, 0x08, 0xC0, 0x80, 0x80, 0x30, 0x88, 0x88, 0x20, 0x20, 0x60, 0xF8, 0x30, 0x18,
 0xB8, 0xD8, 0x88, 0x80, 0x88, 0x80, 0x80, 0x80, 0x88, 0x20, 0x08, 0xE0, 0x80, 0xF8, 0xE8, 0x88,
 0x88, 0x88, 0x88, 0xC0, 0x20, 0x88, 0x88, 0x88, 0x70, 0x70, 0x30, 0x20, 0x40, 0x20, 0x50, 0x00,
 0x10, 0x70, 0xF0, 0x70, 0x78, 0x70, 0x40, 0x70, 0xF0, 0x70, 0x70, 0x98, 0x20, 0xF0, 0xF0, 0x70,
 0xF0, 0x78, 0x70, 0x70, 0x40, 0x88, 0x88, 0x88, 0xD8, 0x88, 0xF8, 0x20, 0x20, 0x20, 0xB8, 0x00,
 0x00, 0x11, 0x88, 0x11, 0x88, 0x07, 0xE0, 0x00, 0x24, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x11, 0x88, 0x11, 0x88, 0x07, 0xE0, 0x00, 0x24, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x88, 0x08, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88, 0x44, 0x88, 0x54, 0xA8, 0x14, 0xA0, 0x00, 0xFC,
 0xF0, 0x78, 0x88, 0xD8, 0x88, 0xD8, 0x88, 0xD8, 0x20, 0x20, 0xF8, 0xF8, 0xF0, 0x88, 0x20, 0x20,
 0x00, 0x20, 0x00, 0x50, 0x70, 0x60, 0x60, 0x00, 0x20, 0x20, 0x70, 0xF8, 0x00, 0xF8, 0x00, 0x60,
 0xA8, 0xD0, 0x30, 0x10, 0x90, 0xF0, 0xF0, 0x60, 0x70, 0x78, 0x00, 0x00, 0xC0, 0x00, 0x18, 0x30,
 0xA8, 0x88, 0xF0, 0x80, 0x88, 0xF0, 0xF0, 0xB8, 0xF8, 0x20, 0x08, 0xC0, 0x80, 0xA8, 0xB8, 0x88,
 0xF0, 0xA8, 0xF0, 0x70, 0x20, 0x88, 0x88, 0x88, 0x20, 0x20, 0x60, 0x20, 0x60, 0x20, 0x00, 0x00,
 0x00, 0x08, 0x98, 0xC8, 0xC8, 0x88, 0xE0, 0x88, 0x98, 0x20, 0x10, 0xB0, 0x20, 0xA8, 0x98, 0xD8,
 0x88, 0x88, 0x48, 0x80, 0xE0, 0x88, 0x88, 0x88, 0x70, 0x88, 0x98, 0x60, 0x20, 0x30, 0x10, 0x00,
 0x00, 0x11, 0x88, 0x15, 0xA8, 0x05, 0xA0, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x11, 0x88, 0x15, 0xA8, 0x05, 0xA0, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0xF8, 0x78, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88, 0x54, 0xA8, 0x44, 0x88, 0x14, 0xA0, 0xFC, 0x00,
 0xE0, 0x38, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88, 0x20, 0xF8, 0x30, 0x60, 0x80, 0xF8, 0x20, 0x20,
 0x00, 0x20, 0x00, 0x50, 0x28, 0x40, 0xA8, 0x00, 0x20, 0x20, 0xF8, 0x20, 0x00, 0x00, 0x00, 0x40,
 0x88, 0x10, 0x60, 0x08, 0xF8, 0x08, 0x88, 0xC0, 0x88, 0x08, 0x00, 0x00, 0x60, 0xF8, 0x30, 0x20,
 0xB0, 0xF8, 0x88, 0x80, 0x88, 0x80, 0x80, 0x88, 0x88, 0x20, 0x08, 0xE0, 0x80, 0x88, 0x98, 0x88,
 0x80, 0xB8, 0xE0, 0x18, 0x20, 0x88, 0xD8, 0xA8, 0x70, 0x20, 0xC0, 0x20, 0x20, 0x20, 0x00, 0x00,
 0x00, 0x78, 0x88, 0x80, 0x88, 0xF8, 0x40, 0x88, 0x88, 0x20, 0x10, 0xE0, 0x20, 0xA8, 0x88, 0x88,
 0x88, 0x88, 0x40, 0x70, 0x40, 0x88, 0xD8, 0xA8, 0x20, 0xC8, 0x30, 0x20, 0x20, 0x20, 0x00, 0x00,
 0x00, 0x15, 0xA8, 0x11, 0x88, 0x05, 0xA0, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x15, 0xA8, 0x11, 0x88, 0x05, 0xA0, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x88, 0x88, 0xD8, 0xD8, 0xD8, 0xD8, 0xD8, 0xD8, 0x44, 0x88, 0x44, 0x88, 0x1C, 0xE0, 0x48, 0x00,
 0xC0, 0x18, 0xD8, 0xD8, 0xD8, 0xD8, 0xD8, 0xD8, 0x20, 0x70, 0x20, 0x20, 0x88, 0x80, 0x20, 0x20,
 0x00, 0x00, 0x00, 0xF8, 0xA8, 0xD0, 0x90, 0x00, 0x30, 0x60, 0xA8, 0x20, 0x20, 0x00, 0x20, 0xC0,
 0xD8, 0x10, 0xC8, 0x98, 0x10, 0x98, 0xC8, 0x80, 0x88, 0x98, 0x20, 0x20, 0x30, 0x00, 0x60, 0x00,
 0x80, 0x88, 0x88, 0xC8, 0x98, 0x88, 0x80, 0xC8, 0x88, 0x20, 0x98, 0xB0, 0x88, 0x88, 0x88, 0xD8,
 0x80, 0xD8, 0xB0, 0x88, 0x20, 0xD8, 0x70, 0xF8, 0xD8, 0x20, 0x88, 0x20, 0x30, 0x20, 0x00, 0x00,
 0x00, 0x88, 0x98, 0xC8, 0xC8, 0x80, 0x40, 0x78, 0x88, 0x20, 0x10, 0xB0, 0x20, 0xA8, 0x88, 0xD8,
 0xF0, 0x78, 0x40, 0x08, 0x48, 0xD8, 0x70, 0xF8, 0x70, 0x78, 0x60, 0x20, 0x20, 0x20, 0x00, 0x00,
 0x00, 0x11, 0x88, 0x11, 0x88, 0x07, 0xE0, 0x24, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x11, 0x88, 0x11, 0x88, 0x07, 0xE0, 0x24, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x88, 0x78, 0x70, 0x78, 0x70, 0x78, 0x70, 0x78, 0x44, 0x88, 0x7C, 0xF8, 0x14, 0xA0, 0x48, 0x00,
 0x80, 0x08, 0x70, 0x70, 0x70, 0x70, 0x70, 0x70, 0x20, 0x20, 0x00, 0x00, 0xF8, 0x70, 0x70, 0x70,
 0x00, 0x20, 0x00, 0x50, 0x70, 0x90, 0x68, 0x00, 0x18, 0xC0, 0x00, 0x00, 0x60, 0x00, 0x20, 0x80,
 0x70, 0x78, 0xF8, 0x70, 0x10, 0x70, 0x70, 0x80, 0x70, 0x70, 0x00, 0x60, 0x18, 0x00, 0xC0, 0x20,
 0x70, 0x88, 0xF0, 0x70, 0xF0, 0xF8, 0x80, 0x78, 0x88, 0x70, 0x70, 0x98, 0xF8, 0x88, 0x88, 0x70,
 0x80, 0x78, 0x98, 0x70, 0x20, 0x70, 0x20, 0x50, 0x88, 0x20, 0xF8, 0x38, 0x10, 0xE0, 0x00, 0xF8,
 0x00, 0x78, 0xF0, 0x70, 0x78, 0x70, 0x40, 0x08, 0x88, 0x70, 0x10, 0x98, 0x70, 0xA8, 0x88, 0x70,
 0x80, 0x08, 0x40, 0x70, 0x30, 0x78, 0x20, 0x50, 0xD8, 0x08, 0xF8, 0x18, 0x20, 0xC0, 0x00, 0x00,
 0x00, 0x11, 0x88, 0x1F, 0xF8, 0x05, 0xA0, 0x24, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x11, 0x88, 0x1F, 0xF8, 0x05, 0xA0, 0x24, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x7C, 0xF8, 0x00, 0x00, 0x14, 0xA0, 0xFC, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x70, 0x00, 0x00, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x80, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x70, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x1F, 0xF8, 0x00, 0x00, 0x05, 0xA0, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x1F, 0xF8, 0x00, 0x00, 0x05, 0xA0, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
};




/* Multicolor image attributes (16x9, 2 bytes / tile) */

const unsigned char imgattr[] PROGMEM = {
 0x80, 0x00, 0x80, 0x00, 0x89, 0x00, 0x89, 0x05, 0x89, 0x50, 0x89, 0x00, 0x89, 0x00, 0x89, 0x00, 0x89, 0x00, 0x89, 0x00, 0x89, 0x00, 0x89, 0x00, 0x89, 0x00, 0x89, 0x00, 0x89, 0x00, 0x89, 0x00,
 0x89, 0x00, 0x89, 0x00, 0x80, 0x00, 0x80, 0x50, 0x08, 0x50, 0x85, 0x00, 0x80, 0x50, 0x89, 0x50, 0x98, 0x50, 0x98, 0x50, 0x85, 0x00, 0x80, 0x95, 0x85, 0x09, 0x89, 0x50, 0x89, 0x00, 0x89, 0x00,
 0x89, 0x00, 0x89, 0x00, 0x80, 0x59, 0x05, 0x89, 0x80, 0x59, 0x85, 0x09, 0x08, 0x59, 0x05, 0x89, 0x05, 0x89, 0x50, 0x89, 0x85, 0x09, 0x05, 0x89, 0x05, 0x89, 0x05, 0x89, 0x89, 0x00, 0x89, 0x00,
 0x98, 0x40, 0x89, 0x00, 0x80, 0x95, 0x05, 0x89, 0x50, 0x89, 0x05, 0x89, 0x80, 0x59, 0x58, 0x09, 0x05, 0x89, 0x08, 0x59, 0x50, 0x89, 0x80, 0x59, 0x58, 0x90, 0x05, 0x89, 0x89, 0x00, 0x89, 0x74,
 0x49, 0x87, 0x98, 0x74, 0x98, 0x00, 0x89, 0xA0, 0x89, 0xA0, 0x98, 0xA0, 0x98, 0x05, 0x98, 0x50, 0x50, 0x89, 0x95, 0x80, 0x98, 0xA0, 0x98, 0x00, 0x89, 0xA0, 0x89, 0x00, 0x89, 0x47, 0x97, 0x40,
 0x47, 0x21, 0x47, 0x91, 0x94, 0x7A, 0x9A, 0x80, 0x9A, 0x80, 0x9A, 0x00, 0x9A, 0xB0, 0x95, 0x0A, 0x59, 0xA0, 0x9A, 0xB0, 0x9A, 0x80, 0xA9, 0x80, 0x98, 0x47, 0x97, 0x48, 0x74, 0x10, 0x42, 0x76,
 0x14, 0x27, 0x26, 0x74, 0x47, 0x12, 0x47, 0x80, 0x87, 0x40, 0x9A, 0x80, 0x9A, 0x80, 0x95, 0xAB, 0x89, 0xAB, 0x9A, 0x87, 0x98, 0x47, 0x84, 0x70, 0x84, 0x70, 0x47, 0x10, 0x47, 0x20, 0x72, 0x41,
 0x47, 0x10, 0x47, 0x12, 0x27, 0x41, 0x47, 0x10, 0x74, 0x00, 0x78, 0x40, 0x89, 0x74, 0x98, 0x76, 0x98, 0x76, 0x87, 0x40, 0x74, 0x63, 0x74, 0x60, 0x74, 0x10, 0x74, 0x10, 0x47, 0x21, 0x47, 0x10,
 0x47, 0x10, 0x71, 0x40, 0x47, 0x10, 0x47, 0x10, 0x47, 0x61, 0x74, 0x60, 0x47, 0x60, 0x76, 0x34, 0x76, 0x34, 0x67, 0x43, 0x47, 0x63, 0x63, 0x74, 0x74, 0x63, 0x47, 0x10, 0x74, 0x10, 0x14, 0x70
};

/* Multicolor image data (2304 bytes) */

const unsigned char imgdata[] PROGMEM = {
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x15, 0x55,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x50, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x14,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x15, 0x54, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x55, 0x55, 0x55,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0x55, 0x01, 0x55, 0x55, 0x55, 0x50, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0x55, 0x50, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x15, 0x54,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xBC, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x55,
 0x55, 0x55, 0x54, 0x00, 0x00, 0x00, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x40, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x55, 0x55, 0x54, 0x16, 0xFF, 0x15, 0x50, 0x00, 0x00, 0x00, 0x40, 0x00,
 0x00, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3A, 0xFF, 0xC5, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55,
 0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x54, 0x00, 0x00, 0x00, 0x05, 0x55, 0x55, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xEA, 0xFF, 0xC0, 0x05, 0x55, 0x55, 0x55, 0x55, 0x55,
 0x55, 0x55, 0x54, 0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0x15, 0x55, 0x00, 0x00, 0x00, 0x00, 0x15, 0x55,
 0x00, 0x00, 0x05, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x55, 0x55, 0x65, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x40, 0x15, 0x55, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x15, 0x55, 0x55, 0x55, 0x55,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x55, 0x55, 0x69, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x55, 0x55, 0x55, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0x55, 0x55, 0x51, 0x00, 0x00, 0x00, 0x00, 0xB0, 0x00,
 0x55, 0x55, 0x55, 0x55, 0x00, 0x00, 0x00, 0x00, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x55, 0x00, 0x10, 0x00, 0x00, 0x00, 0x05, 0x55, 0x55, 0x51, 0x00, 0x00, 0x00, 0x01, 0xC0, 0x00,
 0x55, 0x55, 0x55, 0x55, 0x00, 0x00, 0x00, 0x01, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x01, 0x55, 0x55, 0x54, 0x00, 0x00, 0x25, 0x56, 0x55, 0x52, 0x00, 0x00, 0x00, 0x05, 0x50, 0x00,
 0x01, 0x55, 0x41, 0x55, 0x00, 0x00, 0xA8, 0x05, 0x3F, 0xFF, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x15, 0x54, 0x55, 0x50, 0x00, 0x00, 0x00, 0x16, 0x00, 0x00,
 0x55, 0x55, 0x55, 0x55, 0x00, 0x00, 0x00, 0x17, 0x00, 0x00, 0x55, 0x55, 0x54, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0x50, 0x55, 0x50, 0x01, 0x80, 0x65, 0x55, 0xF8, 0x00,
 0xBF, 0x95, 0x5B, 0xFF, 0x00, 0x6A, 0x75, 0x55, 0xA7, 0xFF, 0xBF, 0x80, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x1A, 0x00, 0x06, 0x06, 0x40, 0x18, 0x00, 0x01, 0xA4,
 0x00, 0x1A, 0x15, 0x54, 0x06, 0xAA, 0x04, 0x00, 0x01, 0xA4, 0x00, 0x1A, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0x00, 0x2A, 0x00, 0x26, 0x1A, 0x01, 0x16, 0x05, 0xAA, 0x90,
 0x1A, 0xA9, 0x54, 0x96, 0x1A, 0x90, 0xA9, 0x0A, 0xAA, 0x90, 0x1A, 0xAA, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x95, 0x00, 0x6A, 0x00, 0x24, 0x29, 0x02, 0x14, 0x25, 0xAA, 0x80,
 0xAA, 0xA8, 0x5A, 0x16, 0x2A, 0x00, 0xA8, 0x1A, 0xAA, 0x80, 0xAA, 0xAA, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x02, 0x55, 0x00, 0x6A, 0x00, 0x14, 0x68, 0x02, 0x98, 0x1F, 0xEA, 0x42,
 0xAA, 0xA4, 0x6A, 0x12, 0x1A, 0xA8, 0xA4, 0x2A, 0xAA, 0x90, 0x02, 0xAA, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x05, 0x55, 0x55, 0x00, 0x25, 0x00, 0xAA, 0x00, 0x98, 0x68, 0x36, 0xB8, 0x3F, 0xFF, 0x43,
 0xFF, 0xF4, 0x7F, 0x5F, 0xF6, 0xAA, 0xA4, 0x2A, 0xAA, 0xA0, 0x00, 0xAA, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x14, 0x01, 0xFF, 0xC5, 0x00, 0xFF, 0xFC, 0x50, 0xA4, 0x0A, 0x50, 0x95, 0xAF, 0x07,
 0xAA, 0xB0, 0x3C, 0x5F, 0x00, 0x0A, 0xA0, 0x7F, 0xFF, 0xFF, 0xE0, 0xFF, 0x40, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x00, 0x6A, 0x02, 0x60, 0xA0, 0x2A, 0x50, 0x55, 0xAA, 0x0A,
 0xAA, 0xA0, 0xA9, 0x4A, 0x00, 0x2A, 0xB0, 0xEA, 0xAA, 0xBF, 0x80, 0xFF, 0x55, 0x55, 0x54, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x00, 0x1A, 0x09, 0x40, 0xA4, 0xA9, 0xF0, 0xBC, 0x1A, 0x06,
 0x81, 0xA0, 0x25, 0x6A, 0x00, 0xA9, 0xF0, 0x68, 0x1F, 0xFE, 0x01, 0xFF, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0x00, 0x06, 0x05, 0x2A, 0x00, 0x06, 0x05, 0x55, 0x15, 0xAA,
 0x06, 0xA0, 0x00, 0x15, 0x15, 0x52, 0x05, 0x55, 0x16, 0x93, 0x06, 0xAA, 0x00, 0x00, 0x05, 0x44,
 0x00, 0x00, 0x55, 0x55, 0xAA, 0x35, 0x10, 0x00, 0x54, 0xAA, 0x80, 0x1A, 0x01, 0x56, 0x55, 0x6A,
 0x1B, 0xF8, 0x00, 0x06, 0x55, 0x4A, 0x01, 0x56, 0x54, 0x3F, 0x1A, 0xAA, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x55, 0x55, 0xAA, 0xB5, 0x69, 0x00, 0x53, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x55, 0x55,
 0xAA, 0xFF, 0x55, 0x55, 0xAA, 0xAA, 0x00, 0x02, 0x0F, 0xFC, 0xAA, 0xAA, 0x00, 0x55, 0x55, 0x55,
 0x01, 0x55, 0x55, 0x55, 0xAA, 0xD5, 0xFE, 0x95, 0x3F, 0xFF, 0xFF, 0xFA, 0xFF, 0xFC, 0x50, 0x2A,
 0x15, 0x5A, 0x55, 0xFF, 0xFF, 0xFF, 0xC2, 0x95, 0xFF, 0x16, 0xFF, 0xFF, 0x55, 0x55, 0x50, 0x00,
 0x55, 0x55, 0x00, 0x00, 0x00, 0x54, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0x00, 0x00, 0x2A, 0xAA,
 0x00, 0x00, 0x2A, 0xA5, 0xE8, 0x05, 0x55, 0x55, 0x1A, 0xAA, 0xFF, 0xFF, 0x50, 0x55, 0x55, 0x55,
 0x00, 0x05, 0x00, 0x00, 0x03, 0x50, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0x00, 0x09, 0xA0, 0x55,
 0xEA, 0x54, 0x00, 0x00, 0x55, 0x55, 0x6A, 0x00, 0x55, 0x55, 0xAA, 0xAA, 0x55, 0x55, 0x55, 0x45,
 0x00, 0x00, 0x55, 0x54, 0x0D, 0x40, 0xAA, 0xFF, 0xFF, 0xFF, 0xFE, 0xAA, 0x00, 0x05, 0x1F, 0xD7,
 0xFF, 0xFF, 0xD5, 0xAA, 0x00, 0xAF, 0xFF, 0xFF, 0xAA, 0xAA, 0xFF, 0xFF, 0x55, 0x55, 0x00, 0x00,
 0x80, 0x00, 0x55, 0x55, 0xAF, 0xAA, 0xFE, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0x00, 0x26, 0x55, 0x55,
 0xAB, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x55, 0x55, 0xAA, 0xFF, 0x55, 0x55, 0x55, 0x5B,
 0x15, 0x55, 0x00, 0x00, 0x01, 0x55, 0x00, 0x00, 0x01, 0x55, 0x00, 0x05, 0x00, 0x6B, 0x00, 0x06,
 0x15, 0x42, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x15, 0x50, 0x00, 0x00, 0x00, 0x05, 0x00, 0x16,
 0x02, 0xAA, 0x55, 0x55, 0x55, 0x55, 0x00, 0x00, 0x01, 0x00, 0x54, 0x00, 0x00, 0x3A, 0xFF, 0xFF,
 0x55, 0x55, 0x6A, 0xAA, 0x55, 0x55, 0x55, 0x55, 0x00, 0x00, 0x05, 0x55, 0x55, 0x55, 0x00, 0x5A,
 0x01, 0x55, 0x00, 0x55, 0x55, 0x40, 0x55, 0x55, 0x55, 0x55, 0x00, 0x01, 0x55, 0x5E, 0xFE, 0xA5,
 0xBF, 0x85, 0x60, 0x00, 0x54, 0x05, 0x00, 0x00, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x14, 0x5A,
 0x00, 0x05, 0x01, 0x55, 0x55, 0x55, 0x00, 0x00, 0x55, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0xFF, 0xF9, 0xE0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0x55, 0x55, 0x55, 0x59, 0x5F, 0x6A, 0x6A,
 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x55, 0x55, 0x54, 0x01, 0x00, 0x11, 0x40, 0x00, 0x00, 0x55,
 0xAF, 0xFD, 0xE0, 0x00, 0x54, 0x14, 0x05, 0x51, 0x55, 0x55, 0x55, 0x55, 0x7A, 0xDF, 0x99, 0x6A,
 0x0C, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x55, 0x00, 0x00, 0x00, 0x55, 0x55, 0x55, 0x55, 0x50, 0x00,
 0xFF, 0x85, 0x60, 0x02, 0x55, 0x55, 0x55, 0x55, 0x00, 0x00, 0x15, 0x55, 0xFA, 0xEE, 0x99, 0x66,
 0x00, 0x30, 0xB0, 0x00, 0x00, 0x00, 0x55, 0x56, 0x95, 0xA9, 0x00, 0x0A, 0x01, 0x50, 0x05, 0x56,
 0x15, 0x54, 0x80, 0x00, 0x02, 0x80, 0x00, 0x00, 0x69, 0xA5, 0x55, 0x55, 0xEA, 0xFA, 0x99, 0x6A,
 0x30, 0x30, 0x33, 0x80, 0x00, 0x00, 0x55, 0x55, 0x55, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0B,
 0x54, 0x2A, 0xAA, 0x8A, 0x00, 0x00, 0x00, 0x00, 0x55, 0x55, 0x55, 0x55, 0xAF, 0xEE, 0x99, 0xAA,
 0x15, 0x00, 0x04, 0x2A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x19,
 0x15, 0x55, 0x00, 0x00, 0x00, 0x05, 0x05, 0x55, 0x00, 0x00, 0x01, 0xA0, 0x11, 0x41, 0x00, 0x00,
 0x65, 0x10, 0x14, 0x2A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x14, 0x00, 0x00, 0x00, 0x00, 0x00, 0x28,
 0x55, 0x55, 0x00, 0x00, 0x00, 0x00, 0x55, 0x55, 0x05, 0x40, 0x01, 0xA2, 0x15, 0x41, 0x05, 0x08,
 0xA9, 0x41, 0x00, 0x08, 0x00, 0x00, 0x05, 0x51, 0x00, 0x00, 0x00, 0x15, 0x00, 0x04, 0x3F, 0x2B,
 0xA6, 0x95, 0x00, 0x01, 0x45, 0x00, 0x41, 0x56, 0x55, 0x55, 0x05, 0xAA, 0x45, 0x41, 0x54, 0x88,
 0xBA, 0x05, 0x33, 0x04, 0x60, 0x30, 0x00, 0x00, 0x15, 0x50, 0x54, 0x00, 0x55, 0x00, 0xFC, 0x1A,
 0xC5, 0x59, 0x55, 0x40, 0x00, 0x54, 0x55, 0xAA, 0x55, 0x55, 0xF6, 0x96, 0x46, 0x56, 0x13, 0xD8,
 0xFA, 0x10, 0x00, 0xD4, 0x50, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01,
 0xF5, 0x55, 0x00, 0x05, 0x55, 0x15, 0x1A, 0xAA, 0x55, 0x55, 0xBA, 0x66, 0x56, 0x9A, 0x03, 0x52,
 0xB8, 0x24, 0x04, 0x13, 0x58, 0x03, 0x54, 0x02, 0xAA, 0x00, 0x00, 0x15, 0x55, 0x55, 0xFF, 0xFC,
 0x36, 0xAA, 0x55, 0x55, 0x00, 0x55, 0x6A, 0xAA, 0x55, 0x5A, 0x66, 0xAA, 0x5A, 0xA5, 0x09, 0x50,
 0x7C, 0xA9, 0x05, 0x13, 0x56, 0x80, 0x00, 0x2A, 0xAA, 0x80, 0x00, 0x00, 0x05, 0x54, 0x0C, 0x3F,
 0x36, 0xAA, 0x5A, 0x41, 0x05, 0x00, 0xAA, 0xAA, 0x55, 0x7F, 0x66, 0xAA, 0x56, 0x51, 0x0D, 0x50,
 0x1F, 0xA9, 0x30, 0x04, 0x56, 0xA8, 0x0A, 0xAA, 0xAA, 0xA1, 0x55, 0x55, 0x56, 0x9A, 0xFF, 0xFC,
 0xCA, 0xAA, 0x40, 0x00, 0x00, 0xA2, 0xAA, 0xAA, 0x59, 0xFB, 0xAA, 0x69, 0x15, 0x51, 0x2D, 0x40,
 0x14, 0x2B, 0x05, 0xBF, 0x01, 0x10, 0x12, 0xAA, 0x00, 0x00, 0x15, 0x50, 0x00, 0x00, 0x00, 0x01,
 0x1A, 0xFE, 0x05, 0x50, 0x01, 0x55, 0x00, 0x00, 0x15, 0x95, 0x00, 0x01, 0x00, 0x05, 0x05, 0x67,
 0x05, 0x2F, 0x80, 0xEB, 0x04, 0x00, 0x54, 0x2A, 0x00, 0x00, 0x85, 0x15, 0x54, 0x15, 0xBF, 0xA1,
 0x55, 0x56, 0x55, 0x40, 0x05, 0x55, 0x00, 0x01, 0x55, 0x56, 0x00, 0x41, 0x44, 0x55, 0x05, 0x5F,
 0x1D, 0x5F, 0xB0, 0xFB, 0x01, 0x81, 0x05, 0x0A, 0x00, 0x00, 0xA8, 0x50, 0x00, 0x00, 0x00, 0x01,
 0xA9, 0x55, 0x00, 0x00, 0x15, 0x55, 0x00, 0x45, 0x55, 0x99, 0x14, 0x55, 0x41, 0x10, 0x85, 0xFF,
 0x57, 0x77, 0xFC, 0xF5, 0xC1, 0x21, 0x04, 0x45, 0x40, 0x00, 0xAA, 0x00, 0x01, 0x55, 0xA8, 0x00,
 0x56, 0xAA, 0x54, 0x02, 0x55, 0x55, 0x01, 0x55, 0x5A, 0x59, 0x15, 0x50, 0x54, 0x50, 0x07, 0xFE,
 0x77, 0x57, 0xFC, 0xD0, 0xD4, 0x14, 0x44, 0x45, 0x50, 0x00, 0xAA, 0xA0, 0x00, 0x05, 0xBE, 0xBF,
 0xFE, 0xAA, 0x50, 0x0A, 0x55, 0x55, 0x15, 0x56, 0x65, 0x9A, 0x14, 0x48, 0x44, 0x50, 0x07, 0xBE,
 0xFF, 0xC7, 0xBA, 0x00, 0xD6, 0x15, 0x11, 0x45, 0x66, 0x00, 0xAA, 0xA8, 0x00, 0x15, 0xAA, 0xAA,
 0xAA, 0xAA, 0x40, 0xAA, 0x55, 0x5B, 0x65, 0x9A, 0x65, 0x9A, 0x44, 0x61, 0x00, 0x90, 0xAA, 0xF2,
 0x35, 0xC1, 0xFF, 0x80, 0xC6, 0x01, 0x54, 0x55, 0x6A, 0x40, 0xAA, 0xAA, 0x80, 0x01, 0xAB, 0xFF,
 0xFF, 0xA9, 0x2A, 0xAE, 0x55, 0xFB, 0x6A, 0x95, 0x9A, 0xA5, 0x40, 0x41, 0x01, 0xA0, 0x82, 0xEA,
 0x4D, 0xD1, 0xBF, 0xBC, 0xF0, 0x10, 0x14, 0x11, 0x5A, 0x94, 0xAA, 0xAA, 0xA8, 0x00, 0xAA, 0xBE,
 0xA9, 0x50, 0xAA, 0xFE, 0xFF, 0xBF, 0xA6, 0x96, 0x9A, 0xA5, 0x4A, 0x15, 0x06, 0xA0, 0x0F, 0xA2,
 0x04, 0x51, 0x01, 0x2B, 0x06, 0x96, 0x14, 0x40, 0x05, 0x51, 0x00, 0x15, 0x00, 0x01, 0x00, 0x00,
 0x05, 0x65, 0x01, 0x55, 0x01, 0x41, 0x04, 0x54, 0x10, 0x15, 0x16, 0x50, 0x12, 0xA0, 0x01, 0x14,
 0x44, 0x00, 0x61, 0x0B, 0x55, 0x69, 0x04, 0x50, 0x41, 0x41, 0x00, 0x01, 0x20, 0x00, 0x55, 0x41,
 0x55, 0xAA, 0x56, 0x56, 0x00, 0x11, 0x01, 0x04, 0x54, 0x5A, 0x0A, 0x41, 0x06, 0xBF, 0x10, 0x00,
 0x48, 0x00, 0x01, 0x40, 0x56, 0x9A, 0x45, 0x15, 0x41, 0x41, 0x88, 0x08, 0xAB, 0xA2, 0x56, 0x59,
 0x6A, 0xAA, 0x66, 0x56, 0x00, 0x10, 0x44, 0x10, 0x54, 0x45, 0x4A, 0x04, 0x56, 0x2F, 0xA0, 0x46,
 0x0A, 0x50, 0x10, 0x50, 0xA6, 0x69, 0x00, 0x15, 0x01, 0x14, 0x88, 0x80, 0xAA, 0xEA, 0xAA, 0xBA,
 0xAF, 0xAA, 0x96, 0x55, 0x05, 0x00, 0x45, 0x10, 0x11, 0x40, 0x44, 0x51, 0x55, 0xBF, 0x80, 0x40,
 0x02, 0x02, 0x11, 0x54, 0xBA, 0x5A, 0x52, 0x04, 0x14, 0x10, 0x00, 0x80, 0xEA, 0xEA, 0xAA, 0xAE,
 0xAF, 0xAA, 0x55, 0x65, 0x06, 0x81, 0x05, 0x02, 0x05, 0x01, 0x41, 0x55, 0x54, 0x3F, 0x80, 0x22,
 0x02, 0x02, 0x80, 0x48, 0xBA, 0xA5, 0x05, 0x45, 0x00, 0x00, 0x00, 0x00, 0xFA, 0xAE, 0xBB, 0xFF,
 0xEA, 0xAA, 0x55, 0x55, 0x0A, 0xB4, 0x10, 0x0A, 0x56, 0x44, 0x45, 0x50, 0x04, 0x41, 0x52, 0xA0,
 0x80, 0x12, 0xA0, 0x10, 0xAF, 0x9A, 0x00, 0x45, 0x40, 0x01, 0xA2, 0x00, 0xEB, 0xAA, 0xAA, 0xAB,
 0xFE, 0xEA, 0x55, 0x55, 0x0A, 0xB0, 0x08, 0x00, 0x59, 0x00, 0x45, 0x40, 0x01, 0x41, 0x52, 0xA2,
 0x84, 0x00, 0xA8, 0x45, 0x6E, 0xAA, 0x50, 0x01, 0x45, 0x50, 0x20, 0x00, 0xEB, 0xAF, 0xAA, 0xAA,
 0xAF, 0xFA, 0x55, 0x96, 0x0F, 0xF0, 0x2A, 0x01, 0x50, 0x11, 0x45, 0x01, 0x45, 0x04, 0x42, 0x4A,
 0x06, 0x84, 0x1A, 0xAA, 0x12, 0x85, 0x01, 0x00, 0x01, 0x15, 0x00, 0x00, 0x14, 0x51, 0x01, 0x40,
 0x01, 0x65, 0x05, 0x56, 0x15, 0x55, 0x01, 0x2B, 0x01, 0x11, 0x05, 0x11, 0x11, 0x61, 0x05, 0x90,
 0x80, 0x88, 0x19, 0x88, 0x10, 0x85, 0x40, 0x05, 0x01, 0x55, 0x14, 0x00, 0x55, 0x55, 0x05, 0x50,
 0x31, 0x65, 0xC0, 0x55, 0x55, 0xA9, 0x15, 0xA8, 0x81, 0x51, 0x44, 0x05, 0x50, 0x61, 0x05, 0x95,
 0x00, 0x8A, 0xA9, 0x68, 0x04, 0x80, 0x41, 0x40, 0x15, 0xAA, 0x92, 0xAA, 0xAA, 0x45, 0x06, 0xA0,
 0x02, 0xA3, 0x53, 0x14, 0xAA, 0xBF, 0xAA, 0xA0, 0xF1, 0x70, 0x41, 0x24, 0x40, 0x95, 0x19, 0x95,
 0x40, 0x12, 0x89, 0x66, 0x81, 0x40, 0x21, 0x54, 0x14, 0x55, 0x10, 0x01, 0x55, 0x06, 0x55, 0x60,
 0x00, 0x00, 0x54, 0xF1, 0x56, 0xAF, 0xEB, 0xB3, 0x71, 0xF1, 0x05, 0x04, 0x04, 0x69, 0x64, 0x10,
 0x29, 0x04, 0xAA, 0x6A, 0x21, 0x10, 0x40, 0x10, 0x10, 0x41, 0x01, 0x01, 0x55, 0x15, 0x0A, 0xA5,
 0x54, 0x06, 0x33, 0xC5, 0x52, 0xFC, 0xEB, 0xBB, 0x05, 0xD5, 0x14, 0x14, 0x14, 0xAA, 0x64, 0x44,
 0xA0, 0x00, 0xA1, 0x52, 0x68, 0x00, 0x04, 0x14, 0x0C, 0x11, 0x01, 0x01, 0x14, 0x11, 0xC0, 0x00,
 0x16, 0x99, 0x15, 0x59, 0x55, 0x54, 0xBA, 0xBB, 0x10, 0x55, 0x50, 0x04, 0x15, 0x91, 0x60, 0x00,
 0xAA, 0x81, 0xAA, 0x9A, 0x08, 0x50, 0x14, 0x84, 0x33, 0x14, 0x51, 0x41, 0x50, 0x51, 0xCC, 0x05,
 0x99, 0x50, 0x55, 0x55, 0x15, 0x14, 0xFA, 0xFA, 0x00, 0x1D, 0x10, 0xA0, 0x69, 0x05, 0x15, 0x00,
 0xAA, 0x28, 0x9A, 0x9A, 0x10, 0x04, 0x00, 0x80, 0x00, 0x04, 0x40, 0x40, 0x55, 0x55, 0x30, 0x1A,
 0x50, 0x00, 0x55, 0x55, 0x55, 0x54, 0xAA, 0xEA, 0x00, 0xFD, 0x10, 0x82, 0xA5, 0x55, 0x04, 0x00
};
