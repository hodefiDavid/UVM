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
		my_sequence seq;
		phase.raise_objection(this);
		seq = my_sequence::type_id::create("seq");
		if (!seq.randomize())
			`uvm_error("", "randomize failed")
		seq.start(e_env.agnt_in.seqr);
		#4ns;
		`uvm_info("", "This is a random test running", UVM_MEDIUM)
		phase.drop_objection(this);
		// printing the trans in and the trans out
		`uvm_info("", $sformatf("numbers of trans_in : ", e_env.agnt_in.mon_in_h.sum_of_trans_in), UVM_LOW)
		`uvm_info("", $sformatf("numbers of trans_out : ", e_env.agnt_out.mon_out_h.sum_of_trans_out), UVM_LOW)
	endtask

	//task after the run phase
	task post_run_phase(uvm_phase phase);
		phase.raise_objection(this);
		`uvm_info("", "This is the extract phase", UVM_MEDIUM)
		`uvm_info("", $sformatf("numbers of trans_in : ", e_env.agnt_in.mon_in_h.sum_of_trans_in), UVM_LOW)
		`uvm_info("", $sformatf("numbers of trans_out : ", e_env.agnt_out.mon_out_h.sum_of_trans_out), UVM_LOW)
		phase.drop_objection(this);
	endtask
endclass