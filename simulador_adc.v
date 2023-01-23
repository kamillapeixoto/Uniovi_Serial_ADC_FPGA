// ADC Reader
// Simula un conversor ADC MCP3201
// Kamilla Peixoto 21/01/2023

module simulador_adc
#(parameter  datos_bits = 12, total_bits = 15)
(
	input clk_adc, cs, 
	output reg datos_adc
);

	
	integer contador;
	reg [total_bits-1:0] full_data;
		
	initial
	begin
		contador    = 0;	
		full_data = 15'b000111001100011; // total_bits = 15
		// xxxdata[11:0]
	end // initial


	always @ (negedge clk_adc) // La hoja de datos del ADC dijo que los datos son enviados el la falling edge
	begin
		if ((cs == 1'b0)&&(contador<=total_bits))
		begin
				contador = contador + 1; //Conta los datos recibidos
				
			//	if (contador >= 2) // Espera 2 bits para empezar a enviar los datos
			//	begin
				 	datos_adc<= full_data[contador];
				//	datos_adc<=1;
			//	end
		end // if ((cs == 1'b0) &&(contador<total_bits))
		else
		begin
			contador    = 0;	
			datos_adc<=0;
		end
	end // always @ (posedge clk_adc)


endmodule
