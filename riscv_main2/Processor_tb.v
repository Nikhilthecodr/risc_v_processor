module Processor_tb();
reg clk,rst;
// wire [31:0] ALUresult;
wire Zflag;

Processor DUT(.clk(clk), .rst(rst), .Zflag(Zflag));

initial begin
    clk=1;rst=1;
    #6 rst = 0;
    #80 $finish;
end

always #5 clk = ~clk;
initial begin
    $dumpfile("proc.vcd");
    $dumpvars;
end

endmodule
