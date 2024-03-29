module instr_mem(
    input reset,
    input [31:0] PC,
    output [31:0] instr
);
    reg [7:0] mem[31:0];
   
    assign instr = {mem[PC+3],mem[PC+2],mem[PC+1],mem[PC]};
   
    always @(reset)
    begin
        if(reset)
        begin
            // //00500113 addi
            // mem[3] = 8'h00;
            // mem[2] = 8'h50;
            // mem[1] = 8'h01;
            // mem[0] = 8'h13;
            
            //stack 0 FFC4A303 load
            mem[3] = 8'hFF;
            mem[2] = 8'hC4;
            mem[1] = 8'hA3;
            mem[0] = 8'h03;
            //stack 1 0064A423 Sw
            mem[7] = 8'h00;
            mem[6] = 8'h64;
            mem[5] = 8'hA4;
            mem[4] = 8'h23;
            //stack 2 0062E233 0r
            mem[11] = 8'h00;
            mem[10] = 8'h62;
            mem[9] = 8'hE2;
            mem[8] = 8'h33;
            //stack 3 FE420AE3 Beq
            mem[15] = 8'hFE;
            mem[14] = 8'h42;
            mem[13] = 8'h0A;
            mem[12] = 8'hE3;
            //stack 4 02728863 JAL
            mem[19] = 8'h02;
            mem[18] = 8'h72;
            mem[17] = 8'h88;
            mem[16] = 8'h63;
            //stack 5
            mem[23] = 8'h00;
            mem[22] = 8'h00;
            mem[21] = 8'h00;
            mem[20] = 8'h00;
            //stack 6
            mem[27] = 8'h00;
            mem[26] = 8'h00;
            mem[25] = 8'h00;
            mem[24] = 8'h00;
            //stack 7
            mem[31] = 8'h00;
            mem[30] = 8'h00;
            mem[29] = 8'h00;
            mem[28] = 8'h00;
        end
    end

endmodule