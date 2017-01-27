/*
 *  Uzebox Kernel - Mode 72
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

/**
 * ===========================================================================
 * Function prototypes for video mode 72
 * ===========================================================================
 */

#pragma once

#include <avr/io.h>

/* User accessible sprite structures */

typedef struct{
 unsigned char off;    /* Sprite start offset within its memory bank */
 unsigned char bank;   /* Memory bank of sprite (high byte of RAM address) */
 unsigned char xpos;   /* Sprite X position, 32: Left edge */
 unsigned char ypos;   /* Sprite Y position, 32: Top edge */
 unsigned char height; /* Sprite height and X mirror on bit 7. 0: No sprite */
 unsigned char col1;   /* Color of '1' pixels */
 unsigned char col2;   /* Color of '2' pixels */
 unsigned char col3;   /* Color of '3' pixels */
}sprite_t;

/* Provided by VideoMode72.s */

extern sprite_t       sprites[20];
extern unsigned char  palette[16];
extern unsigned char  bordercolor;
#if (M72_SCOLOR_ENA != 0)
extern unsigned char  m72_scolor[M72_MAXHEIGHT];
#endif
#if (M72_USE_LINE_ADDR != 0)
extern unsigned int   m72_rowoff[M72_LINE_ADDR_ROWS];
#else
extern unsigned int   m72_rowoff[32];
#endif
extern unsigned char  m72_config;
extern unsigned char  m72_ypos;
extern unsigned char  m72_charrom;

extern unsigned char* m72_tt_vram;
extern unsigned char  m72_tt_trows;
extern unsigned char  m72_tt_pad;
extern unsigned char  m72_tt_hgt;
extern unsigned char  m72_tt_bcol;
extern unsigned char  m72_tt_fcol;
extern unsigned char  m72_tt_col;
extern unsigned char  m72_lt_col;

extern unsigned char* m72_tb_vram;
extern unsigned char  m72_tb_trows;
extern unsigned char  m72_tb_pad;
extern unsigned char  m72_tb_hgt;
extern unsigned char  m72_tb_bcol;
extern unsigned char  m72_tb_fcol;
extern unsigned char  m72_tb_col;
extern unsigned char  m72_lb_col;

/* Provided by the user tileset */

extern const unsigned char m72_defpalette[];
extern const unsigned int  m72_deftilerows[];
