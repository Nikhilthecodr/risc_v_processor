module controlUnit (
    input [2:0] funct3,
    input [6:0] funct7,
    input [6:0] op,
    input Zflag,
    output reg [3:0] ALUcontrol,
    output reg [1:0] ImmSrc, ResultSrc,
    output reg reg_write, mem_write,
    output reg ALUSrc, PCsrc
);

reg branch;
reg jump;

localparam [6:0]R_TYPE  = 7'b0110011,
                I_TYPE  = 7'b0010011,
                STORE   = 7'b0100011,
                LOAD    = 7'b0000011,
                BRANCH  = 7'b1100011,
                JALR    = 7'b1100111,
                JAL     = 7'b1101111,
                AUIPC   = 7'b0010111,
                LUI     = 7'b0110111;

always @(funct3,funct7,op,Zflag) begin
    case (op)
        //R-Type instruction
        R_TYPE :begin
            reg_write <= 1;
            mem_write <= 0;
            ALUSrc <= 0;
            ResultSrc <= 2'b00;
            PCsrc <= 0;
            case (funct3)
                0: begin
                    if (funct7 == 7'd32) begin
                        ALUcontrol <= 4'b0001;
                    end
                    else ALUcontrol <= 4'b0000;
                end
                7: ALUcontrol <= 4'b0010;
                6: ALUcontrol <= 4'b0011;
                1: ALUcontrol <= 4'b0100;
                5: ALUcontrol <= 4'b0101;
                4: ALUcontrol <= 4'b0111;
                2: ALUcontrol <= 4'b1000; 
            endcase
        end

        LOAD :begin
            mem_write<=0;
            reg_write<=1;
            ALUcontrol<=4'b0000;
            ImmSrc<=2'b00;
            ALUSrc<=1;
            ResultSrc<=2'b01;
            PCsrc <= 0;
        end

        STORE :begin
            mem_write<=1;
            reg_write<=0;
            ALUcontrol<=4'b0000;
            ImmSrc<=2'b01;
            ALUSrc<=1;
            PCsrc <= 0;
            // ResultSrc<=1;
        end

        BRANCH :begin
            mem_write<=0;
            reg_write<=0;
            ALUcontrol<=4'b0001;
            ImmSrc<=2'b10;
            ALUSrc<=0;
            branch <= 1;
            PCsrc <= branch | Zflag;
            // ResultSrc<=1;
        end

        JAL :begin
            mem_write<=0;
            reg_write<=1;
            // ALUcontrol<=4'b0000;
            ImmSrc<=2'b11;
            // ALUSrc<=0;
            branch <= 0;
            jump<=1;
            PCsrc <= jump;
            ResultSrc<=2'b10;
        end

        I_TYPE :begin
            reg_write <= 1;
            mem_write <= 0;
            ImmSrc<=2'b00;
            ALUSrc <= 1;
            ResultSrc <= 2'b00;
            PCsrc <= 0;
            case (funct3)
                0: ALUcontrol <= 4'b0000; //addi 
                1: ALUcontrol <= 4'b0100; //slli shift left imm 
                2: ALUcontrol <= 4'b1000; //slti set less than imm
                4: ALUcontrol <= 4'b0111; //xori xor imm
                5: ALUcontrol <= 4'b0101; //srli shift right imm
                6: ALUcontrol <= 4'b0011; //ori or imm
                7: ALUcontrol <= 4'b0010; //andi and imm                
            endcase
        end
    endcase
end
endmodule