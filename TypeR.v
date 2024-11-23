`timescale 1ns/1ns
module TypeR(
	input clk, reset    
);
wire [31:0]Mux_out;
wire [31:0]Add_in;
wire [31:0]Add;
wire [31:0]mem_inst;
wire RegDst_to_Mux;
wire [4:0]Mux_to_BR;
wire [31:0] d1BR_op1Alu;
wire [31:0] d2BR_op2Alu;
wire [31:0] DatoMem2BR;
wire [31:0]Sign_to_Shift;//Sign Extend a Shift_left_2
wire [31:0] Shift_AddALU;
wire AND_To_Sel;
wire AddALU_to_Mux;
wire Branch_to_AND;
wire Zero_to_AND;
wire ALUSrc_to_Mux;
wire [31:0]Mux_to_ALU;
wire BR_enabler;
wire [2:0] AluOp;
wire MemW;
wire MemR;
wire Mem_to_BR;

wire [31:0] MemD;

wire [2:0] ALUCtrl;
wire [31:0] ResAlu;

PC inst (
	.clk(clk),
	.reset(reset),
	.pc_in(Mux_out),
	.pc_out(Add_in)
	);
	
add Add_inst(
	.dato1(Add_in),
	.dato2(32'd4),
	.add(Add)
);

MuxAdd uut_inst(
	.sel(AND_To_Sel),
	.A(Add),
	.B(AddALU_to_Mux),
	.C(Mux_out)
	);
	
AND duv_inst(
	.A(Branch_to_AND),
	.B(Zero_to_AND),
	.S(AND_To_Sel)
);
	
Memoria_Instrucciones mem(
	.Direccion(Add_in),
	.Instruccion(mem_inst)

);

U_Control UC (
	.OpCode(mem_inst[31:26]),
	.RegDst(RegDst_to_Mux),
	.Branch(Branch_to_AND),
    .BR_En(BR_enabler),
    .AluC(AluOp),    // Cambiamos ALUCtrl a AluOp
    .EnW(MemW),
    .EnR(MemR),
    .Mux1(Mem_to_BR),
	.ALUSrc(ALUSrc_to_Mux)
);

// Añadir el módulo ALUControl para convertir AluOp y FuncCode en ALUCtrl
ALUControl AC (
    .AluOp(AluOp),
    .FuncCode(mem_inst[5:0]), // Campo funct de instrucciones tipo R
    .ALUCtrl(ALUCtrl)
);
MuxBR duv_MBR(
	.sel(RegDst_to_Mux),
	.A(mem_inst[20:16]),
	.B(mem_inst[15:11]),
	.C(Mux_to_BR)
);


Banco instBanco (
    .DL1(mem_inst[25:21]),
    .DL2(mem_inst[20:16]),
    .DE(Mux_to_BR),
    .Dato(DatoMem2BR),
    .WE(BR_enabler),
	.clk(clk),
    .op1(d1BR_op1Alu),
    .op2(d2BR_op2Alu)
);

Sign_Extend Sign_inst(
	.in(mem_inst[15:0]),
	.out(Sign_to_Shift)
);

Shift_left_2 duv_shift(
		.in(Sign_to_Shift),
		.out(Shift_AddALU)
);

Add_ALURes uut_AddALU(
	.A(Add),
	.B(Shift_AddALU),
	.Res(AddALU_to_Mux)
);

MuxALU MXALU(
	.sel(ALUSrc_to_Mux),
	.A(d2BR_op2Alu),
	.B(Sign_to_Shift),
	.C(Mux_to_ALU)
);

ALU instALU (
    .Ope1(d1BR_op1Alu),
    .Ope2(Mux_to_ALU),
    .AluOp(ALUCtrl),   // Aquí usamos ALUCtrl generado por ALUControl
    .Resultado(ResAlu),
	.zero_flag(Zero_to_AND)
);

RAM duv_mem(
	.Datoin(d2BR_op2Alu),
	.Dir(ResAlu),
	.WE(MemW),
	.RE(MemR),
	.clk(clk),
	.Datoout(MemD)
);


mux2_1 mux1 (
    .sel(Mem_to_BR),
    .A(MemD),
    .B(ResAlu),
    .C(DatoMem2BR)
);

endmodule
