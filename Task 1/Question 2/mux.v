module MUX (input m0, m1, SEL, output o1);
	wire s1, s2, s3;
	
	not(s1, SEL);
	and(s2, s1, m0);
	and(s3, SEL, m1);
	or(o1, s2, s3);
endmodule