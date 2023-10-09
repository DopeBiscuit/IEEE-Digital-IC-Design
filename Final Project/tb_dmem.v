module tb_dmem;
reg clk;
reg [5:0] addr;
reg [31:0] data_in;
reg write_enable;
wire [31:0] data_out;

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

dmem DUT (
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