//Clock Divider para comunicacion serial
//Kamilla Peixoto 21/01/2023
//El baud rate de la comunicacion serial es 9600, eso implica en un clock de 9.6kHz, 
// freq_div = 50MHz/9.6kHz = 
//Es mejor haber "oversampling"?


module baud_generator
#(parameter clock = 50000000, baud = 9600)
(	
	input baud_clk_in, enable, reset, 
	
	output reg baud_clk_out
);


	
	
	integer count;    // Contador de flancos del reloj - no necesita ser entero, se puede usar una variable que requiere menos espacio
	integer freq_div;
	
	
	initial
	begin
		freq_div = clock/baud;
	end
	
	// Reset if needed, or increment if counting is enabled
	always @ (posedge baud_clk_in or posedge reset)
	begin
		
		if (reset)
		begin
			count = 0;
			baud_clk_out <= 0;
		end
		else if (enable)
		begin
			count = count + 1;
			
			if (count >= freq_div)
			begin
				count = 0;
				baud_clk_out <= ~baud_clk_out;
			end
		end // if (enable == 1'b1)
	end

endmodule

