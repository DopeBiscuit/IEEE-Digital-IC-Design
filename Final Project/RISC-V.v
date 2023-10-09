module risc_v (
    input clk, // clock
    input reset, // reset

    output [31:0] write_data, // data to be written
    output [31:0] address, // data address
    output mem_write_enable // memory write enable
);
    
    wire [31:0] inst; // instruction
    wire [31:0] read_data; // data to be written
    wire [31:0] pc; // program counter


    processor risc (
        .clk (clk),
        .reset (reset),
        .inst (inst),
        .read_data (read_data),

        .pc (pc),
        .write_data (write_data),
        .alu_result (address),
        .mem_write (mem_write_enable)
    ); // instantiate processor

    imem imem(
        .addr (pc[7:2]),
        .inst (inst)
    ); // instantiate imem

    dmem dmem (
        .clk (clk),
        .addr (address[5:0]),
        .data_in (write_data),
        .write_enable (mem_write_enable),
        .data_out (read_data)
    ); // instantiate dmem

endmodule

module processor(
    input clk, // clock
    input reset, // reset
    input [31:0] inst, // instruction
    input [31:0] read_data, // data to be written

    output mem_write, // memory write enable
    output [31:0] write_data, // data to be written
    output [31:0] alu_result, // data address in memory & alu result
    output [31:0] pc // program counter
);

    wire [2:0] alu_control; // alu control
    wire reg_write; // write enable
    wire [1:0] imm_src; // immediate source
    wire [1:0] result_src; // Result source
    wire alu_src; // ALU source
    wire pc_src; // PC source
    wire zero; // zero flag

    controller c(
        .op_code (inst[6:0]),
        .func3 (inst[14:12]),
        .func7b5 (inst[30]),
        .zero (zero),
        .alu_control (alu_control),
        .alu_src (alu_src),
        .reg_write (reg_write),
        .mem_write (mem_write),
        .imm_src (imm_src),
        .result_src (result_src),
        .pc_src (pc_src)
    ); // instantiate controller

    datapath dp(
        .clk (clk),
        .reset (reset),
        .write_enable (reg_write),
        .pc_src (pc_src),
        .alu_src (alu_src),
        .imm_src (imm_src),
        .result_src (result_src),
        .alu_control (alu_control),
        .inst (inst),
        .memory_read_data (read_data),

        .zero (zero),
        .pc (pc),
        .data_out (write_data),
        .alu_result (alu_result)
    ); // instantiate datapath

endmodule


module tb_risc_v();

    reg clk;
    reg reset;
    wire [31:0] write_data;
    wire [31:0] address;
    wire mem_write_enable;

    risc_v risc_v(
        .clk (clk),
        .reset (reset),

        .write_data (write_data),
        .address (address),
        .mem_write_enable (mem_write_enable)
    );

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

    initial begin
        clk = 0;
        reset = 1;
        #15 reset = 0;
    end

    integer i = 0;

    always @(negedge clk) begin
        if (i < 10) begin
            $display("write_data: %h, address: %h, mem_write_enable: %h", write_data, address, mem_write_enable);
            i = i + 1;
        end else begin
            $stop;
        end
    end

endmodule
