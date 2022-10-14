
#include <GL/glut.h>
#include <stdio.h>
#include "graphics_interface.h"


unsigned int board_data[SIZE_X * SIZE_Y * 3];

void board_put_pixel(int x, int y, rgb_t rgb) {

    int position = (x + y * SIZE_X) * 3;
    printf("position: %d\n", position);
    board_data[position] = rgb.r;
    board_data[position + 1] = rgb.g;
    board_data[position + 2] = rgb.b;
    return;
}

void board_flush() {

    glClear(GL_COLOR_BUFFER_BIT);
    glDrawPixels(SIZE_X, SIZE_Y, GL_RGB, GL_UNSIGNED_BYTE, board_data);
    glutSwapBuffers();
    glutPostRedisplay();

}


