
interface inf(input logic clk, rst_n);

	// declare the signals
	logic [4:0] Y;
	logic  [3:0] A, B;
	logic  [1:0] mode;

	// modport for the DUT module - decide ports directions
	modport DUT(input  A, B, mode, clk, rst_n,output Y);	
endinterface