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

always @ (posedge clk or negedge res)
begin
	if(~res)
		q <= 4'b0000;
	else if(ena)
	begin
		q = q<<1;
		q[0] = si;
	end
end

endmodule
