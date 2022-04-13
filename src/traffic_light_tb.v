`timescale 1ns/1ps
module traffic_light_tb();
	parameter N = 11;
	parameter period = 100;
	
	wire HG, HY, HR, FG, FY, FR, ST_o, timeoff, TL_o, TS_o;
	wire [N-1:0] Timing;
	reg clk, reset, c;
	
	traffic_light traffic_light_inst(Timing, TL_o, TS_o, timeoff, HG, HY, HR, FG, FY, FR, ST_o,
		               clk, reset, c) ;
	initial begin
		clk = 0; reset = 1; c = 0;
		#period reset = 0;
		#(period*2) c = 1;
		#(period*35) c = 0;

		#(period*50) c = 1;

		#(period*100) $stop;
	end

	always #(period/2) clk = ~clk;

endmodule