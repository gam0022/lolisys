module select2(in, sel, out);

input [1:0] in;
input sel;
output out;

function select;

	input [1:0] in;
	input sel;
	select = sel ? in[1] : in[0];

endfunction

assign out = select(in,sel);

endmodule

module select4(in, sel, out);

input [3:0] in;
input [1:0] sel;
output out;

wire [1:0] tmp;

select2 s1(in[1:0], sel[0], tmp[0]);
select2 s2(in[3:2], sel[0], tmp[1]);
select2 s3(tmp, sel[1], out);

endmodule



/**************************************************************/
module top;

reg [3:0] in;
reg [1:0] s;


select4 sel4(in,s,y);

initial
begin

	$dumpfile("select4.vcd");
	$dumpvars(0, top);

	/**********************************/
	in = 4'b0000;
	s = 2'b00;

	#2 in = 4'b0001;

	#2  s = 2'b01;
	#2  in = 4'b0010;

	#2  s = 2'b10;
	#2  in = 4'b0100;

	#2  s = 2'b11;
	#2  in = 4'b1000;
	#2  s = 2'b00;
	$finish;
	/**********************************/
end

endmodule
