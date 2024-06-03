
module top;

	import uvm_pkg::*;
	import my_pkg::*;
	
	bit clk=0;
	bit rst =0;
	
	initial
	begin
		clk = 0;
		forever #10 clk = ~clk;
	end
	
	initial
	begin
		// rst=1;
		#20 rst=0;
	end
	
	inf i_inf(clk,rst);
	alu dut (.clk(clk), .rst(rst), .data_in(i_inf.data_in), .res_out(i_inf.res_out));
	
	initial begin
		uvm_config_db #(virtual inf)::set(null,"*","inf",i_inf);
		// uvm_top.finish_on_completion = 1;
		run_test("my_test");
	end
endmodule
	