#pragma once

#define SIZE_X 800
#define SIZE_Y 600

extern unsigned int board_data[SIZE_X * SIZE_Y * 3];

struct rgb_t {

    int r;
    int g;
    int b;

};

typedef struct rgb_t rgb_t;

void board_put_pixel(int x, int y, rgb_t rgb);

void board_flush();

void display();

void init_window();

