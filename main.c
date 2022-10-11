
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include "graphics_interface.h"

void logic_loop() {
    while(1) {
        printf("In logic loop\n");
        sleep(10);
    }
}

int main() {

    pthread_t logic_thread;
    int ret = pthread_create(&logic_thread, NULL, logic_loop, NULL);
    if (ret < 0) {
        perrro("Error creating logic thread\n");
    }

    return 0;
}
