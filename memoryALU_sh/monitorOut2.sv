class my_monitorOut2 extends uvm_monitor;

	`uvm_component_utils(my_monitorOut2)
	uvm_analysis_port #(my_transaction) aport;
	
	virtual inf vi;
	
	my_transaction tx;
	
	/*covergroup inputs_to_dut;
		count: coverpoint tx.count 
		{
		  bins lo = {0};
		  bins md = {[1:254]};
		  bins hi = {255};
		}
	endgroup*/
		
	function new (string name, uvm_component parent);
		super.new(name, parent);
		//inputs_to_dut = new;
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		aport = new("aport",this);
		if(!uvm_config_db #(virtual inf)::get(this,"","interface",vi))
			`uvm_error("","uvm_config_db::get failed");
	endfunction
	
	
	task run_phase(uvm_phase phase);	
		forever begin
			@(vi.rd_data);
			tx = my_transaction::type_id::create("tx");
			tx.rd_data = vi.rd_data;
			//$display("MONOUT: %d", vi.rd_data);
			aport.write(tx);
			//inputs_to_dut.sample();	
		end
	endtask

endclass