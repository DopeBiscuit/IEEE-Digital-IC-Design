`timescale 1ns/1ns
module vga_controller_tb ();

	parameter color = 3'b101;
	reg clk, reset;
	wire h_sync, v_sync;
	wire [2:0] RGB;
	
	// Instantiating the vga_controller module 
	vga_controller #(.color(color)) DUT (
		.clk (clk),
		.reset (reset),
		.h_sync (h_sync),
		.v_sync (v_sync),
		.RGB (RGB)
	);

	// Making a clock withe a period of 40ns aka (frequency of 25 Mhz approx)
	always #20 clk = ~clk;

	// Initialize clock and reset with zero.
	initial begin
		reset = 0;
		clk = 0;
	end
endmodule