`timescale 1 ns/100 ps
// Version: 2023.2 2023.2.0.8


module OSCILLATOR_160MHz_OSCILLATOR_160MHz_0_PF_OSC(
       RCOSC_160MHZ_CLK_DIV,
       RCOSC_160MHZ_GL
    );
output RCOSC_160MHZ_CLK_DIV;
output RCOSC_160MHZ_GL;

    wire GND_net, VCC_net;
    
    VCC vcc_inst (.Y(VCC_net));
    OSC_RC160MHZ I_OSC_160 (.OSC_160MHZ_ON(VCC_net), .CLK(
        RCOSC_160MHZ_CLK_DIV));
    GND gnd_inst (.Y(GND_net));
    CLKINT I_OSC_160_INT (.A(RCOSC_160MHZ_CLK_DIV), .Y(RCOSC_160MHZ_GL)
        );
    
endmodule
