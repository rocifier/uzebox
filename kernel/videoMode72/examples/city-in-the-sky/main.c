#include <stdbool.h>
#include <avr/io.h>
#include <stdlib.h>
#include <avr/pgmspace.h>
#include <uzebox.h>
#include <videoMode72.h>
#include "globals.h"
#include "sprites.h"
#include "enemies.h"
#include "waves.h"

/***********************************************
 *                    TODO
 **********************************************/
/*
 * Waves of enemies
 * Auto-firing bullets
 * Y scrollig? and tower height limits
 * Tower upgrades
 * Intro Screen
 * Music
 * 
 */



/***********************************************
 *                    DATA
 **********************************************/

int cursor_actioned[] = { 0, 0 }; // large bitmask: we can only press each direction once before we left go of all direction buttons

sprite_t cursor_sprite;
sprite_t debug_sprite;
bullet_t main_bullets[MAX_BULLET_COUNT];
u8 main_vram[BG_HEIGHT][BG_WIDTH];
u8 main_tram[120];
u8 players_joined_game = 0;
u16 x_offset = 0;
bool is_scrolling = false;
bool scroll_direction_is_left = false;

u8 build_selection[] = { BUILD_TOWER, BUILD_TOWER };
u8 selection_mode[] = { SELECT_MOVE, SELECT_MOVE };
int player_money[] = { 0, 0 };

u8 current_wave = 0;
u8 wave_countdown = 0; // 240 = 8 seconds between each wave
u8 spawn_countdown = 0; // 60 = 2 seconds between each enemy
u8 wave_enemies_spawned = 0; // number of enemies that have spawned this wave
u8 lives = 0;

static const unsigned char txt_money[] PROGMEM = "P1 $            LIVES:           P2 $   ";
static const unsigned char txt_gameo[] PROGMEM = "                GAME OVER               ";
static const unsigned char txt_waves[] PROGMEM = "                 WAVE                   ";
static const unsigned char txt_wonit[] PROGMEM = "CONGRATULATIONS YOU HAVE BEATEN THE GAME";
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
	return (x + BORDER_SIZE) * TILE_WIDTH - x_offset;
}

u8 ScreenXToWorldX(u8 x) {
	return (x + x_offset) / TILE_WIDTH - BORDER_SIZE;
}

u8 ScreenYToWorldY(u8 y) {
	return ((FRAME_LINES - (int)y) + m72_ypos) / TILE_HEIGHT + 3;
}

u8 WorldYToScreenY(u8 y) {
	return -TILE_HEIGHT * y + FRAME_LINES + m72_ypos + 3 * TILE_HEIGHT;
}

bool TileNotBuildable(u8 world_x, u8 world_y) {
	return (main_vram[world_y][world_x] >= TILE_CHIMNEY_STACK_A && main_vram[world_y][world_x] <= TILE_CHIMNEY_STACK3_C) ||
		(main_vram[world_y][world_x] == TILE_TOWER_ROOFTIP_A) || main_vram[world_y][world_x] == TILE_SKY_A;
}

/***********************************************
 *                     MENUS
 **********************************************/
void RefreshTopBar() {

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

	// replace lives
	itoa(lives, (char*)&buffer, 10);
	main_tram[22] = ascii2petscii(buffer[0]);
	main_tram[23] = ascii2petscii(buffer[1]);

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
	// show wave number
	for (u8 i = TEXT_ROW_SIZE * player; i < TEXT_ROW_SIZE + TEXT_ROW_SIZE * player; i++){
		u8 ascii = pgm_read_byte(&(txt_waves[i]));
		main_tram[i + TEXT_ROW_SIZE] = ascii2petscii(ascii);
	}
	char buffer[] = "    ";
	itoa((int)current_wave + 1, (char*)&buffer, 10);
	main_tram[22 + TEXT_ROW_SIZE * player + TEXT_ROW_SIZE] = ascii2petscii(buffer[0]);
	main_tram[23 + TEXT_ROW_SIZE * player + TEXT_ROW_SIZE] = ascii2petscii(buffer[1]);

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
	for (u8 y = 0; y < GROUND_Y; y++) {
		for (u8 x = 0; x < BG_WIDTH; x++) {
			main_vram[y][x] = 0U;
		}
	}
	for (u8 y = GROUND_Y; y < BG_HEIGHT; y++) {
		for (u8 x = 0; x < BG_WIDTH; x++) {
			main_vram[y][x] = 1U;
		}
	}
}

