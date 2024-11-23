/*`timescale 1ns/1ns

module TypeR_tb;

    reg [31:0] instruccion;
    

    // Instancia del módulo bajo prueba (Unit Under Test, UUT)
    TypeR uut (
        .instruccion(instruccion)
    );

    initial begin
        // Inicializa la señal de instrucción con diferentes registros de destino para cada operación
        // Instrucción para ADD $8, $1, $2 (registro de destino $8)
		instruccion = 32'b000000_00001_00010_01000_00000_100000;
        #100; // Espera 100ns para observar el resultado
		
        // Instrucción SUB $9, $1, $2 (registro de destino $9)
        instruccion = 32'b000000_00001_00010_01001_00000_100010;
        #100;

        // Instrucción SLT $10, $1, $2 (registro de destino $10)
        instruccion = 32'b000000_00001_00010_01010_00000_101010;
        #100;

        // Instrucción AND $11, $1, $2 (registro de destino $11)
        instruccion = 32'b000000_00001_00010_01011_00000_100100;
        #100;

        // Instrucción OR $12, $1, $2 (registro de destino $12)
        instruccion = 32'b000000_00001_00010_01100_00000_100101;
        #100;

        // Instrucción XOR $13, $1, $2 (registro de destino $13)
        instruccion = 32'b000000_00001_00010_01101_00000_100110;
        #100;

        // Instrucción NOR $14, $1, $2 (registro de destino $14)
        instruccion = 32'b000000_00001_00010_01110_00000_100111;
        #100;
		
        // Fin de la simulación
        $stop;
    end

endmodule

`timescale 1ns/1ns

module tb_TypeR;
    reg [31:0] instruccion;
    wire [31:0] ResAlu;
    
    TypeR UUT (
        .instruccion(instruccion)
       
    );
    
    initial begin
        instruccion = 32'b0;
        
        #100; instruccion = 32'b000000_00001_00010_00011_00000_100000; #10;
        #100; instruccion = 32'b000000_01001_01010_01011_00000_100010; #10;
        #100; instruccion = 32'b000000_01100_01101_01110_00000_100100; #10;
        #100; instruccion = 32'b000000_00100_00101_00110_00000_100101; #10;
        #100; instruccion = 32'b000000_00011_00100_00101_00000_100110; #10;
        
       
    end
endmodule*/

`timescale 1ns/1ns

module TypeR_tb();

reg clk;
reg reset;


// Instanciamos el módulo que vamos a probar
TypeR uut (
    .clk(clk),
	.reset(reset)
);

// Generamos el reloj
initial begin
    clk = 1;
    forever #5 clk = ~clk;
end

// Inicializamos las señales y ejecutamos las pruebas
initial begin
    // Inicialización de señales
    reset =1;
	#1;
	reset=0;
    #1000;
    $finish;
end

endmodule

