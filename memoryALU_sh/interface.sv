interface inf(input logic clk, reset);

	logic [1:0] addr;
	logic [7:0] wr_data;
	
	logic enable;
	logic rd_wr;
	
	logic [7:0] rd_data;
	logic [15:0] res_out;

  modport DUT (input clk, reset, enable, rd_wr, addr, wr_data, output rd_data, res_out);

endinterface
