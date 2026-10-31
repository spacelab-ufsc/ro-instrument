#ifndef UART_TEST_H
#define UART_TEST_H

#include <stdint.h>

class UART {
    private:
        volatile uint32_t clk_div;
        volatile uint32_t data;
    public:
        void uart_init(uint32_t clk_hz, uint32_t baud);
        void uart_putchar(char c);
        char uart_getchar();
};

#endif