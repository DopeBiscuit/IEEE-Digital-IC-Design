module tb_controller();

    reg [6:0] op_code; // operation code
    reg [2:0] func3; // function code
    reg func7b5; // function code bit 5
    reg zero; // zero flag

    wire [2:0] alu_control; // ALU control
    wire alu_src; // ALU source
    wire reg_write; // register write
    wire mem_write; // memory write
    wire [1:0] imm_src; // immediate source
    wire [1:0] result_src; // Result source
    wire pc_src; // PC source

    controller DUT (
        .op_code (op_code),
        .func3 (func3),
        .func7b5 (func7b5),
        .zero (zero),
        .alu_control (alu_control),
        .alu_src (alu_src),
        .reg_write (reg_write),
        .mem_write (mem_write),
        .imm_src (imm_src),
        .result_src (result_src),
        .pc_src (pc_src)
    ); // instantiate DUT

initial begin

    op_code = 7'b0110011;
    func3 = {1'b0, $random % 2, 1'b1, $random % 2, 1'b1, $random % 2, 1'b0};
    func7b5 = $random % 2;
    zero = 0;
    #10;

    op_code = 7'b0010011;
    // random value for func3 from any of the following: 000, 010, 110, 111.
    func3 = {1'b0, $random % 2, 1'b1, $random % 2, 1'b1, $random % 2, 1'b0};
    func7b5 = $random % 2;
    zero = 0;
    #10;

    op_code = 7'b0000011;
    func3 = {1'b0, $random % 2, 1'b1, $random % 2, 1'b1, $random % 2, 1'b0};
    func7b5 = $random % 2;
    zero = 0;
    #10;

    op_code = 7'b0100011;
    func3 = {1'b0, $random % 2, 1'b1, $random % 2, 1'b1, $random % 2, 1'b0};
    func7b5 = $random % 2;
    zero = 0;
    #10;

    op_code = 7'b1100011;
    func3 = {1'b0, $random % 2, 1'b1, $random % 2, 1'b1, $random % 2, 1'b0};
    func7b5 = $random % 2;
    zero = 0;
    #10;

    op_code = 7'b1101111;
    func3 = {1'b0, $random % 2, 1'b1, $random % 2, 1'b1, $random % 2, 1'b0};
    func7b5 = $random % 2;
    zero = 0;
    #10;

    $stop;
    
end

initial begin
    // print inputs and outputs
    $monitor("op_code=%b, func3=%b, func7b5=%b, zero=%b, alu_control=%b, alu_src=%b, reg_write=%b, mem_write=%b, imm_src=%b, result_src=%b, pc_src=%b", op_code, func3, func7b5, zero, alu_control, alu_src, reg_write, mem_write, imm_src, result_src, pc_src);
end

endmodule

