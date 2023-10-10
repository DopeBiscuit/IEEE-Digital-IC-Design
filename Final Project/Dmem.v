module dmem (
    input clk,  // clock
    input wire [5:0] addr,  // address
    input wire [31:0] data_in,  // data to be written
    input wire write_enable,  // write enable
    output wire [31:0] data_out  // data to be read
    );

    reg [31:0] mem [0:63];  // memory

    assign data_out = mem[addr];  // assign data_out

    // print data to memory
    always @(posedge clk) begin
        if (write_enable) begin
            mem[addr] <= data_in;
        end
    end

endmodule

