//Comunicacion serial
//Kamilla Peixoto 21/01/2023



module serial_com
#(parameter bits_com = 8)(	
	input baud_clk, enable, bit0_adc, bit1_adc, bit2_adc, bit3_adc, bit4_adc, bit5_adc, bit6_adc, bit7_adc,
	
	output reg bit_out_tx, serial_end
);

	
	integer count;    // Contador de flancos del reloj - no necesita ser entero, se puede usar una variable que requiere menos espacio
	wire [bits_com-1:0] data_com;
	
	assign data_com = {1'b0, bit0_adc, bit1_adc, bit2_adc, bit3_adc, bit4_adc, bit5_adc, bit6_adc, bit7_adc};
	//El primero bit a ser enviado es zero
	
	initial
	begin
		count       = 0;	
		bit_out_tx  = 1;
		serial_end  = 1;
	end // initial
	
	
	always @ (posedge baud_clk)
	begin
	
if(count<bits_com)
begin
	if (enable == 1'b1)
		begin
			serial_end = 0;
			bit_out_tx = data_com [count]; // MSB or LSB first?
			count = count + 1;
		end // if (enable == 1'b1)
end
		else
		begin
			count      <= 0;
			serial_end = 1;
		end
	end

endmodule




