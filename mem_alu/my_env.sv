// environment class - create the driver
class my_env extends uvm_env;

	`uvm_component_utils(my_env)
	
	// agent to collect the changes in the data output
	my_agent_data agnt_data;
	// agent to collect the changes in the res output
	my_agent_res agnt_res;
	// agent to collect the changes in the input
	my_agent agnt_in;

	my_scoreboard sb;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		agnt_data = my_agent_data::type_id::create("agnt_data", this);
		agnt_res = my_agent_res::type_id::create("agnt_res", this);
		agnt_in = my_agent::type_id::create("agnt_in", this);

		sb = my_scoreboard::type_id::create("sb", this);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		agnt_data.agnt_ap_out_data.connect(sb.scb_port_out_data);
		agnt_res.agnt_ap_out_res.connect(sb.scb_port_out_res);
		agnt_in.agnt_in_ap.connect(sb.scb_port_in);
	endfunction

	

endclass