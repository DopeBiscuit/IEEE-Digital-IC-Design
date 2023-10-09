module tb_datapath;
reg clk;
reg reset;

reg write_enable; // write enable
reg pc_src; // PC source
reg alu_src; // ALU source
reg [1:0] imm_src; // immediate source
reg [1:0] result_src; // Result source
reg [2:0] alu_control; // ALU control
reg [31:0] inst; // instruction
reg [31:0] memory_read_data; // data read from the memory block

wire zero; // zero flag
wire [31:0] pc; // program counter
wire [31:0] data_out; // data to be stored in the memory
wire [31:0] alu_result; // alu result

datapath DUT (
    .clk (clk),
    .reset (reset),
    .write_enable (write_enable),
    .pc_src (pc_src),
    .alu_src (alu_src),
    .imm_src (imm_src),
    .result_src (result_src),
    .alu_control (alu_control),
    .inst (inst),
    .memory_read_data (memory_read_data),

    .zero (zero),
    .pc (pc),
    .data_out (data_out),
    .alu_result (alu_result)
);

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

// test reset then start clock
initial begin
    clk = 0;
    reset = 1;
    #10;
    reset = 0;
end

// testing outputs with I-type instruction
initial begin
    #15;
    inst = 32'b00111110100000000000000010010011; // addi x1, x0, 1000
    write_enable = 1;
    pc_src = 0;
    alu_src = 1;
    imm_src = 0;
    result_src = 0;
    alu_control = 3'b000;
    memory_read_data = 0;
    #10;
    $display("zero=%d, pc=%h, data_out=%h, alu_result=%h", zero, pc, data_out, alu_result);

    inst = 32'b11011001110000001000000100010011; // addi x2, x1, -612
    write_enable = 1;
    pc_src = 0;
    alu_src = 1;
    imm_src = 0;
    result_src = 0;
    alu_control = 3'b000;
    memory_read_data = 0;
    #10;
    $display("zero=%d, pc=%h, data_out=%h, alu_result=%h", zero, pc, data_out, alu_result);

    inst = 32'b00011000010000000000000010010011; // addi x1, x0, 388
    write_enable = 1;
    pc_src = 0;
    alu_src = 1;
    imm_src = 0;
    result_src = 0;
    alu_control = 3'b000;
    memory_read_data = 0;
    #10;
    $display("zero=%d, pc=%h, data_out=%h, alu_result=%h", zero, pc, data_out, alu_result);

    inst = 32'b00000000001000000010010000100011; // addi x3, x0, 10
    write_enable = 0;
    pc_src = 0;
    alu_src = 1;
    imm_src = 01;
    result_src = 0;
    alu_control = 3'b000;
    memory_read_data = 0;
    #10;
    $display("zero=%d, pc=%h, data_out=%h, alu_result=%d", zero, pc, data_out, alu_result);

    inst = 32'b00000000001000001000100001100011; // beq x1, x2, 20
    write_enable = 0;
    pc_src = 1;
    alu_src = 0;
    imm_src = 10;
    result_src = 0;
    alu_control = 3'b001;
    memory_read_data = 0;
    #10;
    $display("zero=%d, pc=%h, data_out=%h, alu_result=%h", zero, pc, data_out, alu_result);

end

endmodule
`default_nettype wire