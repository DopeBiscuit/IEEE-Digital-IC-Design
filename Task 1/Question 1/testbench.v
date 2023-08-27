module Q1_tb (OUT);
	
	reg A, B;
	output OUT;
	reg [2:0] D;

	
	localparam period = 20;	

	Task1 UUT ( .A (A), .B (B), .OUT (OUT), .D (D));
	
	integer i;
	
	initial begin
		for (i = 0;i < 8; i = i + 1) begin
			D = (i) ? (D + 1'b1) : (3'b000);
			A = 0;
			B = 0;
			#period;
			
			A = 1;
			B = 0;
			#period;
			
			A = 0;
			B = 1;
			#period;
			
			A = 1;
			B = 1;
			#period;
		end
	end
endmodule
	