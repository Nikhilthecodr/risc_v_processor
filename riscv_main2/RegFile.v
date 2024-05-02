module RegFile (
    input WE3, clk, rst,
    input [4:0] A1,A2,A3,
    input [31:0] WD3,
    output [31:0] RD1, RD2
);

reg [31:0]Registers[31:0];
integer i;

always @(rst) begin
    for (i = 0; i < 32; i = i + 1) begin
        Registers[i] <= i;
    end  
end

always @(posedge clk) begin   
    if(WE3) begin
        Registers[A3] <= WD3;
    end 
end

assign RD1 = Registers[A1];
assign RD2 = Registers[A2];

endmodule