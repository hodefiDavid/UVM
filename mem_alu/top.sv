module top;
	import uvm_pkg::*;
	import my_pkg::*;
	
	bit clk;
	bit reset;
	
	inf i_inf(clk,reset);
	memory dut (.clk(i_inf.clk), .reset(i_inf.reset), .enable(i_inf.enable), .rd_wr(i_inf.rd_wr), .addr(i_inf.addr), .wr_data(i_inf.wr_data), .rd_data(i_inf.rd_data), .res_out(i_inf.res_out));
	
	initial
	begin
		clk = 0;
		forever #10 clk = ~clk;
	end
	
	initial
	begin
		reset=1;
		#20 reset=0;
	end
	
	
	initial begin
		uvm_config_db #(virtual inf)::set(null,"*","inf",i_inf);
		// uvm_top.finish_on_completion = 1;
		run_test("my_test");
	end
endmodule
	