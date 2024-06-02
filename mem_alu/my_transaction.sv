class my_transaction extends uvm_sequence_item;

	`uvm_object_utils(my_transaction);
	
	rand bit [1:0] addr;
	rand bit [7:0] wr_data;
	
	rand bit enable;
	rand bit rd_wr;
	
	bit [7:0] rd_data;
	bit [15:0] res_out;
	
	function new (string name = "");
		super.new(name);
	endfunction
	
endclass