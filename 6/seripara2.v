module top;

reg tclk, tsi, tres, tena;
wire [3:0] tq;

seripara seripara1(tclk, tsi, tres, tena, tq);

initial
begin

	$dumpfile("seripara.vcd");
	$dumpvars(0, top);

	tclk = 1'b0;
	tres = 1'b1;
	tena = 1'b0;

	#2 tres = 1'b0;
	#2 tres = 1'b1;

	tena = 1'b1;
	tsi = 1'b1;
	#2 tsi = 1'b1;
	#2 tsi = 1'b0;
	#2 tsi = 1'b0;

	#2 tena = 1'b0;
	tsi = 1'b0;

	#2 tres = 1'b0;
	#2 tres = 1'b1;

	#4 tena = 1'b1;
	tsi = 1'b0;

	#2 tsi = 1'b1;


	#2 tena = 1'b0;


	#2 tena = 1'b1;
	tsi = 1'b0;


	#2 tsi = 1'b1;

	#2 tena = 1'b0;

	#4 $finish;

end

always #1 tclk = ~tclk;

endmodule

module seripara(clk, si, res, ena, q);

input clk, si, res, ena;
output [3:0] q;

reg [3:0] q;
reg [1:0] state;

parameter st0=2'b00, st1=2'b01, st2=2'b10, st3=2'b11;

always @ (posedge clk or negedge res)
begin
	if(~res)
	begin
		state <= st3;
		q <= 4'b0000;
	end
	else if(ena)
	begin
		q[state] = si;
		state = state ? state-1 : st3;
	end
end

endmodule
