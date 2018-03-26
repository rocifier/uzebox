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
 * Horizontal scrolling
 * Cursor movement snap to buildings
 * Waves of enemies
 * Auto-firing bullets
 * Tower upgrades
 * Intro Screen
 * Music
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
static const unsigned char debug_sprite_data[] PROGMEM = {
 0b11111111U,0b11111111U
};

static int cursor_actioned[] = { 0, 0 }; // large bitmask: we can only press each direction once before we left go of all direction buttons

/* Data */
static sprite_t cursor_sprite;
static sprite_t debug_sprite;
static bullet_t main_bullets[50];
static u8 main_vram[BG_HEIGHT][BG_WIDTH];
static u8 main_tram[120];
static u8 players_joined_game = 0;

static u8 build_selection[] = { BUILD_TOWER, BUILD_TOWER };
static u8 selection_mode[] = { SELECT_MOVE, SELECT_MOVE };
static int player_money[] = { 990, 780 };

/* ACII */
static const unsigned char txt_money[] PROGMEM = "P1 $                             P2 $   ";
static const unsigned char txt_build[] PROGMEM = "P1+  TOWER  CHIMNEY  OFFICE  FRAME  $   P2+  TOWER  CHIMNEY  OFFICE  FRAME  $   ";
static const unsigned char txt_upgrd[] PROGMEM = "P1+  TOWER  CHIMNEY  OFFICE  FRAME  $   P2+  TOWER  CHIMNEY  OFFICE  FRAME  $   ";
static const unsigned char txt_start[] PROGMEM = "    P1 PRESS ANY BUTTON TO JOIN GAME        P2 PRESS ANY BUTTON TO JOIN GAME    ";
static const unsigned char txt_block[] PROGMEM = "       NO SPACE TO PLACE BUILDING              NO SPACE TO PLACE BUILDING       ";
static const unsigned char txt_inval[] PROGMEM = "            INVALID PLACEMENT                       INVALID PLACEMENT           ";
static const unsigned char txt_nocas[] PROGMEM = "    NOT ENOUGH MONEY TO BUY BUILDING        NOT ENOUGH MONEY TO BUY BUILDING    ";


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

u8 WorldXToScreenX(u8 x) {
	return (x + BORDER_SIZE) * 8; // todo: hscroll
}

u8 ScreenXToWorldX(u8 x) {
	return x / 8 - BORDER_SIZE; // todo: hscroll
}

u8 ScreenYToWorldY(u8 y) {
	return ((FRAME_LINES - (int)y) + m72_ypos) / TILE_HEIGHT + 3;
}

u8 WorldYToScreenY(u8 y) {
	return -TILE_HEIGHT * y + FRAME_LINES + m72_ypos + 3 * TILE_HEIGHT;
}

