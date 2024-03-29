module dataMem(
    input clk,rst,WE,
    input [31:0] A,Wd,
    output  [31:0] Rd
    );

reg [31:0] mem [31:0];
integer i;
 
always @(rst)begin
    for(i=0;i<32;i=i+1)begin
        mem[i]<=i;
    end
end

always @(posedge clk) begin
    if(WE)begin
        mem[A]<=Wd;
    end
end

assign Rd=mem[A];

endmodule