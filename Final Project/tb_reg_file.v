module tb_reg_file();
reg clk;

wire [31:0] rd1;
wire [31:0] rd2;

reg [31:0] data_in;
reg [4:0] read_reg1;
reg [4:0] read_reg2;
reg [4:0] write_reg;
reg write_enable;

reg_file DUT (
    .clk (clk),
    .write_enable (write_enable),
    .data_in (data_in),
    .read_reg1 (read_reg1),
    .read_reg2 (read_reg2),
    .write_reg (write_reg),
    .rd1 (rd1),
    .rd2 (rd2)
); // instantiate DUT


localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

integer i; // loop variable

initial begin
    clk = 0;

    for (i = 0; i < 10; i = i + 1) begin
        data_in = $random;
        read_reg1 = $random % 32;
        read_reg2 = $random % 32;
        write_reg = $random % 32;
        write_enable = $random % 2;
        #10;
        $display("data_in=%h, read_reg1=%d, read_reg2=%d, write_reg=%d, write_enable=%d, rd1=%h, rd2=%h", data_in, read_reg1, read_reg2, write_reg, write_enable, rd1, rd2);
        if (write_enable) 
            $display("registers[%d]=%h", write_reg, data_in);
    end

end

endmodule
