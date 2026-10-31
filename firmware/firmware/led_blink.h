#ifndef LED_BLINK_H
#define LED_BLINK_H

#include <stdint.h>

#define GPIO_READ_ADDR   0x00022000U
#define GPIO_OUT_EN_ADDR 0x00022004U
#define GPIO_OUT_ADDR    0x00022008U

#define LED_PIN 0U

#define LED_ON  0x001U
#define LED_OFF 0x000U

class gpio_led {
    private:
        volatile uint32_t* GPIO_READ = reinterpret_cast<volatile uint32_t*>(GPIO_READ_ADDR);
        volatile uint32_t* GPIO_OUT_EN = reinterpret_cast<volatile uint32_t*>(GPIO_OUT_EN_ADDR);
        volatile uint32_t* GPIO_OUT = reinterpret_cast<volatile uint32_t*>(GPIO_OUT_ADDR);
    public:
        void write_gpio(uint32_t value);
        void enable_gpio_output(uint32_t gpio_number);
        bool read_gpio(uint32_t gpio_number);
        void delay(uint32_t cycles);
};

#endif