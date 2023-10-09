module datapath (
    input clk, // clock
    input reset, // reset
    input write_enable, // write enable
    input pc_src, // PC source
    input alu_src, // ALU source
    input [1:0] imm_src, // immediate source
    input [1:0] result_src, // Result source
    input [2:0] alu_control, // ALU control
    input [31:0] inst, // instruction
    input [31:0] memory_read_data, // data read from the memory block

    output zero, // zero flag
    output [31:0] pc, // program counter
    output [31:0] data_out, // data to be stored in the memory
    output [31:0] alu_result // alu result
);

    wire [31:0] imm;
    wire [31:0] srca, srcb;
    wire [31:0] pc_next; // next PC
    reg [31:0] pc_next_reg; // next PC register
    wire [31:0] pcplus4_result; // PC + 4
    wire [31:0] pcbranch_result; // PC + branch
    wire [31:0] result; // result

    initial begin
        pc_next_reg = 0;
    end

    always @* begin
        pc_next_reg = pc_next;
    end

    // Register file logic
    reg_file reg_file (
        .clk (clk),     // Inputs
        .write_enable (write_enable),
        .data_in (result),
        .read_reg1 (inst[19:15]),
        .read_reg2 (inst[24:20]),
        .write_reg (inst[11:7]),

        .rd1 (srca),    // Outputs
        .rd2 (data_out)
    );

    // Immediate Extender logic //***************************************************************************//
    imm_extender imm_extender (
        .inst (inst),
        .imm_src (imm_src),
        .imm (imm)
    );


    // next PC logic // ***************************************************************************//
    flop_register #(32) pc_reg (
        .clk (clk),
        .reset (reset),
        .data_in (pc_next_reg),
        .data_out (pc)
    );
    
    adder pcplus4 (
        .a (pc),
        .b (32'b100),
        .result (pcplus4_result)
    );

    adder pcaddbranch (
        .a (pc),
        .b (imm),
        .result (pcbranch_result)
    );

    mux2 #(32) pcmux (
        .sel (pc_src),
        .a (pcplus4_result),
        .b (pcbranch_result),
        .y (pc_next)
    );
    
    // Alu logic //***************************************************************************//
    mux2 #(32) srcbmux (
        .sel (alu_src),
        .a (data_out),
        .b (imm),
        .y (srcb)
    );
    alu alu (
        .alu_control (alu_control),
        .operand1 (srca),
        .operand2 (srcb),
        .zero (zero),
        .alu_result (alu_result)
    );
    mux3 #(32) resultmux (
        .sel (result_src),
        .a (alu_result),
        .b (memory_read_data),
        .c (pcplus4_result),
        .y (result)
    );
endmodule

module imm_extender (
    input [31:0] inst, // instruction
    input [1:0] imm_src, // immediate source

    output reg [31:0] imm // immediate
);

    // Sign extends the immediate value to 32 bits based on the immediate source (imm_src) 
    // which is the immediate value in the instruction (inst)
    // imm_src = 0: I-type, imm_src = 1: S-type, imm_src = 2: B-type, imm_src = 3: J-type

    always @* begin
        case (imm_src)
            2'b00: imm = {{19{inst[31]}}, inst[31], inst[31:20]}; // I-type
            2'b01: imm = {{19{inst[31]}}, inst[31:25], inst[11:7]}; // S-type
            2'b10: imm = {{19{inst[31]}}, inst[31], inst[7], inst[30:25], inst[11:8], 1'b0}; // B-type
            2'b11: imm = {{11{inst[31]}}, inst[31], inst[19:12], inst[20], inst[30:21], 1'b0}; // J-type
        endcase
    end
endmodule

module mux2 #(
    parameter WIDTH = 8
) (
    input [WIDTH-1:0] a, b, // inputs
    input sel, // select
    output wire [WIDTH-1:0] y // output
);

    // 2:1 multiplexer
    // if sel is 0, output is a, if sel is 1, output is b
    assign y = (sel) ? b : a;
endmodule

module adder (
    input [31:0] a, b, // inputs
    output wire [31:0] result // output
);
    // 32 bit adder
    // result = a + b
    assign result = a + b;    
endmodule

module flop_register #(
    parameter WIDTH = 8
) (
    input clk, // clock
    input reset, // reset
    input [WIDTH-1:0] data_in, // data to be written
    output reg [WIDTH-1:0] data_out // data to be read
);
    // register with synchronous reset
    // data_out is assigned with clock edge
    // data_out is reset to 0 when reset is high
    initial begin
        data_out = 0;
    end

    always @(posedge clk) begin
        if (reset) begin
            data_out <= 0;
        end else begin
            data_out <= data_in;
        end
    end
endmodule

module mux3 #(
    parameter WIDTH = 8
) (
    input [WIDTH-1:0] a, b, c, // inputs
    input [1:0] sel, // select
    output wire [WIDTH-1:0] y // output
);

    // 3:1 multiplexer
    // if sel is 00, output is a, if sel is 01, output is b, if sel is 10, output is c
    assign y = (sel == 2'b00) ? a : (sel == 2'b01) ? b : c;
endmodule

module alu (
    input [2:0] alu_control, // ALU control
    input [31:0] operand1, operand2, // operands
    output wire zero, // zero flag
    output reg [31:0] alu_result // ALU result
);

    // ALU
    // alu_control = 000: add, 001: subtract, 010: and, 011: or, 101: set less than
    // alu_result = operand1 + operand2, operand1 - operand2, operand1 < operand2
    assign zero = !alu_result;
    always @* begin
        case (alu_control)
            3'b000: alu_result = operand1 + operand2; // add
            3'b001: alu_result = operand1 - operand2; // subtract
            3'b010: alu_result = operand1 & operand2; // and
            3'b011: alu_result = operand1 | operand2; // or
            3'b100: alu_result = operand1 << operand2[4:0]; // shift left logical
            3'b111: alu_result = operand1 >> operand2[4:0]; // shift right logical
            3'b101: alu_result = (operand1 < operand2) ? 1 : 0; // set less than
            default: alu_result = 0;
        endcase
    end
endmodule