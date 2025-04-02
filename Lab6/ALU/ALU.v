module ALU(clk,operand_a,operand_b,result,opcode,zero_flag);
    parameter OPERAND_SIZE=32;
    parameter OPCODE_SIZE=8;

    input clk;

    input[OPERAND_SIZE-1:0] operand_a;
    input[OPERAND_SIZE-1:0] operand_b;
    input[OPCODE_SIZE-1:0] opcode;

    output reg[OPERAND_SIZE-1:0] result;
    output reg zero_flag;

    always@(posedge clk)
    begin
        casex(opcode)
        { {(OPCODE_SIZE-3){1'b0}},1'b0,1'b0 }:begin //0
            result<=operand_a+operand_b;
        end
        { {(OPCODE_SIZE-3){1'b0}},1'b0,1'b1 }:begin //subtraction //1
            result<=operand_a+(~operand_b+32'b1);
        end
        { {(OPCODE_SIZE-3){1'b0}},1'b1,1'b0}:begin //opa & opb //2
            result<=operand_a & operand_b;
        end
        { {(OPCODE_SIZE-3){1'b0}},1'b1,1'b1 }:begin //opa | opb //3
            result<=operand_a | operand_b; 
        end
        { {(OPCODE_SIZE-4){1'b0}},1'b1,1'b0,1'b0 }:begin// nor //4
            result<=~(operand_a | operand_b);
        end
        { {(OPCODE_SIZE-4){1'b0}},1'b1,1'b0,1'b1 }:begin //xor //5
            result<=operand_a ^ operand_b;
        end
        { {(OPCODE_SIZE-4){1'b0}},1'b1,1'b1,1'b0 }:begin // opa < opb ? 1 : 0 //6
            result<=( operand_a < operand_b ? {OPERAND_SIZE-1{1'b1}}:{OPERAND_SIZE-1{1'b0}} );
        end
        default: begin //in rest
            result<={OPERAND_SIZE{1'b0}};
        end
        endcase
        if(result==0)
                zero_flag<=1'b1;
        else
            zero_flag<=1'b0;
    end


endmodule
