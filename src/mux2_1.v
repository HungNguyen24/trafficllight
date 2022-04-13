//module Mux 2 to 1
//sel = 0 --> I0
//sel = 1 --> I1

module mux2_1(mux_out, sel, I0, I1);
	input sel, I0, I1;
	output mux_out;
	
	wire w1, w2;
	
	and and0(w1, ~sel, I0);
	and and1(w2, sel, I1);
	or or0(mux_out, w1, w2);
	
endmodule //