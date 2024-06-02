class my_env extends uvm_env;
	`uvm_component_utils(my_env)
	
	my_agent m_agent;
	my_agent2 m_agent2;
	my_scoreboard m_scb;
	//my_coverage m_cvg;
	
	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		m_agent = my_agent::type_id::create("m_agent",this);
		m_agent2 = my_agent2::type_id::create("m_agent2",this);
		
		m_scb = my_scoreboard::type_id::create("m_scb",this);
		//m_cvg = my_coverage::type_id::create("m_cvg", this);
	endfunction
	
	function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        m_agent.portIn.connect(m_scb.aportin);
		//m_agent.portIn.connect(m_cvg.aport);
        m_agent.portOut.connect(m_scb.aportout);
		m_agent2.portOut.connect(m_scb.aportout2);
		
    endfunction
endclass