
#include <unistd.h>
#include <stdlib.h>
#include <time.h>
#include <stdio.h>
#include <string.h>

#include "graphics_interface.h"
#include "logic.h"

void display() {
    
    game_update();  
    board_flush();
    sleep(1);
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

int count_living_neighbours(int up, int down, int left, int right,
                            int leftup, int rightup, int leftdown, int rightdown) {

    int count = 0;

    rgb_t black = {0, 0, 0};
    rgb_t green = {0, 255, 0};

    rgb_t up_color = {board_data[up], board_data[up + 1], board_data[up + 2]};
    rgb_t down_color = {board_data[down], board_data[down + 1], board_data[down + 2]};
    rgb_t left_color = {board_data[left], board_data[left + 1], board_data[left + 2]};
    rgb_t right_color = {board_data[right], board_data[right + 1], board_data[right + 2]};
    rgb_t leftup_color = {board_data[leftup], board_data[leftup + 1], board_data[leftup + 2]};
    rgb_t rightup_color = {board_data[rightup], board_data[rightup + 1], board_data[rightup + 2]};
    rgb_t leftdown_color = {board_data[leftdown], board_data[leftdown + 1], board_data[leftdown + 2]};
    rgb_t rightdown_color = {board_data[rightdown], board_data[rightdown + 1], board_data[rightdown + 2]};

        if (is_color(up_color, green)) {
            ++count;
        }
        if (is_color(down_color, green)) {
            ++count;
        }
        if (is_color(left_color, green)) {
            ++count;
        }
        if (is_color(right_color, green)) {
            ++count;
        }
        if (is_color(leftup_color, green)) {
            ++count;
        }
        if (is_color(rightup_color, green)) {
            ++count;
        }
        if (is_color(leftdown_color, green)) {
            ++count;
        }
        if (is_color(rightdown_color, green)) {
            ++count;
        }
    return count;
}

int is_color(rgb_t test, rgb_t ref) {
    return memcmp(&test, &ref, sizeof(rgb_t)) == 0;
}

// TODO: Add diagonal cells
void game_update() {

    rgb_t black = {0, 0, 0};
    rgb_t green = {0, 255, 0};

    for (int x = 0; x < SIZE_X - 1; x += 2) {
        for (int y = 0; y < SIZE_Y - 1; y += 2) {

            int position = (x + y * SIZE_X) * 3;
            int up = (x + (y + 1) * SIZE_X) * 3;
            int down = (x + (y - 1) * SIZE_X) * 3;
            int left = ((x - 1) + y * SIZE_X) * 3;
            int right = ((x + 1) + y * SIZE_X) * 3;
            int leftup = ((x - 1) + (y + 1) * SIZE_X) * 3;
            int rightup = ((x + 1) + (y + 1) * SIZE_X) * 3;
            int leftdown = ((x - 1) + (y - 1) * SIZE_X) * 3;
            int rightdown = ((x + 1) + (y - 1) * SIZE_X) * 3;

            rgb_t cell_color = {board_data[position], board_data[position + 1], board_data[position + 2]};
            int num_of_neighbours = count_living_neighbours(up, down, left, right, leftup, rightup, leftdown, rightdown);
            if (is_color(cell_color, green)) {
                printf("num_of_neighbours:%d\n", num_of_neighbours);
                if (num_of_neighbours >= 4 || num_of_neighbours <= 1) {
                    board_put_pixel(x, y, black);
                }
            } else {
                if (num_of_neighbours >= 3) {
                    board_put_pixel(x, y, green);
                }
            }
        }
    }
}