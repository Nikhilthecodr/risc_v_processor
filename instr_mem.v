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
            {mem[3],mem[2],mem[1],mem[0]} = 32'h00500113; //addi x2,x0,5 #x2 = 5
            {mem[7],mem[6],mem[5],mem[4]} = 32'h00C00193; //addi x3,x0,12 #x3 = 12
            {mem[11],mem[10],mem[9],mem[8]} = 32'hFF718393; //addi x7,x3,-9 #x7 = (12 - 9) = 3
            {mem[15],mem[14],mem[13],mem[12]} = 32'h0023E233;//or x4,x7,x2 #x4 = (3 OR 5) = 7
            {mem[19],mem[18],mem[17],mem[16]} = 32'h0041F2B3; //and x5,x3,x4 #x5 = (12 AND 7) = 4
            {mem[23],mem[22],mem[21],mem[20]} = 32'h004282B3; //add x5,x5,x4 #x5 = 4 + 7 = 11
            {mem[27],mem[26],mem[25],mem[24]} = 32'h02728863; //beq x5,x7,end #shouldn't be taken
            {mem[31],mem[30],mem[29],mem[28]} = 32'h0041A233; //slt x4,x3,x4 #x4 = (12 < 7) = 0
//            {mem[35],mem[34],mem[33],mem[32]} = 32'hFFC4A303;
//            {mem[3],mem[2],mem[1],mem[0]} = 32'hFFC4A303;
//            {mem[3],mem[2],mem[1],mem[0]} = 32'hFFC4A303;
//            {mem[3],mem[2],mem[1],mem[0]} = 32'hFFC4A303;
//            {mem[3],mem[2],mem[1],mem[0]} = 32'hFFC4A303;
//            {mem[3],mem[2],mem[1],mem[0]} = 32'hFFC4A303;
//            {mem[3],mem[2],mem[1],mem[0]} = 32'hFFC4A303;
         
        end
    end

endmodule
