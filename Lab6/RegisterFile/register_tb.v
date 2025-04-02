module register_file_tb;
    reg clk_t;
    reg reset_t;
    reg wen_t;
    reg [4:0] ra_t;
    reg [4:0] rb_t;
    reg [4:0] rc_t;
    wire [31:0] da_t;
    wire [31:0] db_t;
    reg [31:0] dc_t; //dc e output-ul

    register_file dut(.clk(clk_t),
            .reset(reset_t),
            .wen(wen_t),
            .ra(ra_t),
            .rb(rb_t),
            .rc(rc_t),
            .da(da_t),
            .db(db_t),
            .dc(dc_t));
    
    always #5 clk_t=~clk_t;

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0,register_file_tb);
        #0
        clk_t=1'b0;
        reset_t=1'b0;
        wen_t=1'b0;
        ra_t=4'b0;
        rb_t=4'b0;
        rc_t=4'b0;
        dc_t=4'b0;

        #10
        wen_t=1'b1;
        rc_t=4'd1; //scriu la adresa 1,
        dc_t=32'd12; //pe numarul 12

        #10
        wen_t=1'b0;
        rc_t=4'b0;
        dc_t=32'b0;

        ra_t=4'd1;//citesc de la adresa 1

        #10
        $finish;
    end

endmodule
