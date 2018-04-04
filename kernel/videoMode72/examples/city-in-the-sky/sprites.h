#pragma once
#include <avr/pgmspace.h>

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


static const unsigned char walker01_sprite_anim_data[] PROGMEM = {

 0b00000011U,0b11000000U,
 0b00000011U,0b11000000U,
 0b00001100U,0b00110000U,
 0b00110000U,0b00110000U,
 0b00110000U,0b00001100U,
 0b00110000U,0b00001100U,
 0b11000000U,0b00000011U,
 0b11111100U,0b00111111U,

 0b00000011U,0b11000000U,
 0b00000011U,0b11000000U,
 0b00001100U,0b00110000U,
 0b00110000U,0b00001100U,
 0b11000001U,0b01000011U,
 0b00110001U,0b01001100U,
 0b11000000U,0b00000011U,
 0b01111100U,0b00111111U

};