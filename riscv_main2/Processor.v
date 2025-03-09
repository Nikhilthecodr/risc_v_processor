`include "inst_control.v"
`include "DataPath.v"
`include "controlUnit.v"
`include "dataMem.v"
`include "mux_3.v"
`include "mux_2.v"


module Processor (
    input clk, rst,
    output Zflag 
);

wire [31:0] ALUresult;
wire [31:0]instr;
wire [3:0] ALUcontrol;
wire reg_write, mem_write, Zflag;
// wire [31:0] srcA, srcB;
wire [1:0]ImmSrc,ResultSrc;
// wire [31:0]ImmExt;
wire [31:0]WriteData;
wire [31:0]ReadData;

wire PCsrc;
wire [31:0]PCTarget;
wire [31:0] PCplus4, PC;
wire [2:0] load;
wire [1:0] store;
wire [31:0] read_data_mem;
wire [31:0]Result;
wire [31:0] write_data_mem;
wire ALUR31;

inst_control inst_path(
    .clk(clk), 
    .rst(rst),
    .PCsrc(PCsrc),
    .PCTarget(PCTarget),
    .instr(instr),
    .PCplus4(PCplus4),
    .PC(PC)
    );

DataPath datapath(
    .clk(clk), 
    .rst(rst),
    .instr(instr),
    .PC(PC),
    .Result(Result),
    .reg_write(reg_write),
    .ALUSrc(ALUSrc),
    .ImmSrc(ImmSrc),
    .ALUcontrol(ALUcontrol),
    .Zflag(Zflag),
    .ALUresult(ALUresult),
    .PCTarget(PCTarget),
    .WriteData(WriteData),
    .ALUR31(ALUR31)
);

controlUnit contr_path(
    .funct3(instr[14:12]),
    .funct7(instr[31:25]),
    .op(instr[6:0]),
    .Zflag(Zflag),
    .ALUcontrol(ALUcontrol),
    .ImmSrc(ImmSrc),
    .ResultSrc(ResultSrc),
    .reg_write(reg_write),
    .mem_write(mem_write),
    .ALUSrc(ALUSrc),
    .PCsrc(PCsrc),
    .load(load),
    .store(store),
    .ALUR31(ALUR31)
);

dataMem d_path(
    .clk(clk), 
    .rst(rst),
    .WE(mem_write), 
    .A(ALUresult), 
    .Wd(write_data_mem), 
    .Rd(ReadData)
    );

store_extend strext(
        .y(WriteData),
        .sel(store),
        .data(write_data_mem)
    );

load_extend ldext(
    .y(ReadData),
    .sel(load),
    .data(read_data_mem)
    );

mux_3 result_sel(
    .a(ALUresult),
    .b(read_data_mem), //result
    .c(PCplus4),
    .sel(ResultSrc),
    .y(Result)
);
endmodule