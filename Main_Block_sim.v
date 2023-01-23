// Copyright (C) 1991-2013 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

// PROGRAM		"Quartus II 64-Bit"
// VERSION		"Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"
// CREATED		"Mon Jan 23 19:05:55 2023"

module Main_Block_sim(
	fpga_clk,
	Aswitch,
	Bswitch,
	rst,
	enable,
	cs_ADC,
	bit_serial,
	datos
);


input wire	fpga_clk;
input wire	Aswitch;
input wire	Bswitch;
input wire	rst;
input wire	enable;
output wire	cs_ADC;
output wire	bit_serial;
output wire	[11:0] datos;

wire	baud_clk;
wire	clk_adc;
wire	in_adc;
wire	serial_ready;
wire	SYNTHESIZED_WIRE_10;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_7;
wire	SYNTHESIZED_WIRE_8;

assign	cs_ADC = SYNTHESIZED_WIRE_10;




clock_divider	b2v_inst(
	.clk_in(fpga_clk),
	.enable(enable),
	.reset(rst),
	.freq_userA(Aswitch),
	.freq_userB(Bswitch),
	.clk_out(clk_adc));


baud_generator	b2v_inst1(
	.clk_in(fpga_clk),
	.enable(enable),
	.reset(rst),
	.clk_out(baud_clk));


adc_reader	b2v_inst3(
	.clk_adc(clk_adc),
	.serial_ready(serial_ready),
	.in_adc(in_adc),
	.chip_select(SYNTHESIZED_WIRE_10),
	.bit0_adc(SYNTHESIZED_WIRE_1),
	.bit1_adc(SYNTHESIZED_WIRE_2),
	.bit2_adc(SYNTHESIZED_WIRE_3),
	.bit3_adc(SYNTHESIZED_WIRE_4),
	.bit4_adc(SYNTHESIZED_WIRE_5),
	.bit5_adc(SYNTHESIZED_WIRE_6),
	.bit6_adc(SYNTHESIZED_WIRE_7),
	.bit7_adc(SYNTHESIZED_WIRE_8),
	.datos_adc(datos));
	defparam	b2v_inst3.datos_bits = 12;
	defparam	b2v_inst3.total_bits = 15;


serial_com	b2v_inst4(
	.baud_clk(baud_clk),
	.enable(SYNTHESIZED_WIRE_10),
	.bit0_adc(SYNTHESIZED_WIRE_1),
	.bit1_adc(SYNTHESIZED_WIRE_2),
	.bit2_adc(SYNTHESIZED_WIRE_3),
	.bit3_adc(SYNTHESIZED_WIRE_4),
	.bit4_adc(SYNTHESIZED_WIRE_5),
	.bit5_adc(SYNTHESIZED_WIRE_6),
	.bit6_adc(SYNTHESIZED_WIRE_7),
	.bit7_adc(SYNTHESIZED_WIRE_8),
	.bit_out_tx(bit_serial),
	.serial_end(serial_ready));
	defparam	b2v_inst4.bits_com = 8;


simulador_adc	b2v_inst6(
	.clk_adc(clk_adc),
	.cs(SYNTHESIZED_WIRE_10),
	.datos_adc(in_adc));
	defparam	b2v_inst6.datos_bits = 12;
	defparam	b2v_inst6.total_bits = 15;


endmodule
