// UART Transmitter module (8 bit word, with low start_bit and high end_bit)
`timescale 1ns/1ns
module tx (
	input clk, reset,
	output reg tx
);

	reg [3:0] Sel;
	reg [7:0] Q;
	
	// initialize values
	initial begin
		Sel = 0;
		Q = 0;
		
		// Idle State
		tx = 0;
	end
	
	always @ (posedge clk or posedge reset) begin
		// Check for reset
		if (reset) 
			Sel <= 'b0;
		else
			Sel <= (Sel == 9) ? 0 : (Sel + 1);
	end
	
	always @ (Sel or posedge reset) begin
		// Check for reset
		if (reset)
			Q <= 'b0;
		else
			Q <= Q + (!Sel);
	end
	
	always @ (Sel or posedge reset) begin
		// Check for reset
		if (reset)
			// Restart Idle State
			tx <= 1;
		else if (!Sel)
			tx <= 0;
		else if (Sel < 9)
			tx <= Q[Sel - 1];
		else
			tx <= 1;
	end
	
	initial begin
		// Value Logging
		$monitor("SEL = %b Q = %b -----> tx = %b  reset = %b", Sel, Q, tx, reset);
	end

endmodule