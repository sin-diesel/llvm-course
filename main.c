
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <GL/glut.h>
#include "graphics_interface.h"


int main(int argc, char** argv) {

    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGBA);
    glutInitWindowSize(SIZE_X, SIZE_Y);
    glutInitWindowPosition(100, 100);
    glutCreateWindow("Game of life");
    glClearColor(0, 0, 0, 0);
    glutDisplayFunc(display);
    glutMainLoop();

    return 0;
}
