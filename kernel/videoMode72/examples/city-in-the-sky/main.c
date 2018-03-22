/*
 *  Uzebox video mode 72 simple demo
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
*/

#include <stdbool.h>
#include <avr/io.h>
#include <stdlib.h>
#include <avr/pgmspace.h>
#include <uzebox.h>


/***********************************************
 *                    DATA
 **********************************************/


/* Sprite images (2bpp) */
static const unsigned char cursor_sprite_data[] PROGMEM = {

 0b00000011U,0b11000000U,
 0b00000011U,0b11000000U,
 0b00001100U,0b00110000U,
 0b00001100U,0b00110000U,
 0b00110000U,0b00001100U,
 0b00110000U,0b00001100U,
 0b11000000U,0b00000011U,
 0b11111100U,0b00111111U,
 0b00001100U,0b00110000U,
 0b00001100U,0b00110000U,
 0b00001100U,0b00110000U,
 0b00001100U,0b00110000U,
 0b00001100U,0b00110000U,
 0b00001100U,0b00110000U,
 0b00001100U,0b00110000U,
 0b00001111U,0b11110000U,
};


/* Background */
#define BG_WIDTH 48
#define BG_HEIGHT 32
#define BORDER_SIZE 2 // "no-bg" border on left and right
#define GROUND_Y 4

/* UI */
#define SPRITE_UNMIRRORED 0x7FFFU
#define SPRITE_MIRRORED 0xFFFFU
#define SPRITE_INDEX_CURSOR 0
int cursor_actioned = 0; // bitmask: we can only press each direction once before we left go of all direction buttons

/* Data */
static sprite_t cursor_sprite;
static bullet_t main_bullets[50];
static u8 main_vram[BG_HEIGHT][BG_WIDTH];
static u8 main_tram[256];

/* ACII */
static const unsigned char txt_data[] PROGMEM =
{
	0x8DU, 0x8FU, 0x8EU, 0x85U, 0x99U, 0x20U, 0x24U, 0x31U, 0x30U, 0x30U, 0x20U
};


/***********************************************
 *                INITIALISATION
 **********************************************/

void ClearDefaultBG() {
	for (u8 y = 0; y < BG_HEIGHT - GROUND_Y; y++) {
		for (u8 x = 0; x < BG_WIDTH; x++) {
			main_vram[y][x] = 0U;
		}
	}
	for (u8 y = BG_HEIGHT - GROUND_Y; y < BG_HEIGHT; y++) {
		for (u8 x = 0; x < BG_WIDTH; x++) {
			main_vram[y][x] = 1U;
		}
	}
}

void InitMode72() {

	/* Camera */
	m72_ypos = (GROUND_Y + BORDER_SIZE) * TILE_HEIGHT; // start at bottom of map

	/* VRAM start offsets */
	u8 i = 0U;
	for (i = 0U; i < BG_HEIGHT; i++){
		m72_rowoff[i] = (u16)(&main_vram[i][0]);
	}

	/* Text mode VRAM contents */
	do{
		main_tram[i] = i;
		i ++;
	}while (i != 0U);
	for (i = 0U; i < sizeof(txt_data); i++){
		main_tram[i] = pgm_read_byte(&(txt_data[i]));
	}

	/* Configure mode */
	m72_tt_hgt = 10U;
	m72_tb_hgt = 0U;
	m72_tt_trows = 1U;
	m72_tb_trows = 0U;
	m72_tt_vram = &main_tram[ 0U];
	m72_tb_vram = &main_tram[40U];
	bordercolor = 0x52U;

	/* Sprite mode 5 */
	m72_config = 0x54U;

}

void InitUI() {

	cursor_sprite.xpos   = TILE_WIDTH * 11;
	cursor_sprite.ypos   = TILE_HEIGHT * 6;
	cursor_sprite.off    = ((u16)&cursor_sprite_data) & SPRITE_UNMIRRORED;
	cursor_sprite.height = 16U;
	cursor_sprite.col1   = 0x13U;
	cursor_sprite.col2   = 0x47U;
	cursor_sprite.col3   = 0x7FU;
	sprites[SPRITE_INDEX_CURSOR] = &cursor_sprite;

}

/***********************************************
 *                 THE BRAINS
 **********************************************/

// Get height of whatever building is at (x,y) in pixels.
// Returns 0 if no building is at this location.
u8 BuildingHeightAtLocation(u8 x, u8 y) {

	u8 buildingAtLocation = main_vram[y / TILE_HEIGHT][x / TILE_WIDTH];

	switch(buildingAtLocation) {
		case 0: // sky
			return 0;
		case 1: // solid block: tower or ground
			if (y >= GROUND_Y * TILE_HEIGHT - m72_ypos) {
				return 0;
			} else {
				return 3 * TILE_HEIGHT;
			}
		case 2:
			return 3 * TILE_HEIGHT;
		default:
			return 0;
	}
	
}

void InputThink() {
	int buttons = ReadJoypad(0);

	if(buttons & BTN_LEFT) {
		if (!(cursor_actioned & BTN_LEFT)){
			cursor_actioned |= BTN_LEFT;
			if (cursor_sprite.xpos == TILE_WIDTH * 2) {
				// todo: try to scroll left
			} else {
				cursor_sprite.xpos -= TILE_WIDTH;
			}
		}
	}
	else if(buttons & BTN_RIGHT) {
		if (!(cursor_actioned & BTN_RIGHT)){
			cursor_actioned |= BTN_RIGHT;
			if (cursor_sprite.xpos == SCREEN_TILES_H * TILE_WIDTH) {
				// todo: try to scroll right
			} else {
				cursor_sprite.xpos += TILE_WIDTH;
			}
		}
	}
	else if(buttons & BTN_UP) {
		if (!(cursor_actioned & BTN_UP)){
			cursor_actioned |= BTN_UP;
			cursor_sprite.ypos += BuildingHeightAtLocation(cursor_sprite.xpos, cursor_sprite.ypos - 1);
		}
	}
	else if(buttons & BTN_DOWN) {
		if (!(cursor_actioned & BTN_DOWN)){
			cursor_actioned |= BTN_DOWN;
			cursor_sprite.ypos -= BuildingHeightAtLocation(cursor_sprite.xpos, cursor_sprite.ypos);
		}
	}
	else {
		cursor_actioned = 0;
	}

}


/***********************************************
 *                 ENTRY POINT
 **********************************************/

int main(void){

	InitMode72();
	InitUI();
	ClearDefaultBG();

	while(true){
		InputThink();
		WaitVsync(1);
	}

}
