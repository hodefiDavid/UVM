module top;
	import uvm_pkg::*;
	import my_pkg::*;
	
	bit clk;
	logic reset;
	
	inf itf(clk,reset);
	memory dut (.clk(itf.clk), .reset(itf.reset), .enable(itf.enable), .rd_wr(itf.rd_wr), .addr(itf.addr), .wr_data(itf.wr_data), .rd_data(itf.rd_data), .res_out(itf.res_out));
	
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
		uvm_config_db #(virtual inf)::set(null,"*","interface",itf);
		uvm_top.finish_on_completion = 1;
		run_test("my_test");
	end
endmodule
	