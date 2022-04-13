module TimeSrc(o, sel, ts, tl);
	output [10:0] o;
	input sel;
	input [10:0] ts, tl;
	
	assign o = sel ? tl : ts;
endmodule