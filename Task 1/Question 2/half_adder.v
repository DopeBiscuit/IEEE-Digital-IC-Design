module half_add (input A, B, output SUM, COUT);
	xor(SUM, A, B);
	and(COUT, A, B);
endmodule
