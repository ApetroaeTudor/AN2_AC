module memory(
    input   clk,
    input   wen,
    input   [$clog2(MEM_SIZE)-1:0]  addr,
    input   [DATA_LENGTH-1:0]       din,
    output  [DATA_LENGTH-1:0]       dout
    );

    parameter 	DATA_LENGTH  = 8;
    parameter 	MEM_SIZE     = 1024;
    
    reg [DATA_LENGTH:0] mem [0:MEM_SIZE-1];

    // read operation behavior
    assign dout = mem[addr];
    
    // write operation behavior
    always @(posedge clk) begin
        if (wen == 1) begin
            mem[addr] <= din;
        end
    end
    
    // memory content initialization from file
    initial begin
        $readmemh( "memory_data.mem", mem, 0, MEM_SIZE-1);
    end
    
endmodule
