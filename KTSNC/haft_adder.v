module haft_adder(a,b, s,c);
input wire a,b;
output wire s,c;
assign s=a^b;
assign c=a&b;
endmodule