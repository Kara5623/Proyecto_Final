`timescale 1ns/1ns


 module add(
	input [31:0]dato1,
	input [31:0]dato2,
	output [31:0]add
);


assign add = dato1+dato2;
   
endmodule 