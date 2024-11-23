`timescale 1ns/1ns

module ALU(
	input [31:0]Ope1,
	input [31:0]Ope2,
	input [2:0]AluOp,
	output reg [31:0]Resultado,
	output reg zero_flag
	);
	
always @(*)
	begin
		case (AluOp)
		3'b000: //AND
		begin
			Resultado= Ope1 & Ope2;
			zero_flag = (Resultado == 32'd0);
		end
		3'b001: //OR
		begin
			Resultado= Ope1 | Ope2;
			zero_flag = (Resultado == 32'd0);
		end
		3'b010: //ADD
		begin
			Resultado= Ope1 + Ope2;
			zero_flag = (Resultado == 32'd0);
		end
		3'b011: // XOR
		begin
			Resultado= Ope1 ^ Ope2;
			zero_flag = (Resultado == 32'd0);
		end
		3'b100: // NOR
		begin
			Resultado = ~(Ope1|Ope2);
			zero_flag = (Resultado == 32'd0);
		end
		3'b110: //SUB
		begin
			Resultado= Ope1 - Ope2;
			zero_flag = (Resultado == 32'd0);
		end
		3'b111: // SLT
		begin
			if(Ope1<Ope2)
				Resultado=32'd 1;
			else
				Resultado = 32'd0;
				zero_flag = (Resultado == 32'd0);
		end
		default: 
		begin 
		Resultado=32'd0;
		zero_flag = (Resultado == 32'd0);
		end
		endcase
	end
endmodule


