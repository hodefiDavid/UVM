class my_agent2 extends uvm_agent;
	`uvm_component_utils(my_agent2)
	
	my_driver m_drv;
	my_sequencer m_seq;

	my_monitorOut2 monOut;
	
	uvm_analysis_port #(my_transaction) portOut;
	
	function new(string name, uvm_component parent);
		super.new(name,parent);
		portOut = new("portOut",this);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		monOut = my_monitorOut2::type_id::create("monOut",this);
		m_drv = my_driver::type_id::create("m_drv",this);
		m_seq = my_sequencer::type_id::create("m_seq",this);
	endfunction
	
	function void connect_phase(uvm_phase phase);
		monOut.aport.connect(portOut);
		m_drv.seq_item_port.connect(m_seq.seq_item_export);
	endfunction
	
endclass

