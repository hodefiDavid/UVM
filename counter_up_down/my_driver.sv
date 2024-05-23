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
		if (!uvm_config_db#(virtual inf)::get(this, "", "inf", vinf))
			`uvm_error("", "uvm_config_db :: get failed")
	endfunction
	
	// run phase
	task run_phase(uvm_phase phase);
		my_transaction trans = new();
		forever begin
			seq_item_port.get_next_item(trans);
			@(posedge vinf.clk) begin
				vinf.enable <= trans.up_down;
				vinf.load <= trans.load;
				vinf.data_in <= trans.data_in;
				//`uvm_info("", $sformatf("driver: enable=%0d, a=%0d, b=%0d", vinf.enable, vinf.a, vinf.b), UVM_MEDIUM)
			seq_item_port.item_done();

			end
		end
	endtask

endclass