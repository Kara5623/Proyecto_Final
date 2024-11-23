`timescale 1ns/1ns
module Memoria_Instrucciones(
    input [31:0] Direccion,
    output reg [31:0] Instruccion
);
    reg [7:0] memoria [0:255]; // 256 bytes como ejemplo
initial
    begin
        $readmemb("instrucciones.txt", memoria);
    end
    
always @(*)
begin
        // Leer 4 bytes consecutivos y concatenarlos para formar la instrucción de 32 bits
        assign Instruccion = {memoria[Direccion], memoria[Direccion+1], memoria[Direccion+2], memoria[Direccion+3]};
end
    
endmodule

/*`timescale 1ns/1ns
module Memoria_Instrucciones(
    input [31:0] Direccion,
    output reg [31:0] Instruccion
);
    reg [7:0] memoria [0:255]; // 256 bytes como ejemplo

initial begin
    $readmemb("instrucciones.txt", memoria);
end

always @(*) begin
    // Alinear la dirección para asegurar que sea múltiplo de 4
    Instruccion = {memoria[Direccion[9:2] << 2], memoria[(Direccion[9:2] << 2) + 1], memoria[(Direccion[9:2] << 2) + 2], memoria[(Direccion[9:2] << 2) + 3]};
end

endmodule*/



