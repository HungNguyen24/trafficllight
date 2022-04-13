  
module D_ff(Qout, clk, Din);
	input clk, Din;
	output Qout;
	
	wire w1, w2, w3, w4;
	wire negQ; 				//negative Q
	
	nand nand0(w1, w4, w2);
	nand nand1(w2, w1, clk);
	nand nand2(w3, w2, clk, w4);
	nand nand3(w4, Din, w3);
	nand nand4(Qout, w2, negQ);
	nand nand5(negQ, w3, Qout);
endmodule
	//