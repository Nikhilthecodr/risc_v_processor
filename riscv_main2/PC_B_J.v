module PC_B_J (
    input [31:0] PCin, ImmExtIn,
    output reg [31:0] PCTarget
);
    always @(*) begin
        PCTarget <= PCin + ImmExtIn;
    end
endmodule