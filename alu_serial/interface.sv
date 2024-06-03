interface inf(input logic clk, rst);

	logic data_in=0;
	logic [15:0] res_out;

  modport DUT (input clk, rst, data_in, output res_out);

endinterface
