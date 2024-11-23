`timescale 1ns/1ns

module U_Control(
	input [5:0]OpCode, 
	output reg RegDst,
	output reg Branch,
	output reg BR_En, //RegWrite
	output reg [2:0]AluC,
	output reg	EnW, //to Write MemDatos
	output reg	EnR, //to Read MemDatos
	output reg Mux1, //Mux ALU o mem -> BR //Mem to Reg
	output reg ALUSrc
);

always @(*)
	begin 
		case (OpCode)
		6'b000000: //Inst tipo R
			begin
				RegDst = 1'b1;
				Branch = 1'b0;
				BR_En= 1'b1;
				AluC=3'b000;
				EnW=1'b0;
				EnR=1'b0;
				Mux1=1'b1;
				ALUSrc = 1'b0;
			end
			
		6'b001000: //Inst ADDI (suma inmediata)
			begin
				RegDst = 1'b 0;
				Branch = 1'b 0;
				EnR = 1'b 0;
				Mux1 = 1'b 0;
				AluC = 3'b 010;
				EnW = 1'b 0;
				ALUSrc = 1'b 1;
				BR_En = 1'b 1;
				/*BR_En= 1'b0;
				AluC=3'b010;
				EnW=1'b1;
				EnR=1'b0;
				Mux1=1'b0;*/
			end
			//LW
	6'b 100011:
		begin
			RegDst = 1'b 0;
			Branch = 1'b 0;
			EnR = 1'b 1;
			Mux1 = 1'b 0;
			AluC = 3'b 010;//antes 000
			EnW = 1'b 0;
			ALUSrc = 1'b 1;
			BR_En = 1'b 1;
		end
		//SW
	6'b 101011:
		begin
			RegDst = 1'b 0;
			Branch = 1'b 0;
			EnR = 1'b 0;
			Mux1 = 1'b 0;
			AluC = 3'b 010;//antes 000
			EnW = 1'b 1;
			ALUSrc = 1'b 1;
			BR_En = 1'b 0;
			
			
		end
		
	//BEQ
	6'b 000100:
		begin
			RegDst = 1'b 1;
			Branch = 1'b 1;
			EnR = 1'b 0;
			Mux1 = 1'b 0;
			AluC = 3'b 001;
			EnW = 1'b 0;
			ALUSrc = 1'b 0;
			BR_En = 1'b 0;
			
		end
		//STLI
	6'b 001010:
		begin
			RegDst = 1'b 0;
			Branch = 1'b 0;
			EnR = 1'b 0;
			Mux1 = 1'b 0;
			AluC = 3'b 100;
			EnW = 1'b 0;
			ALUSrc = 1'b 1;
			BR_En = 1'b 1;
			
		end
		
	//ANDI
	6'b 001100:
		begin
			RegDst = 1'b 0;
			Branch = 1'b 0;
			EnR = 1'b 0;
			Mux1 = 1'b 0;
			AluC = 3'b 011;
			EnW = 1'b 0;
			ALUSrc = 1'b 1;
			BR_En = 1'b 1;
			
		end
		
	//ORI
	6'b 001101:
		begin
			RegDst = 1'b 0;
			Branch = 1'b 0;
			EnR = 1'b 0;
			Mux1 = 1'b 0;
			AluC = 3'b 101;
			EnW = 1'b 0;
			ALUSrc = 1'b 1;
			BR_En = 1'b 1;
			
		end
			default: begin
			RegDst = 1'b 0;
			Branch = 1'b 0;
			EnR = 1'b 0;
			Mux1 = 1'b 0;
			AluC = 3'b 000;
			EnW = 1'b 0;
			ALUSrc = 1'b 0;
			BR_En = 1'b 0;
			end
			endcase
	end
	
endmodule

