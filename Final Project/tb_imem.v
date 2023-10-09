module tb_imem();
reg [5:0] addr; // address
wire [31:0] inst;  // instruction


imem DUT (
    .addr (addr), 
    .inst (inst)
); // instantiate DUT

integer i; 
initial begin
    for (i = 0; i < 10; i = i + 1) begin
        addr = $random % 64;
        #5;
    end
    $stop;
end

initial begin
    $monitor("inst=%h, addr=%d", inst, addr);
end

endmodule
`default_nettype wire