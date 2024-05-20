interface inf(input logic clk, rst);

  logic enable;
  logic load;
  logic [7:0] data_in;
  logic [7:0] count;

	// modport for the DUT module - decide ports directions
  modport DUT  (input clk, rst, enable, load, data_in, output count);
	
endinterface