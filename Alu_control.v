/*`timescale 1ns/1ns
module ALUControl(
    input [2:0] AluOp,         
    input [5:0] FuncCode,     
    output reg [2:0] ALUCtrl   
);

always @(*) begin
    case (AluOp)
        3'b000: begin             
            case (FuncCode)
                6'b100000: ALUCtrl = 3'b010; // ADD
                6'b100010: ALUCtrl = 3'b110; // SUB
                6'b100100: ALUCtrl = 3'b000; // AND
                6'b100101: ALUCtrl = 3'b001; // OR
                6'b100110: ALUCtrl = 3'b011; // XOR
                6'b100111: ALUCtrl = 3'b100; // NOR
                6'b101010: ALUCtrl = 3'b111; // SLT
				3'b000: ALUCtrl = 3'b010; //sw y lw
				3'b001: ALUCtrl = 3'b110; //BEQ
				3'b011: ALUCtrl = 3'b000; //ANDI
				3'b100: ALUCtrl = 3'b111; //SLTI
				3'b101: ALUCtrl = 3'b001;//ORI
				
                default:   ALUCtrl = 3'b000; // Valor por defecto
            endcase
        end
        default: ALUCtrl = 3'b000;
    endcase
end

endmodule*/
/*`timescale 1ns/1ns

module ALUControl(
    input [2:0] AluOp,
    input [5:0] FuncCode,
    output reg [2:0] ALUCtrl
);

always @(*) begin
    case (AluOp)
        3'b000: begin             
            case (FuncCode)
                6'b100000: ALUCtrl = 3'b010; // ADD
                6'b100010: ALUCtrl = 3'b110; // SUB
                6'b100100: ALUCtrl = 3'b000; // AND
                6'b100101: ALUCtrl = 3'b001; // OR
                6'b100110: ALUCtrl = 3'b011; // XOR
                6'b100111: ALUCtrl = 3'b100; // NOR
                6'b101010: ALUCtrl = 3'b111; // SLT
                default:   ALUCtrl = 3'b000; // Valor por defecto
            endcase
        end
        3'b001: ALUCtrl = 3'b110; // BEQ
        3'b011: ALUCtrl = 3'b000; // ANDI
        3'b100: ALUCtrl = 3'b111; // SLTI
        3'b101: ALUCtrl = 3'b001; // ORI
        default: ALUCtrl = 3'b000; // Valor por defecto
    endcase
end

endmodule*/

`timescale 1ns/1ns

module ALUControl(
    input [2:0] AluOp,
    input [5:0] FuncCode,
    output reg [2:0] ALUCtrl
);

always @(*) begin
    case (AluOp)
        3'b000: begin             
            // Tipo R: Decide operación basada en FuncCode
            case (FuncCode)
                6'b100000: ALUCtrl = 3'b010; // ADD
                6'b100010: ALUCtrl = 3'b110; // SUB
                6'b100100: ALUCtrl = 3'b000; // AND
                6'b100101: ALUCtrl = 3'b001; // OR
                6'b100110: ALUCtrl = 3'b011; // XOR
                6'b100111: ALUCtrl = 3'b100; // NOR
                6'b101010: ALUCtrl = 3'b111; // SLT
                default:   ALUCtrl = 3'b000; // Valor por defecto
            endcase
        end
        3'b001: ALUCtrl = 3'b110; // BEQ (Resta para comparar)
        3'b010: ALUCtrl = 3'b010; // ADDI, LW y SW (Suma para dirección de memoria)
        3'b011: ALUCtrl = 3'b000; // ANDI (lógica AND inmediata)
        3'b100: ALUCtrl = 3'b111; // SLTI (Set Less Than Immediate)
        3'b101: ALUCtrl = 3'b001; // ORI (lógica OR inmediata)
        default: ALUCtrl = 3'b000; // Valor por defecto
    endcase
end

endmodule

