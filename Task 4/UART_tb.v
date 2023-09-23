`timescale  1ns/1ns
module UART_tb ();
    // Define variables
    reg clk, reset;
    wire OUT;

    initial begin
        clk = 'b0;
        reset = 'b1;
        #1 reset = 'b0;

        forever begin
            #1 clk = ~clk;
        end
    end

    UART DUT (.clk (clk), .reset (reset), .OUT (OUT));

    initial begin
        #100;
        $stop;
    end

endmodule