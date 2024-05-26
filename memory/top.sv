// top module test bench - import package (header.sv)
`include "interface.sv"
`include "memory.sv"
module top;
	
	import uvm_pkg::*;
	import my_pkg::*;
	
	bit clk, rst;
	
	always #5 clk = ~clk;
	
	initial begin
		rst = 1;
		#5 rst = 0;
	end
	
	// instantiate interface
	inf i_inf(clk, rst);
	// instantiate memory
	// connect the interface to the memory by name
	memory c1(.clk(clk), .rst(rst), .addr(i_inf.addr), .wr_en(i_inf.wr_en), .rd_en(i_inf.rd_en), .wr_data(i_inf.wr_data), .rd_data(i_inf.rd_data));
	// run the test (random_test.sv)
	initial begin
		// set the virtual interface to the config_db
		uvm_config_db#(virtual inf)::set(null, "uvm_test_top.*", "inf", i_inf);
		run_test("random_test");
	end

endmodule