class my_agent extends uvm_agent;
	`uvm_component_utils(my_agent)
	
	my_driver m_drv;
	my_sequencer m_seq;
	my_monitorIn monIn;
	my_monitorOut monOut;
	
	uvm_analysis_port #(my_transaction) portIn;
	uvm_analysis_port #(my_transaction) portOut;
	
	function new(string name, uvm_component parent);
		super.new(name,parent);
		portIn = new("portIn",this);
		portOut = new("portOut",this);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		monIn = my_monitorIn::type_id::create("monIn",this);
		monOut = my_monitorOut::type_id::create("monOut",this);
		m_drv = my_driver::type_id::create("m_drv",this);
		m_seq = my_sequencer::type_id::create("m_seq",this);
	endfunction
	
	function void connect_phase(uvm_phase phase);
		monIn.aport.connect(portIn);
		monOut.aport.connect(portOut);
		m_drv.seq_item_port.connect(m_seq.seq_item_export);
	endfunction
	
endclass

