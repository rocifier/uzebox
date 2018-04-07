#pragma once
#include <uzebox.h>
#include <videoMode72.h>

#define MAX_ENEMY_COUNT 24
#define ENEMY_ZONE_TOP 0
#define ENEMY_ZONE_MID 1
#define ENEMY_ZONE_GROUND 2

#define NO_FREE_SLOTS 255

typedef struct {
    // sprite is intentionally first so that a sprite.next pointer refers to both a sprite_t and an enemy_t
    sprite_t sprite;

    // authoritative position not adjusted for scroll offsets
    u8 x;
    u8 y;

    u16 health;
    u8 type;
    u16 original_off;
    u8 speed_lag;
    u8 speed_lag_count;
    u8 anim_lag;
    u8 anim_lag_count;
    u8 anim_frame;
    u8 anim_frame_count;
} enemy_t;

// fixed size list in memory. enemy zones for rendering Y:
// 0-7 top zone
// 8-15 mid zone
// 16-23 ground zone
extern enemy_t enemy[];

// function declarations
void InitEnemies();
void TryToSpawnEnemy();
void DestroyEnemy(u8 index);