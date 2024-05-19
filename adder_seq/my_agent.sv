
class my_agent extends uvm_agent;

    `uvm_component_utils(my_agent)
    
    uvm_analysis_port#(my_transaction) agnt_in_ap;
    my_driver drv;
    my_sequencer seqr;
    monitor_in mon_in_h;
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        drv = my_driver::type_id::create("drv", this);
        seqr = my_sequencer::type_id::create("seqr", this);
        mon_in_h = monitor_in::type_id::create("mon_in_h", this);
        agnt_in_ap = new("agnt_in_ap", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        drv.seq_item_port.connect(seqr.seq_item_export);
        mon_in_h.mon_in_ap.connect(agnt_in_ap);
    endfunction

endclass