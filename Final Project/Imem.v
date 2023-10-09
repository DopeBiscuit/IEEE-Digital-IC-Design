module imem(
    input [5:0] addr,  // address
    output wire [31:0] inst  // instruction
    );


    reg [31:0] mem [0:63];  // memory
    
    initial begin
        $readmemh("imem.txt", mem);  // read memory from file
    end

    assign inst = mem[addr];  // assign instruction
endmodule