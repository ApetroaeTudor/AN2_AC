module register_file(clk,reset,wen,ra,rb,rc,da,db,dc);
    //ra arata care dintre cele 32 de registe interne e citit
    //si trimis la iesirea da
    //deci ra este adresa de citire a
    input clk;
    input reset;
    input wen;
    input [4:0] ra; //2^5=32; poate adresa orice registru din memorie
    input [4:0] rb;
    input [4:0] rc;
    output [31:0] da;
    output [31:0] db;
    input [31:0] dc;
    integer i;

    reg [31:0] mem[31:0];

    assign da = (ra!=5'b0) ? mem[ra] : 32'b0;
    assign db = (rb!=5'b0) ? mem[rb] : 32'b0;

    always@(posedge clk)
    begin
      if(reset==1'b1) begin
            for(i=0;i<32;i=i+1) begin
                mem[i]<=32'b0;
            end
        end
      else
        begin 
            if(wen==1'b1)
                mem[rc]<=dc;
        end
      
    end
endmodule
