// ADC Reader
// Lee los datos del conversor ADC MCP3201
// Kamilla Peixoto 19/01/2023

module adc_reader_v1
#(parameter  n_bits = 12)
(
	input clk_adc, serial_ready, in_adc,
	output reg chip_select, 
	output reg [n_bits -1:0] datos_adc
);

	
	integer contador;

	
	initial
	begin
		chip_select <= 1;
		contador    = 0;	
	end // initial


	always @ (negedge clk_adc) // La hoja de datos del ADC dijo que los datos son enviados el la falling edge
	begin
		if (serial_ready == 1'b1) // Si la comunicacion serial ha terminado
		begin
			chip_select <= 1'b0;	   // Pede datos al conversor ADC y desactiva el bloque de comunicacion
			// OJO: Solo vay a recibir en el proximo ciclo
			
			
			while((contador <=n_bits)&& (contador>3)) // Ignora 2 bits de conversion y 1 NULL bit
			begin 
				datos_adc[contador-3] <= in_adc;
			end
			
			contador = contador + 1; //Conta los datos recibidos
			
			if (contador >= n_bits)
			begin
				chip_select <= 1'b1;	   // Para de pedir datos al conversor ADC y activa el bloque de comunicacion serial
			end

			
		end // if (serial_ready == 1'b1)
		else
		begin
			chip_select <= 1'b1;	
			datos_adc <= 12'b0;
		end
	end // always @ (posedge clk_adc)


endmodule
