#pragma once
#include <uzebox.h>

#define JUST_ABOVE(Y) (Y) + 5
#define JUST_BELOW(Y) (Y) - 1
#define ENEMY_IS_ALIVE(I) enemy_sprite[I].height > 0
#define LEN(arr) ((int) (sizeof (arr) / sizeof (arr)[0]))

/* Background */
#define BG_WIDTH 32
#define BG_HEIGHT SCREEN_TILES_V
#define BORDER_SIZE 2 // "no-bg" border on left and right
#define GROUND_Y 21

/* Tiles */
#define TILE_SKY_A 0
#define TILE_SOLID_A 1
#define TILE_TOWER_WINDOW_A 2
#define TILE_TOWER_ROOF_A 3
#define TILE_TOWER_ROOFTIP_A 4
#define TILE_FRAME_NW_A 5
#define TILE_FRAME_NE_A 6
#define TILE_FRAME_SW_A 7
#define TILE_FRAME_SE_A 8
#define TILE_OFFICE_WINDOW_A 9
#define TILE_OFFICE_DOOR_A 10
#define TILE_SOLID_B 11
#define TILE_SOLID_C 12
#define TILE_CHIMNEY_STACK_A 13
#define TILE_CHIMNEY_STACK1_B 14
#define TILE_CHIMNEY_STACK1_C 15
#define TILE_CHIMNEY_STACK2_C 16
#define TILE_CHIMNEY_STACK3_C 17

/* UI */
#define TEXT_ROW_SIZE 40
#define TEXT_TOP_HEIGHT 11
#define TEXT_BOTTOM_HEIGHT 18
#define SPRITE_UNMIRRORED 0x7FFFU
#define SPRITE_MIRRORED 0xFFFFU
#define SPRITE_INDEX_UI 1
#define SPRITE_INDEX_ENEMIES 2

#define BUILD_TOWER 0
#define BUILD_CHIMNEY 1
#define BUILD_OFFICE 2
#define BUILD_FRAME 3

#define SELECT_MOVE 0
#define SELECT_BUILD 1
#define SELECT_UPGRADE 2

/* Pricing */
#define TOWER_COST 100
#define CHIMNEY_COST 170
#define OFFICE_COST 230
#define FRAME_COST 300

/* Enemies */
#define TIME_BETWEEN_WAVES 155
#define TIME_BETWEEN_ENEMIES 150
#define MAX_BULLET_COUNT 64
#define ENEMY_ROW_

/* Global variables */
extern u8 current_wave;
extern u8 wave_countdown;
extern u8 spawn_countdown;
extern u8 wave_enemies_spawned;
extern int player_money[];

/* UTILS */

u8 WorldXToScreenX(u8 x);
u8 ScreenXToWorldX(u8 x);
u8 ScreenYToWorldY(u8 y);
u8 WorldYToScreenY(u8 y);
void RefreshTopBar();