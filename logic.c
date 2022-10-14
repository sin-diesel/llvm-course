
#include <unistd.h>
#include <stdlib.h>
#include <time.h>
#include <stdio.h>

#include "graphics_interface.h"
#include "logic.h"

void display() {
    
    init_game();
    board_flush();

}

void init_game() {
    
    srand(time(NULL));

    for (int cell_idx = 0; cell_idx < INITIAL_CELLS_NUM; ++cell_idx) {

        int cell_x = rand() % SIZE_X;
        int cell_y = rand() % SIZE_Y;

        printf("cell x, y: %d %d\n", cell_x, cell_y);

        rgb_t rgb;
        rgb.r = 0;
        rgb.g = 255;
        rgb.b = 0;

        board_put_pixel(cell_x, cell_y, rgb);

    }

}