module Dmem (
    input clk,  // clock
    input wire [5:0] addr,  // address
    input wire [31:0] data_in,  // data to be written
    input wire write_enable,  // write enable
    output wire [31:0] data_out  // data to be read
    );

    reg [31:0] mem [0:63];  // memory

    initial begin
        $readmemh("imem.txt", mem);  // read memory from file
    end

    assign data_out = mem[addr];  // assign data_out

    // print data to memory
    always @(posedge clk) begin
        if (write_enable) begin
            mem[addr] <= data_in;
            $display("Memory Address: %d, Data: %h", addr, mem[addr]);
        end
    end

endmodule

module tb_Dmem;
reg clk;
reg [5:0] addr;
reg [31:0] data_in;
reg write_enable;
wire [31:0] data_out;

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

Dmem DUT (
    .clk (clk),
    .addr (addr),
    .data_in (data_in),
    .write_enable (write_enable),
    .data_out (data_out)
); // instantiate DUT

integer i;
initial begin
    clk = 0;
    for (i = 0; i < 10; i = i + 1) begin
        addr = $random % 64;
        data_in = $random;
        write_enable = $random % 2;
        #10;
        $display("addr=%d, data_in=%h, write_enable=%d, data_out=%h", addr, data_in, write_enable, data_out);
    end
    $stop;
end

endmodule
`default_nettype wire