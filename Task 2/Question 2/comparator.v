module comparator (A, B, C, OUT1, OUT2);
	parameter n = 5;
	input [n-1: 0] A, B, C;
	output reg [(2 * n) - 1: 0] OUT1, OUT2;

	
	
	always @ (*) begin
		
		if(A == B && B == C) begin 
			OUT1 = A << 2;
			OUT2 = A >> 2;
		end
		else if (A > B) begin
			if (C > A) begin
				OUT1 = (C[n-1]) ? {{n{1'b1}}, C} : C ;
				OUT2 = {A, B};
			end
			else if (C == A) begin
				OUT1 = 0;
				OUT2 = 0;
			end
			else begin
				OUT1 = (A[n-1]) ? {{n{1'b1}}, A} : A ;
				OUT2 = {B, C};
			end
		end
		else if (A == B  && A > C) begin
				OUT1 = 0;
				OUT2 = 0;
		end
		else begin
			if (C > B) begin
				OUT1 = (C[n-1]) ? {{n{1'b1}}, C} : C ;
				OUT2 = {A, B};			
			end
			else if (C == B) begin
				OUT1 = 0;
				OUT2 = 0;
			end
			else begin
				OUT1 = (B[n-1]) ? {{n{1'b1}}, B} : B ;
				OUT2 = {A, C};
			end
		end
	end
endmodule
