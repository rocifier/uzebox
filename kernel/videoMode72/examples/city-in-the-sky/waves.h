#include <avr/pgmspace.h>

/*
 * Total count,     Enemy count walker 1,	Enemy count walker 2,	Enemy count walker 3,	Enemy count walker boss 1,	Enemy count walker boss 2,	Enemy count flyer 1,	
 * Enemy count flyer 2,	Enemy count flyer 3,	Enemy count flyer 4,	Enemy count flyer 5,	Enemy count flyer 6,	
 * Enemy count flyer boss 1,	Enemy count flyer boss 2,	Enemy count flyer boss 3
 */

static const unsigned char waves[][15] PROGMEM = {
    {2, 2,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {3, 3,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {5, 1,4,0,0,0,0,0,0,0,0,0,0,0,0},
    {6, 0,6,0,0,0,0,0,0,0,0,0,0,0,0},
    {2, 0,0,2,0,0,0,0,0,0,0,0,0,0,0}

};
