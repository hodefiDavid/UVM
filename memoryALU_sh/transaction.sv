class my_transaction extends uvm_sequence_item;

	`uvm_object_utils(my_transaction);
	
	rand logic [1:0] addr;
	rand logic [7:0] wr_data;
	
	rand logic enable;
	rand logic rd_wr;
	
	logic [7:0] rd_data;
	logic [15:0] res_out;
	
	function new (string name = "");
		super.new(name);
	endfunction
	
	
	
endclass