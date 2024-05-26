class my_agent_out extends uvm_agent;
    `uvm_component_utils(my_agent_out)
    
    uvm_analysis_port#(my_transaction) agnt_ap_out;
    monitor_out mon_out_h;
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        mon_out_h = monitor_out::type_id::create("mon_out_h", this);
        agnt_ap_out = new("agnt_ap_out", this);
    endfunction

    function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    mon_out_h.mon_out_ap.connect(agnt_ap_out);
    endfunction

endclass