//Clock Divider
//Genera un signal de clock baseado en los valores leidos por dos interruptores
//Kamilla Peixoto 18/01/2023

module clock_divider
(
	clk_in, enable, reset, freq_userA, freq_userB, // dos bits para leer los interruptores de seleccion de frecuencia
	
	clk_out
);


	input clk_in, enable, reset, freq_userA, freq_userB;// dos bits para leer los interruptores de seleccion de frecuencia
	output reg clk_out;
	
	integer freq_div; // Por cuanto dividiremos la frecuencia original de 50M Hz
	integer count;    // Contador de flancos del reloj - no necesita ser entero, se puede usar una variable que requiere menos espacio
	wire [1:0] freq_user;

	assign freq_user = {freq_userA, freq_userB};

	
	
	// Si ha un cambio en los interruptores
	always @(posedge clk_in)
	begin
		
			case (freq_user)
				2'b00: freq_div = 128;
				2'b01: freq_div = 64;
				2'b10: freq_div = 32;	
				2'b11: freq_div = 16;
			endcase
	end

	// Reset if needed, or increment if counting is enabled
	always @ (posedge clk_in or posedge reset)
	begin
		
		if (reset)
		begin
			count = 0;
			clk_out <= 0;
		end
		else if (enable)
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

