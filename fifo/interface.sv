interface inf(input logic clk, rst);

	// declare the signals
	logic write_en;
	logic read_en;
	logic [3:0] data_in;
	logic full;
	logic empty;
	logic [3:0] data_out;

	// modport for the DUT module - decide ports directions
	modport DUT(input clk, rst, write_en,read_en, data_in, output full,empty,data_out);
	
endinterface