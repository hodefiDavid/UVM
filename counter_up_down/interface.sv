interface inf(input logic clk, rst);

	// declare the signals
	logic up_down,load;
	logic [7:0] data_in;
	logic [7:0] count;

	// modport for the DUT module - decide ports directions
	modport DUT(input clk, rst, up_down, load, data_in, output count);
	
endinterface