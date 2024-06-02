class my_monitorIn extends uvm_monitor;

	`uvm_component_utils(my_monitorIn)
	uvm_analysis_port #(my_transaction) aport;
	
	virtual inf vi;
	
	my_transaction tx;
	
	/*covergroup inputs_to_dut;
		up_down: coverpoint tx.up_down 
		{
		  bins lo = {0};
		  bins hi = {1};
		}

		load: coverpoint tx.load 
		{
		  bins lo = {0};
		  bins hi = {1};
		}
		
		data_in: coverpoint tx.data_in
		{
			bins lo = {0};
			bins md = {[1:254]};
			bins hi = {255};
		}
	
		cp_loadEnabled: coverpoint({(tx.load==1)}) 
		{
			bins loadEnabled = {1'b1};
		}
		
		cr_loadAllPossible: cross cp_loadEnabled, data_in;
	endgroup/*/
	
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
			@(posedge vi.clk);
				if(vi.enable) begin
					tx = my_transaction::type_id::create("tx");
					
					tx.addr = vi.addr;
					tx.wr_data = vi.wr_data;
					tx.enable = vi.enable;
					tx.rd_wr = vi.rd_wr;
					
					aport.write(tx);
				end
				//inputs_to_dut.sample();
		end
	endtask

endclass