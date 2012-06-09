module top;

reg tclk, tres;
reg [1:0] ts;
wire [1:0] tstate;

strange strange1 (ts, tclk, tres, tstate);

initial
begin

	$dumpfile("strange.vcd");
	$dumpvars(0,top);

	tclk <= 1;
	tres <= 1;
	ts <= 0;

	/**********************************/
	#2 tres <= 0;
	#2 tres <= 1;

	#4 ts <= 1;
	#2 ts <= 0;
	#4 ts <= 2;
	#2 ts <= 0;
	#2 ts <= 3;
	#2 ts <= 3;
	#2 ts <= 1;
	#10 ts <= 0;
	#4 $finish;
end
always #1 tclk <= ~tclk;

endmodule

module strange(s, clk, res, state);

input [1:0] s;
input clk, res;
output [1:0] state;
reg [1:0] state;

parameter st0=2'b00, st1=2'b01, st2=2'b10, st3=2'b11;

always @ (posedge clk or posedge res)
begin
	if(~res)
		state <= st0;
	else begin
		case(state)
			st0: if(s==1) state <= st1;
			st1: if(s==1 || s==2) state <= st2; 
			st2: if(s) state <= st3;
			st3: state <= st0;
		endcase
	end
end

endmodule
