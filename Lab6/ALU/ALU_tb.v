module ALU_tb;
    parameter OPERAND_SIZE_T=32;
    parameter OPCODE_SIZE_T=8;
    reg clk_t;
    reg[OPERAND_SIZE_T-1:0] operand_a_t;
    reg[OPERAND_SIZE_T-1:0] operand_b_t;
    reg[OPCODE_SIZE_T-1:0] opcode_t;
    wire[OPERAND_SIZE_T-1:0] result_t;
    wire zero_flag_t;

    ALU #(.OPERAND_SIZE(OPERAND_SIZE_T),.OPCODE_SIZE(OPCODE_SIZE_T)) myALU(
        .clk(clk_t),
        .operand_a(operand_a_t),
        .operand_b(operand_b_t),
        .opcode(opcode_t),
        .result(result_t),
        .zero_flag(zero_flag_t)
    );

    always #2 clk_t=~clk_t;

    initial
    begin
        $dumpfile("waveform.vcd");
        $dumpvars(0,ALU_tb);
        #0
            clk_t=1'b0;
            operand_a_t={OPERAND_SIZE_T{1'b0}};
            operand_b_t={OPERAND_SIZE_T{1'b0}};
            opcode_t={OPCODE_SIZE_T{1'b0}};
        #10 //testing sum //1,11,0
            operand_a_t={ {(OPERAND_SIZE_T-1){1'b0}},1'b1 };
            operand_b_t={ {(OPERAND_SIZE_T-2){1'b0}},1'b1,1'b1};
            opcode_t={OPCODE_SIZE_T{1'b0}};
        #10 //testing diff //10,101,1
            operand_a_t={ {(OPERAND_SIZE_T-3){1'b0}},1'b1,1'b0 };
            operand_b_t={ {(OPERAND_SIZE_T-4){1'b0}},1'b1,1'b0,1'b1};
            opcode_t={ {(OPCODE_SIZE_T-1){1'b0}},1'b1};
        #10 //testing and bitwise //11010,01100,10
            operand_a_t={ {(OPERAND_SIZE_T-5){1'b0}},5'b11010 };
            operand_b_t={ {(OPERAND_SIZE_T-5){1'b0}},5'b01100};
            opcode_t={ {(OPERAND_SIZE_T-2){1'b0}},2'b10 };
        #10 //teting or bitwise //11
            opcode_t={ {(OPCODE_SIZE_T-2){1'b0}},2'b11}; 
        #10 //testing nor bitwise //100
            opcode_t={ {(OPCODE_SIZE_T-3){1'b0}},3'b100};
        #10//testing xor bitwise
            opcode_t={ {(OPCODE_SIZE_T-3){1'b0}},3'b101};
        #10 //testing set if less than
            opcode_t={ {(OPCODE_SIZE_T-3){1'b0}},3'b110};
        #10
            $finish;
    end

endmodule
