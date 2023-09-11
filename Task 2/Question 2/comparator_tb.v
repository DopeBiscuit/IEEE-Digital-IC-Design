`timescale 1ns/1ns
module comparator_tb ();
	parameter n = 5;
	reg [n-1: 0] A, B, C;
	wire [(2 * n) - 1: 0] OUT1, OUT2;
	
	
	comparator #(.n(n)) DUT (.A (A), .B (B), .C (C), .OUT1 (OUT1), .OUT2 (OUT2));
	
	integer i;
	initial begin
		for(i = 0; i < 15; i = i + 1) begin
			A = $random;
			B = $random;
			C = $random;
			#2;
		end
		#10; $stop;
	end
	
	initial begin
		$monitor("A = %d B = %d C = %d <---binary---> A = %b B = %b C = %b OUT1 = %b OUT2 = %b",A, B, C, A, B, C, OUT1, OUT2);
	end
	
endmodule