void InitMode72() {

	/* Camera at ground level */
	m72_ypos = 0;

	/* VRAM start offsets */
	u8 i = 0U;
	for (i = 0U; i < BG_HEIGHT; i++){
		m72_rowoff[i] = (u16)(&main_vram[i][0]);
	}

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
	cursor_sprite.ypos   = WorldYToScreenY(GROUND_Y);
	cursor_sprite.off    = ((u16)&cursor_sprite_data) & SPRITE_UNMIRRORED;
	cursor_sprite.height = 16U;
	cursor_sprite.col1   = 0x13U;
	cursor_sprite.col2   = 0x47U;
	cursor_sprite.col3   = 0x7FU;
	sprites[SPRITE_INDEX_UI] = &cursor_sprite;

	debug_sprite.xpos   = TILE_WIDTH * 7;
	debug_sprite.ypos   = WorldYToScreenY(GROUND_Y - 1);
	debug_sprite.off    = ((u16)&debug_sprite_data) & SPRITE_UNMIRRORED;
	debug_sprite.height = 1;
	debug_sprite.col1   = 0x10U;
	debug_sprite.col2   = 0x40U;
	debug_sprite.col3   = 0x70U;
	sprites[0] = &debug_sprite;

}

void ResetGame() {
	x_offset = 0;
	is_scrolling = false;

	player_money[0] = 990;
	player_money[1] = 780;
	lives = 15;
	RefreshTopBar();

	current_wave = 0;
	wave_countdown = TIME_BETWEEN_WAVES; // 240 = 8 seconds between each wave
	spawn_countdown = TIME_BETWEEN_ENEMIES; // 60 = 2 seconds between each enemy
	wave_enemies_spawned = 0; // number of enemies that have spawned this wave

	players_joined_game = 0;
	ShowPressAKeyToJoin(0);
	ShowPressAKeyToJoin(1);

	for (u8 i = 0; i < MAX_BULLET_COUNT; i++) {
		main_bullets[i].height = 0;
	}
	bullets[0] = &main_bullets[0];
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
			if (y >= GROUND_Y) {
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

bool IsOpenAirTile(u8 x, u8 y) {
	return (main_vram[y][x] == TILE_SKY_A || main_vram[y][x] == TILE_TOWER_ROOFTIP_A);
}

bool IsTopOfBuilding(u8 x, u8 y) {
	return (y >= GROUND_Y ||
			main_vram[y][x] == TILE_TOWER_ROOF_A ||
			main_vram[y][x] == TILE_FRAME_NW_A ||
			main_vram[y][x] == TILE_FRAME_NE_A ||
			main_vram[y][x] == TILE_OFFICE_WINDOW_A ||
			main_vram[y][x] == TILE_OFFICE_DOOR_A ||
			main_vram[y][x] == TILE_CHIMNEY_STACK_A ||
			main_vram[y][x] == TILE_CHIMNEY_STACK1_B ||
			main_vram[y][x] == TILE_CHIMNEY_STACK1_C ||
			main_vram[y][x] == TILE_CHIMNEY_STACK2_C ||
			main_vram[y][x] == TILE_CHIMNEY_STACK3_C);
}

void MoveSelectionLeft(u8 player) {

	switch(selection_mode[player]) {

		case SELECT_MOVE:
			if (cursor_sprite.xpos == TILE_WIDTH * 2) {
				if (!is_scrolling && x_offset >= TILE_WIDTH) {
					is_scrolling = true;
					scroll_direction_is_left = true;
				}

			} else {
				cursor_sprite.xpos -= TILE_WIDTH;
				// let cursor "fall down" until it hits a building or the ground
				while(cursor_sprite.ypos > 0 && !IsTopOfBuilding(ScreenXToWorldX(cursor_sprite.xpos), ScreenYToWorldY(JUST_BELOW(cursor_sprite.ypos)))) {
					cursor_sprite.ypos -= TILE_HEIGHT;
				}
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
				if (!is_scrolling && x_offset < (BG_WIDTH - SCREEN_TILES_H - 1) * TILE_WIDTH) {
					is_scrolling = true;
					scroll_direction_is_left = false;
				}

			} else {
				cursor_sprite.xpos += TILE_WIDTH;
				// let cursor "fall down" until it hits a building or the ground
				while(cursor_sprite.ypos > 0 && !IsTopOfBuilding(ScreenXToWorldX(cursor_sprite.xpos), ScreenYToWorldY(JUST_BELOW(cursor_sprite.ypos)))) {
					cursor_sprite.ypos -= TILE_HEIGHT;
				}
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
			if (!IsOpenAirTile(x, y) ||
				!IsOpenAirTile(x, y - 1) ||
				!IsOpenAirTile(x, y - 2)) {
					ShowNoSpaceForBuilding(player);
					return;
			}
			break;

		case BUILD_FRAME:
		case BUILD_CHIMNEY:
			if (!IsOpenAirTile(x, y) ||
				!IsOpenAirTile(x + 1, y) ||
				!IsOpenAirTile(x + 1, y - 1) ||
				!IsOpenAirTile(x, y - 1)) {
					ShowNoSpaceForBuilding(player);
					return;
			}
			break;

		case BUILD_OFFICE:
			if (!IsOpenAirTile(x, y) ||
				!IsOpenAirTile(x + 1, y) ||
				!IsOpenAirTile(x + 2, y)) {
					ShowNoSpaceForBuilding(player);
					return;
			}
			break;
	}

	// Next check if this is a valid support location for the building
	// TODO: building too tall
	switch(tower_type) {

		case BUILD_FRAME:
		case BUILD_CHIMNEY:
			if (TileNotBuildable(x, y+1) || TileNotBuildable(x+1, y+1)) {
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

		case BUILD_OFFICE:
			if (TileNotBuildable(x, y+1) || TileNotBuildable(x+1, y+1) || TileNotBuildable(x+2, y+1)) {
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

		case BUILD_OFFICE:
			main_vram[y][x] = TILE_OFFICE_WINDOW_A;
			main_vram[y][x+1] = TILE_OFFICE_WINDOW_A;
			main_vram[y][x+2] = TILE_OFFICE_DOOR_A;

			player_money[player] -= OFFICE_COST;
			break;

		case BUILD_FRAME:
			main_vram[y][x] = TILE_FRAME_SW_A;
			main_vram[y][x+1] = TILE_FRAME_SE_A;
			main_vram[y-1][x] = TILE_FRAME_NW_A;
			main_vram[y-1][x+1] = TILE_FRAME_NE_A;

			player_money[player] -= FRAME_COST;
			break;
	}

	// Make sure to display any updated deductions to the relevant player
	RefreshTopBar();

}



void GameOverCheck() {

	if (lives == 0) {
		ResetGame();

		// display game over message in place of money
		for (u8 i = 0; i < TEXT_ROW_SIZE; i++){
			u8 ascii = pgm_read_byte(&(txt_gameo[i]));
			main_tram[i] = ascii2petscii(ascii);
		}

	} else if (current_wave == LEN(waves)) {
		ResetGame();

		// display you win message in place of money
		for (u8 i = 0; i < TEXT_ROW_SIZE; i++){
			u8 ascii = pgm_read_byte(&(txt_wonit[i]));
			main_tram[i] = ascii2petscii(ascii);
		}
	}
}

void DestroyEnemyAndCheckForNextWave(u8 enemy_index) {
	enemy[enemy_index].health = 0;
	enemy[enemy_index].sprite.height = 0;
	enemy[enemy_index].x = 0;

	// check if all enemies have been destroyed
	bool all_dead = true;
	for(u8 i = 0; i < MAX_ENEMY_COUNT; i++) {
		if (enemy[i].health > 0) {
			all_dead = false;
			break;
		}
	}
	if (all_dead) {
		u8 enemies_this_wave = pgm_read_byte(&waves[current_wave][0]);

		if (wave_enemies_spawned == enemies_this_wave) {
			current_wave++;
			wave_countdown = TIME_BETWEEN_WAVES;
			spawn_countdown = TIME_BETWEEN_ENEMIES;
			wave_enemies_spawned = 0;

			// display current wave
			if (selection_mode[0] == SELECT_MOVE && (players_joined_game & 1)) {
				ShowCursorContextMenu(0);
			}
			if (selection_mode[1] == SELECT_MOVE && (players_joined_game & 2)) {
				ShowCursorContextMenu(1);
			}

			GameOverCheck();
		}
	}
}

void WaveThink() {
	if (wave_countdown == 0) { // wave counter is reset after last enemy is destroyed this wave
		spawn_countdown--;
		if (spawn_countdown == 0) {
			TryToSpawnEnemy(); // enemies.c
			spawn_countdown = TIME_BETWEEN_ENEMIES;
		}
	} else {
		wave_countdown--;
	}

			player_money[0] = enemy[16].health;
			RefreshTopBar();
			
	for (u8 i = 0; i < MAX_ENEMY_COUNT; i++) {
		if (enemy[i].health > 0) {

			player_money[0] = i;
			RefreshTopBar();

			// velocity
			enemy[i].speed_lag_count++;
			if (enemy[i].speed_lag_count == enemy[i].speed_lag) {
				enemy[i].x++;
				enemy[i].speed_lag_count = 0;
			}

			// goal check
			if (enemy[i].x >= (BG_WIDTH - 1) * TILE_WIDTH) {
				DestroyEnemyAndCheckForNextWave(i); // enemies.c
				lives--;
				RefreshTopBar();
				break;
			}

			// animation
			if (enemy[i].anim_frame_count > 1) {
				enemy[i].anim_lag_count++;
				if (enemy[i].anim_lag_count == enemy[i].anim_lag) {
					enemy[i].anim_frame++;
					if (enemy[i].anim_frame >= enemy[i].anim_frame_count) {
						enemy[i].anim_frame = 0;
					}
					enemy[i].sprite.off = enemy[i].original_off + (enemy[i].anim_frame * 2 * enemy[i].sprite.height);
					enemy[i].anim_lag_count = 0;
				}
			}

			// update sprite screen position
			enemy[i].sprite.xpos = enemy[i].x - x_offset;
			enemy[i].sprite.ypos = enemy[i].y; // todo: incorporate y scrolling
		}
	}
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

void ScrollThink() {
	if (is_scrolling) {
		if (scroll_direction_is_left) {
			x_offset -= 2;
		} else {
			x_offset += 2;
		}
		if (x_offset % TILE_WIDTH == 0) {
			is_scrolling = false;
		}
	}
	for (u8 i = 0; i < BG_HEIGHT; i++) {
		m72_rowoff[i] = (u16)&main_vram[i][(x_offset >> 3)] + ((x_offset & 7) << 12);
	}
}

/***********************************************
 *                 ENTRY POINT
 **********************************************/

int main(void){

	ResetGame();
	InitMode72();
	InitUI();
	InitEnemies();
	ClearDefaultBG();

	while(true){
		InputThink();

		if (players_joined_game) {
			WaveThink();
			ScrollThink();
		}

		WaitVsync(1);
	}

}
