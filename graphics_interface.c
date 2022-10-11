
#include "graphics_interface.h"
#include <GL/freeglut.h>

int board_data[SIZE_X * SIZE_Y];

int buffer[SIZE_X * SIZE_Y];

void board_put_pixel(int x, int y, int rgb) {
    return;
}

void board_flush() {

    glDrawPixels(SIZE_X, SIZE_Y, GL_RGB, GL_UNSIGNED_INT, board_data);
    glutSwapBuffers();
    glutPostRedisplay();

}

