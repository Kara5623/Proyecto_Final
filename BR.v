/*`timescale 1ns/1ns
//Definicion del modulo

module Banco(
    input [4:0] DL1,
    input [4:0] DL2,
    input [4:0] DE,
    input [31:0] Dato,
    input WE,
    output reg [31:0] op1,
    output reg [31:0] op2
);

// Definir (mem)registro bidimensional
reg [31:0] BR [31:0];

initial
	begin
		$readmemb("BR.txt",BR);
	end

always @(*) 
	begin
    if (WE) begin
        BR[DE] = Dato; // Escritura en memoria
    end
    
    // Lectura de memoria
    op1 = BR[DL1];
    op2 = BR[DL2];
end

endmodule*/

/*`timescale 1ns/1ns

module Banco(
                   // Agrega una señal de reloj
    input [4:0] DL1,
    input [4:0] DL2,
    input [4:0] DE,
    input [31:0] Dato,
    input WE,
	input clk,
    output reg [31:0] op1,
    output reg [31:0] op2
);

// Definir (mem)registro bidimensional
reg [31:0] BR [31:0];

initial begin
    $readmemb("BR.txt", BR);
end

// Escritura controlada por el reloj cuando WE está activo
always @(posedge clk) begin
    if (WE) begin
        BR[DE] <= Dato;
    end
end

// Lectura asincrónica de la memoria
always @(*) begin
    op1 = BR[DL1];
    op2 = BR[DL2];
end

endmodule*/

module Banco(
                          // Señal de reloj
    input [4:0] DL1, DL2, DE,       // Direcciones para lectura y escritura
    input [31:0] Dato,              // Dato a escribir
    input WE,                     // Señal de habilitación de escritura
    input clk,
	output reg [31:0] op1, op2      // Datos leídos
);

    // Declaración del banco de registros
    reg [31:0] BR[0:31]; 

    // Inicialización del banco de registros desde un archivo externo
    initial begin
        $readmemb("BR.txt", BR);
    end

    // Proceso de lectura (asincrónica)
    always @(*) begin
        op1 = BR[DL1]; 
        op2 = BR[DL2];
    end

    // Proceso de escritura controlado por reloj
    always @(posedge clk) begin
        if (WE) begin
            BR[DE] <= Dato; // Escritura en el banco de registros
        end
    end
endmodule



