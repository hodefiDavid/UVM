// top module test bench - import package (header.sv)
`include "interface.sv"
// `include "alu.v"
`include "ALU_fixed.svp"

module top;
	
	import uvm_pkg::*;
	import my_pkg::*;
	
	bit clk, rst_n;
	
	always #5 clk = ~clk;
	
	initial begin
		rst_n = 0;
		#5 rst_n = 1;
	end
	
	// instantiate interface
	inf i_inf(clk, rst_n);
	// fifo a1(i_inf);
	ALU c1(.A(i_inf.A), .B(i_inf.B), .mode(i_inf.mode), .Y(i_inf.Y), .clk(clk), .rst_n(rst_n));
	// run the test (random_test.sv)
	initial begin
		// set the virtual interface to the config_db
		uvm_config_db#(virtual inf)::set(null, "uvm_test_top.*", "inf", i_inf);
		run_test("random_test");
	end

endmodule