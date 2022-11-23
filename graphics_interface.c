
#include <GL/glut.h>
#include <stdio.h>
#include "graphics_interface.h"

unsigned int board_data[SIZE_X * SIZE_Y * 3];

void board_put_pixel(int x, int y, rgb_t rgb) {

    int position = (x + y * SIZE_X) * 3;
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


void init_window(int argc, char** argv) {
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGBA);
    glutInitWindowSize(SIZE_X, SIZE_Y);
    glutInitWindowPosition(100, 100);
    glutCreateWindow("Game of life");
    glClearColor(0, 0, 0, 0);
    init_game();
    glutDisplayFunc(display);
    glutMainLoop();
}


