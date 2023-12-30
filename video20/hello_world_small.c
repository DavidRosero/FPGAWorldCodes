#include <stdio.h>
#include "system.h"
#include "io.h"
#include "unistd.h"
#include "alt_types.h"

#define BTN_BASE_ADDR   SW_BASE
#define SEG_BASE_ADDR   SEG_BASE

const int seven_seg_digits[] = {
    0xC0, // 0
    0xF9, // 1
    0xA4, // 2
    0xB0, // 3
    0x99, // 4
    0x92, // 5
    0x82, // 6
    0xF8, // 7
    0x80, // 8
    0x90  // 9
};

void displayNumber(int number) {
    if (number >= 0 && number <= 9) {
        int display_value = seven_seg_digits[number];
        IOWR(SEG_BASE_ADDR, 0, display_value);
    } else {
        IOWR(SEG_BASE_ADDR, 0, 0);
    }
}

int main() {
    printf("Contador con Display de 7 Segmentos y Botones\n");

    int contador = 0;
    int sw_data;
    int last_button_state = 1;  // Estado anterior del botón, asumimos que es 1 al inicio
    int last_reset_button_state = 1;

    while (1) {
        sw_data = IORD(BTN_BASE_ADDR, 0);
        int current_button_state = sw_data & 0x01;  // Obtener el estado del bit del botón
        int current_reset_button_state = (sw_data >> 1) & 0x01;

        // Incrementar el contador si el botón ha cambiado de 1 a 0 (presionado)
        if (current_button_state == 0) {
            contador++;
        }
        // Reiniciar el contador cuando llega a 9
        if (contador > 9) {
            contador = 0;
        }

        // Reiniciar el contador si el botón de reinicio ha cambiado de 1 a 0 (presionado)
        if (current_reset_button_state == 0 && last_reset_button_state == 1) {
            contador = 0;
        }

        displayNumber(contador);

        // Actualizar el estado anterior del botón
        last_button_state = current_button_state;
        last_reset_button_state = current_reset_button_state;

        usleep(1000000); // 100 us
    }

    return 0;
}
