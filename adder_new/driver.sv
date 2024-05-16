// driver class to push values to the signals of the interface
class driver extends uvm_driver;

	`uvm_component_utils(driver)
	
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
		forever begin
			@(posedge vinf.clk) begin
				vinf.enable <= $random;
				vinf.a <= $random;
				vinf.b <= $random;
				//`uvm_info("", $sformatf("driver: enable=%0d, a=%0d, b=%0d", vinf.enable, vinf.a, vinf.b), UVM_MEDIUM)
			end
		end
	endtask

endclass