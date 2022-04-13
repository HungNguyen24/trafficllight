module traffic_light(Timing, TL_o, TS_o, timeoff, HG, HY, HR, FG, FY, FR, ST_o,
		               clk, reset, c) ;
parameter N=11;
	
output HG, HY, HR, FG, FY, FR, ST_o, timeoff, TL_o, TS_o;
output [N-1:0] Timing;
input clk, reset, c;
reg ST_o, ST;
wire tl, ts;
//wire timeoff;
reg[0:1] state, next_state ;
parameter EVEN= 0, ODD=1 ;
parameter S0= 2'b00, S1=2'b01, S2=2'b10, S3=2'b11;
assign HG = (state == S0) ;
assign HY = (state == S1) ;
assign HR = ((state == S2)||(state == S3)) ;
assign FG = (state == S2) ;
assign FY = (state == S3) ;
assign FR = ((state == S0)||(state == S1)) ;

assign TL_o = tl;
assign TS_o = ts;
//IntervalTimer(timeoff_out, Timing, TS, TL, clk, reset, ST);
IntervalTimer IntervalTimer_inst(timeoff, Timing, ts, tl, clk, reset, ST);

// flip-flops
always@ (posedge clk or posedge reset)
	if(reset)	// an asynchronous reset
		begin
			state = S0 ;
			ST_o = 0 ;
		end
	else
		begin
			state = next_state ;
			ST_o = ST ;
		end

// state transition
always@ (state or c or tl or ts) begin
	case(state)		
		S0:
			if(tl & c) begin
				next_state = S1 ;
				ST = 1 ;
			end
			else begin
				next_state = S0 ;
				ST = 0 ;
			end
		S1:
			if (ts) begin
				next_state = S2 ;
				ST = 1 ;
			end
			else begin
				next_state = S1 ;
				ST = 0 ;
			end
		S2:
			if(tl | !c) begin
				next_state = S3 ;
				ST = 1 ;
			end
			else begin
				next_state = S2 ; 
				ST = 0 ;
			end
		S3:
			if(ts) begin
				next_state = S0 ;
				ST = 1 ;
			end
			else begin
				next_state = S3 ;
				ST = 0 ;
			end
	endcase
end

endmodule