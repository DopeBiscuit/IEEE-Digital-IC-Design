module Task1 (A, B, D, OUT);
	input A, B;
	input [2:0]D;
	output OUT;
	wire S1, S2;

	and(S1, D[0], D[1]);
	xnor(S2, A, B, D[2]);
	or(OUT, S1, S2);
endmodule