// ADC Reader
// Lee los datos del conversor ADC MCP3201
// Kamilla Peixoto 19/01/2023

module adc_reader
#(parameter  datos_bits = 12, total_bits = 15)
(
	input clk_adc, serial_ready, in_adc,
	output reg chip_select, bit0_adc, bit1_adc, bit2_adc, bit3_adc, bit4_adc, bit5_adc, bit6_adc, bit7_adc,
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
			//Solo es necesario enviar 8 bits - especificaciones del proyecto
			//La salida será dividida en bits porque el bloque de comunicacion serial no puede recibir
			//un conjunto de bits como input 
			bit0_adc <= datos_adc[0];
			bit1_adc <= datos_adc[1];
			bit2_adc <= datos_adc[2];
			bit3_adc <= datos_adc[3];
			bit4_adc <= datos_adc[4];
			bit5_adc <= datos_adc[5];
			bit6_adc <= datos_adc[6];
			bit7_adc <= datos_adc[7];
			//MSB First
		end
	end // always @ (posedge clk_adc)


endmodule
