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
#include "main.h"

/***********************************************
 *                    TODO
 **********************************************/
/*
 * Bottom UI sprites
 * Purchase buildings
 * Horizontal scrolling
 * Cursor movement snap to buildings
 * Waves of enemies
 * Auto-firing bullets
 * Top bar text
 * Tower upgrades
 * Intro Screen
 * Music
 * Two player
 * 
 */



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

static u8 cursor_actioned[] = { 0, 0 }; // bitmask: we can only press each direction once before we left go of all direction buttons

/* Data */
static sprite_t cursor_sprite;
static bullet_t main_bullets[50];
static u8 main_vram[BG_HEIGHT][BG_WIDTH];
static u8 main_tram[120];
static int p1_money = 321;
static int p2_money = 78;
static u8 players_joined_game = 0;

static u8 build_selection[] = { BUILD_TOWER, BUILD_TOWER };
static u8 selection_mode[] = { SELECT_MOVE, SELECT_MOVE };

/* ACII */
static const unsigned char txt_money[] PROGMEM = "P1 $                             P2 $   ";
static const unsigned char txt_build[] PROGMEM = "P1+  TOWER  CHIMNEY  OFFICE  FRAME  $   P2+  TOWER  CHIMNEY  OFFICE  FRAME  $   ";
static const unsigned char txt_upgrd[] PROGMEM = "P1+  TOWER  CHIMNEY  OFFICE  FRAME  $   P2+  TOWER  CHIMNEY  OFFICE  FRAME  $   ";
static const unsigned char txt_start[] PROGMEM = "    P1 PRESS ANY BUTTON TO JOIN GAME        P2 PRESS ANY BUTTON TO JOIN GAME    ";


/***********************************************
 *                  UTILITIES
 **********************************************/

u8 ascii2petscii(u8 Character)
{
	if ((Character >= '@') && (Character <= ']'))
	{
		return Character - 0x40;
	}
	if (Character == 0) {
		return 0x20; // space
	}
	return Character;
}


/***********************************************
 *                     MENUS
 **********************************************/
void RefreshPlayerMoney() {

	char buffer[5] = "    ";

	// load default string
	for (u8 i = 0; i < TEXT_ROW_SIZE; i++){
		u8 ascii = pgm_read_byte(&(txt_money[i]));
		main_tram[i] = ascii2petscii(ascii);
	}

	// replace dollar values
	itoa(p1_money, (char*)&buffer, 10);
	main_tram[4] = ascii2petscii(buffer[0]);
	main_tram[5] = ascii2petscii(buffer[1]);
	main_tram[6] = ascii2petscii(buffer[2]);
	itoa(p2_money, (char*)&buffer, 10);
	main_tram[37] = ascii2petscii(buffer[0]);
	main_tram[38] = ascii2petscii(buffer[1]);
	main_tram[39] = ascii2petscii(buffer[2]);

}

void ShowPressAKeyToJoin(u8 player) {
	// load default string
	for (u8 i = TEXT_ROW_SIZE * player; i < TEXT_ROW_SIZE + TEXT_ROW_SIZE * player; i++){
		u8 ascii = pgm_read_byte(&(txt_start[i]));
		main_tram[i + TEXT_ROW_SIZE] = ascii2petscii(ascii);
	}
}

void UpdateBuildMenuSelection(u8 build_selection, u8 text_row) {
	switch(build_selection) {
		case BUILD_TOWER:
			main_tram[4  + TEXT_ROW_SIZE * text_row] = ascii2petscii('-');
			main_tram[10 + TEXT_ROW_SIZE * text_row] = ascii2petscii('-');
			main_tram[37 + TEXT_ROW_SIZE * text_row] = ascii2petscii('1'); // cost display
			main_tram[38 + TEXT_ROW_SIZE * text_row] = ascii2petscii('0');
			main_tram[39 + TEXT_ROW_SIZE * text_row] = ascii2petscii('0');
			break;
		case BUILD_CHIMNEY:
			main_tram[11 + TEXT_ROW_SIZE * text_row] = ascii2petscii('-');
			main_tram[19 + TEXT_ROW_SIZE * text_row] = ascii2petscii('-');
			main_tram[37 + TEXT_ROW_SIZE * text_row] = ascii2petscii('1'); // cost display
			main_tram[38 + TEXT_ROW_SIZE * text_row] = ascii2petscii('7');
			main_tram[39 + TEXT_ROW_SIZE * text_row] = ascii2petscii('0');
			break;
		case BUILD_OFFICE:
			main_tram[20 + TEXT_ROW_SIZE * text_row] = ascii2petscii('-');
			main_tram[27 + TEXT_ROW_SIZE * text_row] = ascii2petscii('-');
			main_tram[37 + TEXT_ROW_SIZE * text_row] = ascii2petscii('2'); // cost display
			main_tram[38 + TEXT_ROW_SIZE * text_row] = ascii2petscii('3');
			main_tram[39 + TEXT_ROW_SIZE * text_row] = ascii2petscii('0');
			break;
		case BUILD_FRAME:
			main_tram[28 + TEXT_ROW_SIZE * text_row] = ascii2petscii('-');
			main_tram[34 + TEXT_ROW_SIZE * text_row] = ascii2petscii('-');
			main_tram[37 + TEXT_ROW_SIZE * text_row] = ascii2petscii('3'); // cost display
			main_tram[38 + TEXT_ROW_SIZE * text_row] = ascii2petscii('0');
			main_tram[39 + TEXT_ROW_SIZE * text_row] = ascii2petscii('0');
			break;
	}
}

