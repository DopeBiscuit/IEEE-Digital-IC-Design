module reg_file(
    input clk, // clock
    input write_enable, // write enable
    input [31:0] data_in, // data to be written
    input [4:0] read_reg1, // register 1
    input [4:0] read_reg2, // register 2
    input [4:0] write_reg, // register to be written

    output wire [31:0] rd1, // data to be read
    output wire [31:0] rd2 // data to be read
);

    reg [31:0] registers [0:31]; // register file

    // three ported register file
    // read ports are always enabled, write port is enabled when write_enable is high
    // read ports are combinationally assigned, write port is assigned with clock edge
    // register zero is always zero


    // assign data_out1 and data_out2
    assign rd1 = (read_reg1) ? registers[read_reg1] : 0;
    assign rd2 = (read_reg2) ? registers[read_reg2] : 0;

    // assign register file
    always @(posedge clk) begin
        if (write_enable) begin
            #1;
            registers[write_reg] <= data_in;
        end
    end
endmodule