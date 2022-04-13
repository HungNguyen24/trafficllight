`timescale 1ns/1ps
module haft_adder_tb();
reg [1:0] a,b;
wire [1:0] s,c;
localparam period=20;
haft_adder ha1(.a(a[1]), .b(b[1]), .s(s[1]), .c(c[1]));
haft_adder ha2(.a(a[0]), .b(b[0]), .s(s[0]), .c(c[0]));
initial
begin
a=00;b=2'b10;
#period;
a=2'b01;b=2'b11;
#period;
a=2'b10;b=2'b01;
#period;
end
endmodule