void ShowBuildMenu(u8 player) {

	// load default string
	for (u8 i = TEXT_ROW_SIZE * player; i < TEXT_ROW_SIZE + TEXT_ROW_SIZE * player; i++){
		u8 ascii = pgm_read_byte(&(txt_build[i]));
		main_tram[i + TEXT_ROW_SIZE] = ascii2petscii(ascii);
	}

	// Render current player selection text
	UpdateBuildMenuSelection(build_selection[player], player + 1);
}

void ShowCursorContextMenu(u8 player) {
	// show blank text
	for (u8 i = TEXT_ROW_SIZE * player; i < TEXT_ROW_SIZE + TEXT_ROW_SIZE * player; i++){
		main_tram[i + TEXT_ROW_SIZE] = ascii2petscii(' ');
	}
}


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

	/* Camera at ground level */
	m72_ypos = (GROUND_Y + BORDER_SIZE) * TILE_HEIGHT + TEXT_BOTTOM_HEIGHT;

	/* VRAM start offsets */
	u8 i = 0U;
	for (i = 0U; i < BG_HEIGHT; i++){
		m72_rowoff[i] = (u16)(&main_vram[i][0]);
	}

	/* Text mode VRAM contents */
	RefreshPlayerMoney();
	ShowPressAKeyToJoin(0);
	ShowPressAKeyToJoin(1);

	/* Configure mode */
	m72_tt_hgt = TEXT_TOP_HEIGHT;
	m72_tb_hgt = TEXT_BOTTOM_HEIGHT;
	m72_tt_trows = 1U;
	m72_tb_trows = 2U;
	m72_tt_vram = &main_tram[0];
	m72_tb_vram = &main_tram[40];
	bordercolor = 0x52U;

	/* Sprite mode 5 */
	m72_config = 0x54U;

}

void InitUI() {

	cursor_sprite.xpos   = TILE_WIDTH * 11;
	cursor_sprite.ypos   = m72_ypos;
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

void MoveSelectionLeft(u8 player) {

	switch(selection_mode[player]) {

		case SELECT_MOVE:
			if (cursor_sprite.xpos == TILE_WIDTH * 2) {
				// todo: try to scroll left
			} else {
				cursor_sprite.xpos -= TILE_WIDTH;
			}
			ShowCursorContextMenu(player);
			break;

		case SELECT_BUILD:
			if (build_selection[player] == 0) {
				build_selection[player] = 3;
			} else {
				build_selection[player]--;
			}
			ShowBuildMenu(player);
			break;

		case SELECT_UPGRADE:
			break;
	}
}

void MoveSelectionRight(u8 player) {

	switch(selection_mode[player]) {

		case SELECT_MOVE:
			if (cursor_sprite.xpos == TILE_WIDTH * SCREEN_TILES_H) {
				// todo: try to scroll right
			} else {
				cursor_sprite.xpos += TILE_WIDTH;
			}
			ShowCursorContextMenu(player);
			break;

		case SELECT_BUILD:
			if (build_selection[player] == 3) {
				build_selection[player] = 0;
			} else {
				build_selection[player]++;
			}
			ShowBuildMenu(player);
			break;

		case SELECT_UPGRADE:
			break;
	}
}

void InputThink() {
	int buttons[] = { ReadJoypad(0), ReadJoypad(1) };

	// Press any button to join the game
	if (players_joined_game & 1 == 0) {
		if (buttons[0] != 0) {
			players_joined_game |= 1;
			cursor_actioned[0] = buttons[0];
			return;
		}
	}
	if (players_joined_game & 2 == 0) {
		if (buttons[1] != 0) {
			players_joined_game |= 2;
			cursor_actioned[1] = buttons[1];
			return;
		}
	}

	// Gameplay input
	for (u8 i = 0; i < 2; i++) {
		if(buttons[i] & BTN_LEFT) {
			if (!(cursor_actioned[i] & BTN_LEFT)){
				cursor_actioned[i] |= BTN_LEFT;
				MoveSelectionLeft(i);
			}
		}
		else if(buttons[i] & BTN_RIGHT) {
			if (!(cursor_actioned[i] & BTN_RIGHT)){
				cursor_actioned[i] |= BTN_RIGHT;
				MoveSelectionRight(0);
			}
		}
		else if(buttons[i] & BTN_UP) {
			if (selection_mode[i] == SELECT_MOVE && !(cursor_actioned[i] & BTN_UP)){
				cursor_actioned[i] |= BTN_UP;
				cursor_sprite.ypos += BuildingHeightAtLocation(cursor_sprite.xpos, cursor_sprite.ypos - 1);
			}
		}
		else if(buttons[i] & BTN_DOWN) {
			if (selection_mode[i] == SELECT_MOVE && !(cursor_actioned[i] & BTN_DOWN)){
				cursor_actioned[i] |= BTN_DOWN;
				cursor_sprite.ypos -= BuildingHeightAtLocation(cursor_sprite.xpos, cursor_sprite.ypos);
			}
		}
		else if(buttons[i] & BTN_A) {
			if (selection_mode[i] == SELECT_MOVE && !(cursor_actioned[i] & BTN_A)){
				cursor_actioned[i] |= BTN_A;
				if (BuildingHeightAtLocation(cursor_sprite.xpos, cursor_sprite.ypos) == 0) {
					selection_mode[i] = SELECT_BUILD;
					ShowBuildMenu(i);
				} else {
					// upgrade
				}
			}
		}
		else if(buttons[i] & BTN_B) {
			if (!(cursor_actioned[i] & BTN_B)){
				cursor_actioned[i] |= BTN_B;
				selection_mode[i] = SELECT_MOVE;
				ShowCursorContextMenu(i);
			}
		}
		else {
			cursor_actioned[i] = 0;
		}
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
