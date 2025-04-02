module memoryAsync_tb;
    parameter MEM_SIZE_T=256;
    parameter DATA_LENGTH_T=32;

    reg [$clog2(MEM_SIZE_T)-1:0] addr_t;
    wire [DATA_LENGTH_T-1:0] dataOut_t;

    memoryAsync #(.DATA_LENGTH(DATA_LENGTH_T),.MEM_SIZE(MEM_SIZE_T)) dut (
        .addr(addr_t),
        .dataOut(dataOut_t)
    );

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0,memoryAsync_tb);

        #0
        addr_t=8'd0;
        #10
        addr_t=8'd1;
        #10
        addr_t=8'd2;
        #10
        $finish;
    end
endmodule
