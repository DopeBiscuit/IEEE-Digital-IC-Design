`timescale 1ns/1ns
module DECODER_TESTBENCH (Y);
	reg [2:0] A;
	reg ENB;
	output [7:0] Y;
	
	integer i;
	
	DECODER DUT (.A (A), .ENB (ENB), .Y (Y));
	
	initial begin 
		for(i = 0; i < 20; i = i + 1) begin
			A = $random;
			ENB = $random;
			#3;
		end
		#5; $stop;
	end
	
	initial begin
		$monitor("A = %d ENB = %b Y = %d  <---Binary---> Y = %b", A, ENB, Y, Y);
	end
endmodule