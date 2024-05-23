interface inf(input logic clk, rst);
	parameter ADDR_WIDTH = 3;
	parameter DATA_WIDTH = 8;
	// declare the signals
	logic wr_en;
	logic rd_en;
	logic [ADDR_WIDTH-1:0] addr;
	logic [DATA_WIDTH-1:0] wr_data;
	logic [DATA_WIDTH-1:0] rd_data;



	// modport for the DUT module - decide ports directions
	modport DUT(
		input wr_en, rd_en, addr, wr_data,clk, rst,
		output rd_data
	);
endinterface