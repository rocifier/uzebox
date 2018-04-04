#include <stdlib.h>
#include <avr/pgmspace.h>
#include "enemies.h"
#include "globals.h"
#include "waves.h"
#include "sprites.h"

void InitEnemies() {
    // enemy zones for rendering Y:
    // 0-7 top zone
    // 8-15 mid zone
    // 16-23 ground zone
    u8 i = 0;
    for (; i < MAX_ENEMY_COUNT; i++) {
		enemy[i].type = 0;
		enemy[i].health = 0;
		enemy[i].sprite.height = 0;
		enemy[i].sprite.off = 0;
		enemy[i].sprite.xpos = 0;
		enemy[i].sprite.ypos = WorldYToScreenY(0);
    }
    // link higher zones to render the next zone down
    for (i = 0; i < 8; i++) {
		enemy[i].sprite.next = &enemy[i + 8].sprite;
		enemy[i + 8].sprite.next = &enemy[i + 16].sprite;
		enemy[i + 16].sprite.next = NULL;
        sprites[SPRITE_INDEX_ENEMIES + i] = &enemy[i].sprite;
    }
}

u8 GetNextFreeSlot(u8 zone) {
	for (u8 i = zone * 8; i < zone * 8 + 8; i++) {
		if (enemy[i].health == 0) {
			return i;
		}
	}
    return NO_FREE_SLOTS;
}

void TryToSpawnEnemy() {
	u8 index_to_spawn = 0;
	u8 enemy_counter = 0;
	u8 enemies_this_wave = pgm_read_byte(&waves[current_wave][0]);

	// have we already spawned all the enemies this wave?
	if(wave_enemies_spawned >= enemies_this_wave) {
		return;
	}

	// determine next enemy type to spawn
	for (u8 i = 1; i < 15; i++) {

		u8 this_enemy_count = pgm_read_byte(&waves[current_wave][i]);
		enemy_counter += this_enemy_count;

		if (wave_enemies_spawned < enemy_counter) {
			index_to_spawn = i;
			break;
		}
	}
	if (index_to_spawn == 0) {
		return; // shouldn't happen, this would indicate no enemies defined this wave
	}

    // determine new enemy zone
    u8 enemy_zone = 0;
    if (index_to_spawn >= 1 && index_to_spawn < 6) {
        enemy_zone = ENEMY_ZONE_GROUND;
    } else if (index_to_spawn >= 6 && index_to_spawn < 11) {
        enemy_zone = ENEMY_ZONE_MID;
    } else if (index_to_spawn >= 11 && index_to_spawn < 16) {
        enemy_zone = ENEMY_ZONE_TOP;
    }

	// determine a free enemy slot to regenerate
	u8 new_enemy_index = GetNextFreeSlot(enemy_zone);
	if (new_enemy_index == NO_FREE_SLOTS) {
        // shouldn't happen, no enemy slots available
        // but if it does just continue waiting cycles
        // until enemies are destroyed, freeing up slots
		return;
	}

	switch(index_to_spawn) {
		case 1: //	Enemy walker 1
			enemy[new_enemy_index].health = 5;
			enemy[new_enemy_index].speed_lag = 5;
			enemy[new_enemy_index].anim_lag = 8;
			enemy[new_enemy_index].x = 0;
			enemy[new_enemy_index].y = WorldYToScreenY(GROUND_Y - 1);
			enemy[new_enemy_index].sprite.off    = ((u16)&walker01_sprite_anim_data) & SPRITE_UNMIRRORED;
			enemy[new_enemy_index].original_off  = enemy[new_enemy_index].sprite.off;
			enemy[new_enemy_index].sprite.height = 8U;
			enemy[new_enemy_index].sprite.col1   = 0x13U;
			enemy[new_enemy_index].sprite.col2   = 0x47U;
			enemy[new_enemy_index].sprite.col3   = 0x7FU;
			enemy[new_enemy_index].anim_frame_count = 2;
			break;

	}

	//	Enemy walker 2,
	//	Enemy walker 3,
	//	Enemy walker boss 1,
	//	Enemy walker boss 2,
	//	Enemy flyer 1,	
	//	Enemy flyer 2,
	//	Enemy flyer 3,
	//	Enemy flyer 4,
	//	Enemy flyer 5,
	//	Enemy flyer 6,	
	//	Enemy flyer boss 1,
	//	Enemy flyer boss 2,
	//	Enemy flyer boss 3

	// Set our sprite metadata so we can easily tell what type of enemy a sprite is
	enemy[new_enemy_index].type = index_to_spawn;
	wave_enemies_spawned++;

}
