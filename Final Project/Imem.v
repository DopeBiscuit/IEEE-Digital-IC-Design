module Imem(
    input [5:0] addr,  // address
    output wire [31:0] inst  // instruction
    );


    reg [31:0] mem [0:63];  // memory
    
    initial begin
        $readmemh("imem.txt", mem);  // read memory from file
    end

    assign inst = mem[addr];  // assign instruction
endmodule


module tb_Imem();
reg [5:0] addr; // address
wire [31:0] inst;  // instruction


Imem DUT (
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