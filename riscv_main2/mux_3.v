module mux_3 (
    input [31:0]a,b,c,
    input [1:0]sel,
    output reg [31:0]y
);
    always @(*) begin
        case (sel)
            2'b00: y <= a;
            2'b01: y <= b;
            2'b10: y <= c; 
        endcase
    end
endmodule