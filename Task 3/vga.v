`timescale 1ns/1ns
module vga_controller (
	input clk,
	input reset,
	output reg h_sync, v_sync,
	output reg [2:0] RGB
	);
	
	// Local variables, breakpoint makes the code run for 1 frame duration.
	reg video_on;	
	reg breakpoint;
	
	parameter color = 3'b011;
	reg [9:0] pixel_x, pixel_y;
	
	
	// Initialize variables
	initial begin
		pixel_x = 0;
		pixel_y = 0;
		RGB = color;
		video_on = 1;
		h_sync = 1;
		v_sync = 1;
	end
	
	always @ (posedge clk) begin
		
		// Reset condition
		if (reset) begin 
			pixel_x = 0; 
			pixel_y = 0;
			video_on = 1;
			h_sync = 1;
			v_sync = 1;
		end
		
		else begin
			// Updating values using non-blocking assignment to have proper effect on the next conditions.
			pixel_x = ((pixel_x + 1) == 800) ? 0 : pixel_x + 1;
			pixel_y = ((pixel_y + !(pixel_x)) == 525) ? 0 : pixel_y + !(pixel_x);
			video_on = ((pixel_x < 640) && (pixel_y < 480));
			breakpoint = (!pixel_x && !pixel_y);
			
			// Updating outputs based on the changes of the X and Y.
			if (pixel_x >= 656 && pixel_x < 752) 
				h_sync = 0;
			else
				h_sync = 1;
				
			if(pixel_y >= 490 && pixel_y < 492)
				v_sync = 0;
			else
				v_sync = 1;
		end
	end

	// For monitoring any changes that happens to the outputs and printing out its coordinates.
	always @ (video_on or v_sync or h_sync) begin
		// Display used instead of monitor, because we only want to print once when the outputs change, not the coordinates as well
		$display("@ pixel_x = %d & pixel_y = %d ----> Video_on = %b h_sync = %b v_sync = %b ", pixel_x, pixel_y, video_on, h_sync, v_sync);
	end
	
	// If breakpoint value becomes one, meaning one full frame has passed stop the code.
	always @ (breakpoint) begin
		if (breakpoint)
			$stop;
	end
endmodule