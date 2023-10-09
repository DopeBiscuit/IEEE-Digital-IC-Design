module controller (
    input [6:0] op_code, // operation code
    input [2:0] func3, // function code
    input func7b5, // function code bit 5
    input zero, // zero flag
    output wire [2:0] alu_control, // ALU control
    output wire alu_src, // ALU source
    output wire reg_write, // register write
    output wire mem_write, // memory write
    output wire [1:0] imm_src, // immediate source
    output wire [1:0] result_src, // Result source
    output wire pc_src // PC source
    );
    
    wire branch, jump;
    wire [1:0] alu_op;

    decoder main_decoder (
        .op_code (op_code),
        .mem_write (mem_write),
        .reg_write (reg_write),
        .imm_src (imm_src),
        .result_src (result_src),
        .alu_src (alu_src),
        .branch (branch),
        .jump (jump),
        .alu_op (alu_op)
    );

    alu_controller alu_controller (
        .op5 (op_code[4]),
        .func3 (func3),
        .func7b5 (func7b5),
        .alu_op (alu_op),
        .alu_control (alu_control)
    );

    assign pc_src = branch & zero | jump;

endmodule


module decoder(
    input [6:0] op_code, // operation code
    output wire mem_write, // memory write
    output wire reg_write, // register write
    output wire [1:0] imm_src, // immediate source
    output wire [1:0] result_src, // Result source
    output wire alu_src, // ALU source
    output wire [1:0] alu_op, // ALU operation
    output wire branch, jump // branch and jump
);

    reg [10:0] controls;

    assign {mem_write, reg_write, imm_src, result_src, alu_src, alu_op, branch, jump} = controls;

    always @* begin
    case (op_code)
        7'b0110011: controls <= 11'b0_1_xx_00_0_10_0_0; // R-type
        7'b0010011: controls <= 11'b0_1_00_00_1_10_0_0; // I-type
        7'b0000011: controls <= 11'b0_1_00_01_1_00_0_0; // Load
        7'b0100011: controls <= 11'b1_0_01_xx_1_00_0_0; // Store
        7'b1100011: controls <= 11'b0_0_10_00_0_01_1_0; // Branch if equal
        7'b1101111: controls <= 11'b0_1_11_10_0_00_0_1; // Jump and link
        default: controls <= 11'bxxxxxxxxxxx;
    endcase
    end

endmodule

module alu_controller (
    input op5, // operation code bit 5
    input [2:0] func3, // function code
    input func7b5, // function code bit 5
    input [1:0] alu_op, // ALU operation
    output reg [2:0] alu_control // ALU control
    );

    always @* begin
        case (alu_op)
            2'b00: alu_control <= 3'b000; // add
            2'b01: alu_control <= 3'b001; // subtract
            2'b10: case (func3)
                3'b000: alu_control <= 3'b000;
                3'b001: alu_control <= 3'b100; // shift left logical
                3'b010: alu_control <= 3'b101; // set less than
                3'b101: alu_control <= 3'b111; // shift right logical
                3'b110: alu_control <= 3'b011; // or
                3'b111: alu_control <= 3'b010; // and
                default: alu_control <= 3'bxxx;
            endcase
            default: alu_control <= 3'bxxx;
        endcase
    end
    
endmodule