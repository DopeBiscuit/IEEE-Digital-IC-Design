`timescale 1ns/1ns
module rx (
	input tx, clk, reset,
	output reg [7:0] OUT
);

	// Define Variables
	reg [7:0] word;
	reg [3:0] counter;
	
	// Initialize Variables with low logic
	initial begin
		counter = 0;
		word = 0;
	end
	
	// Counter block for selection line of the Demux
	always @ (posedge clk or posedge reset) begin
		if (reset)
			counter <= 'b0;
		else
			counter <= (counter == 9) ? 0 : counter + 1;
	end
	
	// Demux output logic
	always @ (posedge clk or posedge reset) begin
		if (reset)
			word <= 'b0;
		else if (!counter) 
			word <= 'b0;
		else if (counter != 9)
			word[counter - 1] <= tx;
		else
			word <= word;
	end
	
	// Register output logic
	always @ (word) begin
		OUT <= word;
	end
	
	// Monitor value changes
	initial begin
		$monitor("word = %b OUT = %b counter = %d  tx = %b", word, OUT, counter, tx);
	end
endmodule