//Clock Divider para comunicacion serial
//Kamilla Peixoto 21/01/2023
//El baud rate de la comunicacion serial es 9600, eso implica en un clock de 9.6kHz, 
// freq_div = 50MHz/9.6kHz = 
//Es mejor haber "oversampling"?


module baud_generator
(
	input clk_in, enable, reset,// dos bits para leer los interruptores de seleccion de frecuencia
	output reg clk_out
);


	
	
	integer freq_div; // Por cuanto dividiremos la frecuencia original de 50M Hz
	integer count;    // Contador de flancos del reloj - no necesita ser entero, se puede usar una variable que requiere menos espacio




	initial
	begin
		count = 0;
		clk_out <= 0;
	end
	
	
	// Si ha un cambio en los interruptores
	always @(posedge clk_in)
	begin

	
				freq_div = 32;
			

		
		if (reset)
		begin
			count = 0;
			clk_out <= 0;
		end
		if (enable)
		begin
			count = count + 1;
			
			if (count >= freq_div)
			begin
				count = 0;
				clk_out <= ~clk_out;
			end
		end // if (enable == 1'b1)
	end

endmodule
