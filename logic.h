#pragma once

#include "graphics_interface.h"

#define INITIAL_CELLS_NUM 12000

void init_game();

void display();

void game_update();

int is_color(rgb_t test, rgb_t ref);

int count_living_neighbours(int up, int down, int left, int right,
                            int leftup, int rightup, int leftdown, int rightdown);

