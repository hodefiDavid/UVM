// environment class - create the driver
class env extends uvm_env;

	`uvm_component_utils(env)
	
	my_agent_out agnt_out;
	my_agent agnt_in;
	scoreboard sb;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		agnt_out = my_agent_out::type_id::create("agnt_out", this);
		agnt_in = my_agent::type_id::create("agnt_in", this);
		sb = scoreboard::type_id::create("sb", this);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		agnt_in.agnt_in_ap.connect(sb.scb_port_in);
		agnt_out.agnt_ap_out.connect(sb.scb_port_out);
	endfunction

	

endclass