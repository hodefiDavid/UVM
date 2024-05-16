// test class that creates and the environment and the test
class random_test extends uvm_test;

	`uvm_component_utils(random_test)
	
	env e_env;
	
	// constructor
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	// build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		e_env = env::type_id::create("e_env", this);
	endfunction
	
	// run phase
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		#400;
		`uvm_info("", "This is a random test running", UVM_MEDIUM)
		phase.drop_objection(this);
	endtask

endclass