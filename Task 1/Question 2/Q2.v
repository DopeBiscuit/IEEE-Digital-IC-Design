module Q2 (input IN0, IN1, SEL, output SUM, CARRY);
	wire adder_sum, adder_cout, sub_diff, sub_borrow;
	
	half_add adder ( .A (IN1), .B (IN0), .SUM (adder_sum), .COUT (adder_cout));
	half_sub subtractor ( .B (IN0), .A (IN1), .BORROW (sub_borrow), .DIFFERENCE (sub_diff));
	
	MUX mux1 ( .m0 (sub_diff), .m1 (adder_sum), .SEL (SEL), .o1 (SUM));
	MUX mux2 ( .m0 (sub_borrow), .m1 (adder_cout), .SEL (SEL), .o1 (CARRY));
endmodule
