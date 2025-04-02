module memoryAsync(addr,dataOut);
    parameter MEM_SIZE=256;
    parameter DATA_LENGTH=32;

    input [$clog2(MEM_SIZE)-1:0] addr;
    output [DATA_LENGTH-1:0] dataOut;

    reg [DATA_LENGTH-1:0] mem [MEM_SIZE-1:0];
    
    assign dataOut=mem[addr];

    initial begin
      $readmemb("memValues_mem",mem,0,MEM_SIZE-1);
    end


endmodule
