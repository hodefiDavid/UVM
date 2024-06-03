// driver class to push values to the signals of the interface
class my_driver extends uvm_driver#(my_transaction);

	`uvm_component_utils(my_driver)
	
	virtual inf vinf;

	// constructor
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	// build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if (!uvm_config_db#(virtual inf)::get(this, "", "inf", vinf))
			`uvm_error("", "uvm_config_db :: get failed")
	endfunction
	
	// run phase
	task run_phase(uvm_phase phase);
		my_transaction trans = new();
		bit [31:0] data_to_send; 
		forever begin
			seq_item_port.get_next_item(trans);
			// get the DUT to a state where it can accept the transaction
			@(posedge vinf.clk)
				vinf.data_in = 1;				
			@(posedge vinf.clk)
				vinf.data_in = 0;
			@(posedge vinf.clk)
				vinf.data_in = 1;				
			@(posedge vinf.clk)
				vinf.data_in = 0;

			data_to_send = {trans.A,trans.B,trans.OP,trans.EXE};
			for(int i = 0; i<32 ;i++) begin
				@(posedge vinf.clk)
					vinf.data_in = data_to_send[i];				
			end
				
			seq_item_port.item_done();

		end
	endtask

endclass