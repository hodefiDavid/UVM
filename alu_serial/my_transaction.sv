class my_transaction extends uvm_sequence_item;

	`uvm_object_utils(my_transaction);
	
	rand bit [7:0] A;
	rand bit [7:0] B;
	rand bit [7:0] OP;
	rand bit [7:0] EXE;
	
	bit rst =0;
	bit data_in; 
	bit [15:0] res_out;

	// "vessel" for the data to be passed to the scoreboard
	bit [31:0] data_out;
	
	function new (string name = "");
		super.new(name);
	endfunction
	
endclass