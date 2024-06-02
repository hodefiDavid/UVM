class my_agent_data extends uvm_agent;
    `uvm_component_utils(my_agent_data)
    
    uvm_analysis_port#(my_transaction) agnt_ap_out_data;
    monitor_out_data mon_out_h;
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        mon_out_h = monitor_out_data::type_id::create("mon_out_h", this);
        agnt_ap_out_data = new("agnt_ap_out_data", this);
    endfunction

    function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    mon_out_h.mon_out_ap.connect(agnt_ap_out_data);
    endfunction

endclass