// top module test bench - import package (header.sv)
`include "interface.sv"
`include "memory.sv"
module top;
	
	import uvm_pkg::*;
	import my_pkg::*;
	
	bit clk, reset;
	
	always #5 clk = ~clk;
	
	initial begin
		reset = 1;
		#5 reset = 0;
	end
	
	// instantiate interface
	inf i_inf(clk, reset);
	// memory c1(i_inf.DUT);
	// connect the intrface to the memory by name 
	memory c1 (.clk(clk), .reset(reset), .rd_wr(i_inf.rd_wr), .addr(i_inf.addr), .enable(i_inf.enable), .wr_data(i_inf.wr_data), .rd_data(i_inf.rd_data), .res_out(i_inf.res_out));
	initial begin
		// set the virtual interface to the config_db
		uvm_config_db#(virtual inf)::set(null, "uvm_test_top.*", "inf", i_inf);
		run_test("random_test");
	end

endmodule