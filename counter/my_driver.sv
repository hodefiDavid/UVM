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

	    my_transaction trans;
		int i = 0;
		forever begin
			 seq_item_port.get_next_item(trans);
			@(posedge vinf.clk) begin
				// i'm just going to hardcode it to 1 to be able to test the counter 
				// push the values to the interface
				//vinf.enable <= trans.enable;
				vinf.enable <= 1;
				vinf.data_in <= trans.data_in;

				// i'm just going to hardcode it to 1 and then 0 to be able to test the counter 
				if (i == 0) begin
					vinf.load <= 1;
					i = 1;
				end
				else begin
					vinf.load <= 0;
					
				end
				//vinf.load <= trans.load;

				//`uvm_info("", $sformatf("driver: enable=%0d, a=%0d, b=%0d", vinf.enable, vinf.a, vinf.b), UVM_MEDIUM)
			seq_item_port.item_done();
			end
		end
	endtask

endclass