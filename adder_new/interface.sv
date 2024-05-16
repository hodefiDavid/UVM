interface inf(input logic clk, rst);

	// declare the signals
	logic enable;
	logic [3:0] a, b;
	logic [4:0] sum;

	// modport for the DUT module - decide ports directions
	modport DUT(input clk, rst, enable, a, b, output sum);
	
endinterface