#include <uzebox.h>
#include <videoMode72.h>
#define MAX_ENEMY_COUNT 40

typedef struct {
    int health;
    u8 type;
    u8 x; // authoritative position not adjusted for scroll offsets
    u8 y;
    sprite_t sprite;
    u16 original_off;
    u8 speed_lag;
    u8 speed_lag_count;
    u8 anim_lag;
    u8 anim_lag_count;
    u8 anim_frame;
    u8 anim_frame_count;
} enemy_t;

static enemy_t enemy[MAX_ENEMY_COUNT];
