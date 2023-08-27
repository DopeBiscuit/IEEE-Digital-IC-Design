module half_sub (input A, B, output DIFFERENCE, BORROW);
	wire S1;

	xor(DIFFERENCE, A, B);
	nor(S1, A);
	and(BORROW, S1, B);
endmodule