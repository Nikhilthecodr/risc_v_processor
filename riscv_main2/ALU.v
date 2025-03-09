/*
ALUC | OP
0000     add
0001     sub
0010     and
0011     or
0100     lsl (logical shift left)
0101     lsr
0110     mul
0111     xor
1000     slt (set 1 if less than)
*/

module ALU (
    input [31:0] rs1, rs2,
    input [3:0] ALUcontrol,
    output reg [31:0] ALUresult,
    output Zflag
);

always @(*) begin
    case (ALUcontrol)
        4'b0000: ALUresult = rs1 + rs2;
        4'b0001: ALUresult = rs1 - rs2;
        4'b0010: ALUresult = rs1 & rs2;
        4'b0011: ALUresult = rs1 | rs2;
        4'b0100: ALUresult = rs1 << rs2;
        4'b0101: ALUresult = rs1 >> rs2;
        4'b0110: ALUresult = rs1 * rs2;
        4'b0111: ALUresult = rs1 ^ rs2;
        4'b1000: ALUresult = (rs1<rs2)?1:0;
        default: ALUresult = 32'd0;
    endcase
end
assign Zflag = (ALUresult==0)?1:0;  
endmodule