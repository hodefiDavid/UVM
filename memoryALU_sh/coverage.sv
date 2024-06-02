class my_coverage extends uvm_subscriber #(my_transaction);

	`uvm_component_utils(my_coverage)

	uvm_analysis_imp #(my_transaction,my_coverage) aport;

	my_transaction txn;

	covergroup inputs_to_dut;

	enable: coverpoint txn.up_down {
	  bins lo = {0};
	  bins hi = {1};
	}

	load: coverpoint txn.load {
	  bins lo = {0};
	  bins hi = {1};
	}

	endgroup

	function new(string name = "my_coverage", uvm_component parent = null);
		super.new(name, parent);
		inputs_to_dut = new;
	endfunction: new
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		aport = new("aport",this);
	endfunction

	virtual function void write(my_transaction t);
		txn = t;
		inputs_to_dut.sample();
	endfunction: write

endclass
