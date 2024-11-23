module PC( 
    input clk,               // Reloj
    input reset,             // Reset
    input [31:0] pc_in,      // Entrada del PC
    output reg [31:0] pc_out // Salida del PC
); 

    // Inicialización del registro PC
    initial 
        begin 
            pc_out = 32'd0; 
        end 

    // Actualización del registro PC en el flanco positivo del reloj o reset
    always @(posedge clk or posedge reset) 
        begin 
            if (reset)
                pc_out <= 32'd0;
            else
                pc_out <= pc_in;
        end 

endmodule

