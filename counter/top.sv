// top module test bench - import package (header.sv)
`include "interface.sv"
module top;

	import uvm_pkg::*;
	import my_pkg::*;
	
	bit clk, rst;
	
	always #5 clk = ~clk;
	
	initial begin
		rst = 1;
		#20 rst = 0;
	end
	
	// instantiate interface
	inf i_inf(clk, rst);
	counter a1(i_inf);
	
	// run the test (random_test.sv)
	initial begin
		// set the virtual interface to the config_db
		uvm_config_db#(virtual inf)::set(null, "uvm_test_top.*", "inf", i_inf);
		run_test("random_test");
	end

endmodule