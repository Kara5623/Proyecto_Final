/*`timescale 1ns/1ns

module RAM(
	input wire [31:0] Datoin,
	input wire [4:0] Dir,
	input wire WE,//EnW
	input RE, //EnR
	
	output reg [31:0] Datoout
);

	reg [31:0]ram [0:63];
	
	always @(*)
	begin
		if(WE)
		begin
		//Escribir en la RAM
		ram[Dir] =Datoin;
		end
		else if (RE)
		begin
		//Leer de la RAM
		Datoout=ram[Dir];
		end
	end
endmodule
*/
/*`timescale 1ns/1ns

module RAM(
    input[31:0] Datoin,
    input [4:0] Dir,
    input WE,     // EnW
    input RE,     // EnR
    input clk,    // Señal de reloj
    
    output reg [31:0] Datoout
);

    reg [31:0] ram [0:63];
	
initial begin
        $readmemb("insram.txt", ram);  // Leer los datos desde el archivo al inicio
    end
    
    always @(posedge clk) begin
        if (WE) begin
            // Escribir en la RAM sincronizado con el reloj
            ram[Dir] <= Datoin;
        end else if (RE) begin
            // Leer de la RAM sincronizado con el reloj
            Datoout <= ram[Dir];
        end else begin
            Datoout <= 32'd0; // Inicializar para evitar valores indefinidos
        end
    end
endmodule*/

`timescale 1ns/1ns

module RAM(
    input [31:0] Datoin,      // Dato a escribir
    input [4:0] Dir,          // Dirección de lectura/escritura
    input WE,                 // Señal de habilitación de escritura
    input RE,                 // Señal de habilitación de lectura
    input clk,                // Señal de reloj
    output reg [31:0] Datoout // Salida del dato leído
);

    // Banco de memoria (64 posiciones de 32 bits cada una)
    reg [31:0] ram [0:63];

    // Inicialización de la memoria desde un archivo
    initial begin
        $readmemb("insram.txt", ram);  // Cargar datos del archivo insram.txt
    end

    // Escritura sincronizada con el flanco de subida del reloj
    always @(posedge clk) begin
        if (WE) begin
            ram[Dir] <= Datoin; // Escribir dato en la dirección especificada
        end
    end

    // Lectura asincrónica (el valor se actualiza inmediatamente cuando RE está activo)
    always @(*) begin
        if (RE) begin
            Datoout = ram[Dir]; // Leer dato desde la dirección especificada
        end else begin
            Datoout = 32'd0; // Dato predeterminado cuando no se está leyendo
        end
    end
endmodule


