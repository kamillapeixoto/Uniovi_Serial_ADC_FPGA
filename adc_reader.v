// ADC Reader
// Lee los datos del conversor ADC MCP3201
// Kamilla Peixoto 19/01/2023

module adc_reader
#(parameter  datos_bits = 12, total_bits = 15)
(
	input clk_adc, serial_ready, in_adc,
	output reg chip_select, 
	output reg [datos_bits-1:0] datos_adc
);

	
	integer contador;
	reg [total_bits-1:0] full_data;
		
	initial
	begin
		chip_select <= 1;
		contador    = 0;	
	   datos_adc = 12'b0;  // datos_bits = 12, 
		full_data = 15'b0; // total_bits = 15
	end // initial


	always @ (negedge clk_adc or posedge serial_ready) // La hoja de datos del ADC dijo que los datos son enviados el la falling edge
	begin
		if (serial_ready == 1'b1) // Si la comunicacion serial ha terminado
		begin
			chip_select = 1'b0;	   // Pede datos al conversor ADC y desactiva el bloque de comunicacion
			// OJO: Solo vay a recibir en el proximo ciclo
			
			full_data[contador] <= in_adc;
		
			
			contador = contador + 1; //Conta los datos recibidos
			
			
			if (contador > total_bits)
			begin
				chip_select <= 1'b1;	   // Para de pedir datos al conversor ADC y activa el bloque de comunicacion serial
				datos_adc <= full_data[total_bits-1:3];
				contador = 0;
			end

			
		end // if (serial_ready == 1'b1)
		else
		begin
			chip_select <= 1'b1;	
		end
	end // always @ (posedge clk_adc)


endmodule
