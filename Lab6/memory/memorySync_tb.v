
module memory_tb;
    parameter DATA_LENGTH = 8;
    parameter MEM_SIZE = 1024;
    
    reg clk;
    reg wen;
    reg [$clog2(MEM_SIZE)-1:0] addr;
    reg [DATA_LENGTH-1:0] din;
    wire [DATA_LENGTH-1:0] dout;
    
    memory #(.DATA_LENGTH(DATA_LENGTH), .MEM_SIZE(MEM_SIZE)) uut (
        .clk(clk),
        .wen(wen),
        .addr(addr),
        .din(din),
        .dout(dout)
    );
    
    always #5 clk = ~clk;
    
    initial begin
        
        $dumpfile("waveform.vcd");
        $dumpvars(0, memory_tb);
        
        clk = 0;
        wen = 0;
        addr = 0;
        din = 0;
        
        #10;
        
        addr = 10; #10;
        wen = 1;
        addr = 10;
        din = 8'hA5; #10;
        
        wen = 0; #10;
        
        addr = 20; #10;
        
        #20;
        $finish;
    end
endmodule
