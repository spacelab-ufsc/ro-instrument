#include "led_blink.h"

int main() {
    gpio_led led;

    led.enable_gpio_output(LED_PIN);

    while(1){
        led.write_gpio(LED_ON);
        led.delay(1000);
    
        led.write_gpio(LED_OFF);
        led.delay(1000);
    }

    return 0;
}