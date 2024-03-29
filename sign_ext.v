module sign_extend(
    input [31:0]InstrD,
    input [1:0]ImmSrcD,
    output reg [31:0]ImmExtD
);

reg [6:0]opcode;

localparam [6:0]R_TYPE  = 7'b0110011,
                I_TYPE  = 7'b0010011,
                STORE   = 7'b0100011,
                LOAD    = 7'b0000011,
                BRANCH  = 7'b1100011,
                JALR    = 7'b1100111,
                JAL     = 7'b1101111,
                AUIPC   = 7'b0010111,
                LUI     = 7'b0110111;

always@(*) begin
    opcode = InstrD[6:0];
    case (ImmSrcD)
        // for I-type InstrDuction
        2'b00: begin
            ImmExtD = {{20{InstrD[31]}},InstrD[31:20]} ;
        end
        // for S-type and B-type InstrDuction
        2'b01: begin
            ImmExtD = {{20{InstrD[31]}},InstrD[31:25],InstrD[11:7]} ;
        end

        2'b10: begin
            ImmExtD = {{20{InstrD[31]}}, InstrD[7], InstrD[30:25], InstrD[11:8], 1'b0};
        end

        2'b10: begin
            ImmExtD = {{12{InstrD[31]}}, InstrD[19:12], InstrD[20], InstrD[30:21], 1'b0};
        end
        default: begin
            case (opcode)
                // R-type intsruction doesn't have any immediate value
                R_TYPE: begin
                    ImmExtD = 32'b00;
                end
                // for jump link and jump link register InstrDuctions
                // (JALR & JAL): begin
                //     ImmExtD = {{10{InstrD[31]}},InstrD[31:12]};
                // end
            endcase
        end
    endcase
end

endmodule