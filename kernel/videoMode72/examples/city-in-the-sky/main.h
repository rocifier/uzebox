
#define JUST_ABOVE(Y) (Y) + 5
#define JUST_BELOW(Y) (Y) - 1
#define ENEMY_IS_ALIVE(I) enemy_sprite[I].height > 0

/* Background */
#define BG_WIDTH 32
#define BG_HEIGHT 32
#define BORDER_SIZE 2 // "no-bg" border on left and right
#define GROUND_Y 4
#define DEFAULT_GROUND_SCREEN_LEVEL (GROUND_Y + 4) * TILE_HEIGHT

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
#define MAX_ENEMY_COUNT 40

typedef struct {
    int health;
    u8 type;
    sprite_t sprite;
    u16 original_off;
    u8 speed_lag;
    u8 speed_lag_count;
    u8 anim_lag;
    u8 anim_lag_count;
    u8 anim_frame;
    u8 anim_frame_count;
} enemy_t;