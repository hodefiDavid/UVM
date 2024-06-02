class my_test extends uvm_test;
	`uvm_component_utils(my_test)
	
	my_env m_env;
	my_sequence seq;
	
	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		m_env = my_env::type_id::create("m_env",this);
	endfunction
	
	task run_phase(uvm_phase phase);
		seq = my_sequence::type_id::create("seq");
		phase.raise_objection(this);
        seq.start(m_env.m_agent.m_seq);
		phase.drop_objection(this);
	endtask
endclass