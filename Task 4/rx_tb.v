`timescale 1ns/1ns
module rx_tb ();
	
	reg clk, tx;
	wire [7:0] OUT;
	
	rx DUT (.clk (clk), .tx (tx), .OUT (OUT));
	
	
	initial begin
		clk = 0;
		tx = $random;
		forever begin
			#1 clk = ~clk;
		end
	end
	
	always @ (posedge clk) 
		tx <= $random;
	
	initial begin
		#100
		$stop;
	end
endmodule