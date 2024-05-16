// environment class - create the driver
class env extends uvm_env;

	`uvm_component_utils(env)
	
	my_agent agnt;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		agnt = my_agent::type_id::create("agnt", this);
	endfunction

endclass