bool TileNotBuildable(u8 world_x, u8 world_y) {
	return (main_vram[world_y][world_x] >= TILE_CHIMNEY_STACK_A && main_vram[world_y][world_x] <= TILE_CHIMNEY_STACK3_C) ||
		(main_vram[world_y][world_x] == TILE_TOWER_ROOFTIP_A);
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
	itoa(player_money[0], (char*)&buffer, 10);
	main_tram[4] = ascii2petscii(buffer[0]);
	main_tram[5] = ascii2petscii(buffer[1]);
	main_tram[6] = ascii2petscii(buffer[2]);
	itoa(player_money[1], (char*)&buffer, 10);
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

void ShowNotEnoughMoney(u8 player) {
	for (u8 i = TEXT_ROW_SIZE * player; i < TEXT_ROW_SIZE + TEXT_ROW_SIZE * player; i++){
		u8 ascii = pgm_read_byte(&(txt_nocas[i]));
		main_tram[i + TEXT_ROW_SIZE] = ascii2petscii(ascii);
	}
}

void ShowNoSpaceForBuilding(u8 player) {
	for (u8 i = TEXT_ROW_SIZE * player; i < TEXT_ROW_SIZE + TEXT_ROW_SIZE * player; i++){
		u8 ascii = pgm_read_byte(&(txt_block[i]));
		main_tram[i + TEXT_ROW_SIZE] = ascii2petscii(ascii);
	}
}

void ShowInvalidPlaceForBuilding(u8 player) {
	for (u8 i = TEXT_ROW_SIZE * player; i < TEXT_ROW_SIZE + TEXT_ROW_SIZE * player; i++){
		u8 ascii = pgm_read_byte(&(txt_inval[i]));
		main_tram[i + TEXT_ROW_SIZE] = ascii2petscii(ascii);
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
	m72_ypos = (GROUND_Y + 4) * TILE_HEIGHT;

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

	debug_sprite.xpos   = TILE_WIDTH * 7;
	debug_sprite.ypos   = 96;
	debug_sprite.off    = ((u16)&debug_sprite_data) & SPRITE_UNMIRRORED;
	debug_sprite.height = 1U;
	debug_sprite.col1   = 0x10U;
	debug_sprite.col2   = 0x40U;
	debug_sprite.col3   = 0x70U;
	sprites[0] = &debug_sprite;

}

/***********************************************
 *                 THE BRAINS
 **********************************************/

// Get height of whatever building is at (x,y) in pixels.
// Returns 0 if no building is at this location.
u8 BuildingHeightAtLocation(u8 screen_x, u8 screen_y) {

	u8 x = ScreenXToWorldX(screen_x);
	u8 y = ScreenYToWorldY(screen_y);
	u8 buildingAtLocation = main_vram[y][x];

	switch(buildingAtLocation) {
		case TILE_SKY_A:
			return 0;
		case TILE_SOLID_A:
			if (y >= (BG_HEIGHT - GROUND_Y)) {
				return 0;
			} else {
				// tower or tier 3 chimney C are both 3 tiles
				return 3 * TILE_HEIGHT;
			}
		case TILE_TOWER_WINDOW_A:
			return 3 * TILE_HEIGHT;
		case TILE_TOWER_ROOF_A:
			return 3 * TILE_HEIGHT;
		case TILE_TOWER_ROOFTIP_A:
			return 1 * TILE_HEIGHT;
		case TILE_FRAME_NW_A:
			return 2 * TILE_HEIGHT;
		case TILE_FRAME_NE_A:
			return 2 * TILE_HEIGHT;
		case TILE_FRAME_SW_A:
			return 2 * TILE_HEIGHT;
		case TILE_FRAME_SE_A:
			return 2 * TILE_HEIGHT;
		case TILE_OFFICE_WINDOW_A:
			return 1 * TILE_HEIGHT;
		case TILE_OFFICE_DOOR_A:
			return 1 * TILE_HEIGHT;
		case TILE_SOLID_B:
			return 2 * TILE_HEIGHT;
		case TILE_SOLID_C:
			return 3 * TILE_HEIGHT;
		case TILE_CHIMNEY_STACK_A:
			return 2 * TILE_HEIGHT;
		case TILE_CHIMNEY_STACK1_B:
			return 2 * TILE_HEIGHT;
		case TILE_CHIMNEY_STACK1_C:
			return 3 * TILE_HEIGHT;
		case TILE_CHIMNEY_STACK2_C:
			return 3 * TILE_HEIGHT;
		case TILE_CHIMNEY_STACK3_C:
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

//
// Try to place a tower at a cursor's position on screen.
// A tower might have a spacial conflict,
// or be too expensive for the player.
//
void TryPlaceBuilding(u8 player, u8 tower_type, u8 screen_x, u8 screen_y) {

	// First check the player has enough money
	if (tower_type == BUILD_TOWER && player_money[player] < TOWER_COST) {
		ShowNotEnoughMoney(player);
		return;
	}
	if (tower_type == BUILD_CHIMNEY && player_money[player] < CHIMNEY_COST) {
		ShowNotEnoughMoney(player);
		return;
	}
	if (tower_type == BUILD_OFFICE && player_money[player] < OFFICE_COST) {
		ShowNotEnoughMoney(player);
		return;
	}
	if (tower_type == BUILD_FRAME && player_money[player] < FRAME_COST) {
		ShowNotEnoughMoney(player);
		return;
	}

	// Next check there are sky tiles where building must go
	u8 x = ScreenXToWorldX(screen_x);
	u8 y = ScreenYToWorldY(screen_y);

	switch(tower_type) {
		case BUILD_TOWER:
			if ((main_vram[y][x] > 0 && main_vram[y][x] != TILE_TOWER_ROOF_A) ||
				 main_vram[y-1][x] > 0 ||
				 main_vram[y-2][x] > 0) {
					ShowNoSpaceForBuilding(player);
					return;
			}
			break;
		case BUILD_CHIMNEY:
			if ((main_vram[y][x] > 0) ||
				 main_vram[y][x+1] > 0 ||
				 main_vram[y-1][x+1] > 0 ||
				 main_vram[y-1][x] > 0) {
					ShowNoSpaceForBuilding(player);
					return;
			}
			break;
	}

	// Next check if this is a valid support location for the building
	// TODO: building too tall
	switch(tower_type) {
		case BUILD_CHIMNEY:
			if (TileNotBuildable(x, y+1)) {
				ShowInvalidPlaceForBuilding(player);
				return;
			}
			if (TileNotBuildable(x+1, y+1)) {
				ShowInvalidPlaceForBuilding(player);
				return;
			}
			break;

		case BUILD_TOWER:
			if (TileNotBuildable(x, y+1)) {
				ShowInvalidPlaceForBuilding(player);
				return;
			}
			break;
	}

	// No errors found, so sell the building to the player!
	switch(tower_type) {
		case BUILD_TOWER:
			main_vram[y][x] = TILE_SOLID_A;
			main_vram[y-1][x] = TILE_TOWER_WINDOW_A;
			main_vram[y-2][x] = TILE_TOWER_ROOF_A;

			// if we stacked towers, convert the roof below to a solid tile
			// and remove the roof tip if there was one there.
			if (main_vram[y+1][x] == TILE_TOWER_ROOF_A) {
				main_vram[y+1][x] = TILE_SOLID_A;
				if (main_vram[y+1][x-1] == TILE_TOWER_ROOFTIP_A) {
					main_vram[y+1][x-1] = TILE_SKY_A;
				}
			}

			// optional: render roof tip if we are able to
			if (x > 0 && main_vram[y-2][x-1] == 0) {
				 main_vram[y-2][x-1] = TILE_TOWER_ROOFTIP_A;
			}
			
			player_money[player] -= TOWER_COST;
			break;

		case BUILD_CHIMNEY:
			main_vram[y][x] = TILE_SOLID_B;
			main_vram[y][x+1] = TILE_SOLID_B;
			main_vram[y-1][x] = TILE_CHIMNEY_STACK_A;

			player_money[player] -= CHIMNEY_COST;
			break;
	}

	// Make sure to display any updated deductions to the relevant player
	RefreshPlayerMoney();

}

void InputThink() {
	int buttons[] = { ReadJoypad(0), ReadJoypad(1) };

	// Press any button to join the game
	if ((players_joined_game & 1) == 0) {
		if (buttons[0] != 0) {
			players_joined_game |= 1;
			cursor_actioned[0] = buttons[0];
			ShowCursorContextMenu(0);
			return;
		}
	}
	if ((players_joined_game & 2) == 0) {
		if (buttons[1] != 0) {
			players_joined_game |= 2;
			cursor_actioned[1] = buttons[1];
			ShowCursorContextMenu(1);
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
				cursor_sprite.ypos += BuildingHeightAtLocation(cursor_sprite.xpos, JUST_ABOVE(cursor_sprite.ypos));
			}
		}
		else if(buttons[i] & BTN_DOWN) {
			if (selection_mode[i] == SELECT_MOVE && !(cursor_actioned[i] & BTN_DOWN)){
				cursor_actioned[i] |= BTN_DOWN;
				cursor_sprite.ypos -= BuildingHeightAtLocation(cursor_sprite.xpos, JUST_BELOW(cursor_sprite.ypos));
			}
		}
		else if(buttons[i] & BTN_A) {
			if (!(cursor_actioned[i] & BTN_A)) {
				cursor_actioned[i] |= BTN_A;

				if (selection_mode[i] == SELECT_BUILD){

					TryPlaceBuilding(i, build_selection[i], cursor_sprite.xpos, JUST_ABOVE(cursor_sprite.ypos));

				} else if (selection_mode[i] == SELECT_MOVE){
					
					if (BuildingHeightAtLocation(cursor_sprite.xpos, JUST_ABOVE(cursor_sprite.ypos)) == 0) {
						selection_mode[i] = SELECT_BUILD;
						ShowBuildMenu(i);
					} else {
						// upgrade
					}

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
