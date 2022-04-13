module IntervalTimer(timeoff_out, Timing, TS, TL, clk, reset, ST);
	parameter S0= 3'b000, S1=3'b001, S2=3'b010, S3=3'b011, S4=3'b100;
	parameter N=11;
	
	output [N-1:0] Timing;
	output reg TS, TL;
	input clk, reset, ST;

	reg [2:0] state, next_state;
	wire timeoff;
	
	//State
	always @(posedge clk or posedge reset) begin
		if(reset) begin
			state = S0;
		end
		else state = next_state;
	end
	
	//Next State
	always @(state or timeoff or ST) begin
		case (state)
			S0:
				if(ST)
					begin
						 next_state = S1;
					end
				else 
					begin
						 next_state = S0;
					end
			S1:
				if(timeoff)
					begin
						 next_state = S2;
					end
				else 
					begin
						 next_state = S1;
					end
			S2:
				if(timeoff)
					begin
						 next_state = S3;
					end
				else 
					begin
						 next_state = S2;
					end
			S3:
				if(timeoff)
					begin
						 next_state = S4;
					end
				else 
					begin
						 next_state = S3;
					end
			S4:
				if(timeoff)
					begin
						 next_state = S0;
					end
				else 
					begin
						 next_state = S4;
					end
		endcase
	end
	
	
	//Output
	always @(state) begin
		case (state)
			S0:
				begin
					TS = 1;
					TL = 1;
				end
			S1:
				begin
					TS = 0;
					TL = 1;
				end
			S2:
				begin
					TS = 1;
					TL = 0;
				end
			S3:
				begin
					TS = 0;
					TL = 1;
				end
			S4:
				begin
					TS = 1;
					TL = 0;
				end
		endcase
	end
	
	wire [10:0] timeSrc_out;
	//TimeSrc(o, sel, ts, tl);
	TimeSrc TimeSrc_inst(timeSrc_out, !TL, 11'd3, 11'd7);
	
	output timeoff_out;
	assign timeoff_out = timeoff;
	//TrafficLightCounter(Switch, OUT, clk, load, En, D, value);
	TrafficLightCounter TrafficLightCounter_inst(timeoff, Timing, clk, ST, 1'b1, 1'b1, timeSrc_out);
endmodule