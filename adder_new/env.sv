// environment class - create the driver
class env extends uvm_env;

	`uvm_component_utils(env)
	
	driver drv;
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		drv = driver::type_id::create("driver", this);
	endfunction

endclass