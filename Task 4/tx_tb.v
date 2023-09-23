`timescale 1ns/1ns
module tx_tb ();
	
	// Define variables
	reg clk, reset;
	wire tx;
	
	tx DUT (.clk (clk), .reset (reset), .tx (tx));
	
	initial begin
		// Generate Clock
		clk = 0;
		forever 
			#1 clk = ~clk;
	end
	
	initial begin
		// Test Reset	
		reset = 1;
		#3 reset = 0;
		#100
		$stop;
	end
endmodule