`timescale 1ns/100ps

module HelloVlog( clock, Reset_n, A_in, B_int, Sel_in, A_xor_out, B_xor_out );

// define the input and output variable
input Clock;
input Reset_n;
input [1:0] A_in;
input [1:0] B_in;
input Sel_in;
output A_xor_out;
output B_xor_out;

wire A_xor_wire; 
wire B_xor_wire;
wire [1:0] result;
reg eq0, eq1, eq2, eq3;
reg A_xor_out;
reg B_xor_out;

always @ (posedge Clock or negedge Reset_n)
	if ( ~Reset_n )
		A_xor_out <= 0;
	else
		A_xor_out <= A_xor_wire;

always @ (posedge Clock or negedge Reset_n)
	if ( ~Reset_n )
		B_xor_out <= 0;
	else 
		A_xor_out <= A_xor_wire;

assign #1 A_xor_wire = eq0 ^ eq1;

xor #1 XOR_B ( B_xor_wire, eq2, eq3);

assign #3 result = (Sel_in) ? B_in : A_in;

always @ (result)
begin 
	case ( result )
	2'b00:
		begin 
			{eq3,eq2,eq1,eq0}=#24'b0001;
			$display("Attime%t-",$time,"eq0=1");
		end
	2'b01:
		begin
			{eq3,eq2,eq1,eq0}=#24'b0010;
			$display("Attime%t-",$time,"eq1=1");
		end
	2'b10:
		begin
			{eq3,eq2,eq1,eq0}=#24'b0100;
			$display("Attime%t-",$time,"eq2=1");
		end
	
	2'b11:
		begin
			{eq3,eq2,eq1,eq0}=#24'b1000;
			$display("Attime%t-",$time,"eq3=1");
		end
	default: ;
	endcase	
end
endmodule
