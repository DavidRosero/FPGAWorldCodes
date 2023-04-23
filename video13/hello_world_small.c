#include <stdio.h>
#include "system.h" //access Nios II system info
#include "io.h" //access to IORD and IORW
#include "unistd.h" //access to usleep


int main(){
    printf("Hello, World!\n");
    int sw_data = 1;
    while(1){
        sw_data = IORD(SW_BASE,0);
        IOWR(LED_BASE,0,sw_data);
        usleep(100000); //sleep 100 us
    }
    return 0;
}
