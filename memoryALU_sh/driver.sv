class my_driver extends uvm_driver #(my_transaction);
	`uvm_component_utils(my_driver)
	
	virtual inf vi;
	
	function new (string name, uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		if(!uvm_config_db #(virtual inf)::get(this,"","interface",vi))
			`uvm_error("","uvm_config_db::get failed");
	endfunction
	
	rand logic [1:0] addr;
	rand logic [7:0] wr_data;
	
	rand logic enable;
	rand logic rd_wr;
	
	logic [7:0] rd_data;
	logic [15:0] res_out;
	
	task run_phase(uvm_phase phase);
		forever begin
			seq_item_port.get_next_item(req);
			
			@(posedge vi.clk);
			
			vi.addr<=req.addr;
			vi.wr_data<=req.wr_data;
			vi.enable<=req.enable;
			vi.rd_wr<=req.rd_wr;
			
			seq_item_port.item_done();
		end
	endtask
	
endclass