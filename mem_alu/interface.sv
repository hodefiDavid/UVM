interface inf(input logic clk, reset);
	parameter int ADDR_WIDTH = 2;
	parameter int DATA_WIDTH = 8;
	// declare the signals
	logic rd_wr;
	logic [ADDR_WIDTH-1:0] addr;
	logic enable;
	logic [DATA_WIDTH-1:0] wr_data;
	
	logic [DATA_WIDTH-1:0] rd_data;
	logic [16-1:0] res_out;


	// modport for the DUT module - decide ports directions
	modport DUT(input clk, reset, rd_wr, addr, enable, wr_data,output rd_data, res_out);
endinterface