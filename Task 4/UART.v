`timescale  1ns/1ns
module UART (
    input clk, reset,
    output OUT
);

    // Define Variables
    wire tx;

    tx UTX (.clk (clk), .reset (reset), .tx (tx));

    rx URX (.clk (clk), .reset (reset), .tx (tx), .OUT (OUT));

endmodule