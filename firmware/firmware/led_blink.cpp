#include "led_blink.h"

using namespace std;

void gpio_led::write_gpio(uint32_t value) {
    *GPIO_OUT = value;
}

// Function to enable Nth GPIO as output (optional for setting direction)
void gpio_led::enable_gpio_output(uint32_t gpio_number) {
    if (gpio_number >= 32) {
        return;
    }
    *GPIO_OUT_EN |= (1U << gpio_number);
}
// Function to read Nth GPIO as boolean value
bool gpio_led::read_gpio(uint32_t gpio_number) {
    if (gpio_number >= 32) {
        return false;
    }
    uint32_t gpio_value = *GPIO_READ;
    bool state = (gpio_value & (1U << gpio_number)) != 0;

    return state;
}

void gpio_led::delay(uint32_t cycles) {
    for (volatile uint32_t i = 0; i < cycles * 1000; i++);
}