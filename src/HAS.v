  
//module Haft Adder Subtractor
//D = 0 --> a + b
//D = 1 --> a - b
module HAS(out, carry_bit, D, a, b);
	input D, a, b;
	output out, carry_bit;
	
	wire w1, w2;
	
	and and0(w1, D, ~a, b);
	and and1(w2, ~D, a, b);
	or or0(carry_bit, w1, w2);
	xor xor0(out, a, b);
endmodule
//