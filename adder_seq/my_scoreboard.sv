class my_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(my_scoreboard)
    
    uvm_analysis_export #(my_transaction) scb_aport;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
       scb_aport = new("scb_aport", this);
    endfunction

// The write function is called by the analysis port when a transaction is received.
// The function writes the transaction to the scoreboard and prints a message to the console.
    function void write(my_transaction t);
        `uvm_info(get_type_name(), $sformatf("Received transaction: %0d", t.data), UVM_MEDIUM)
    endfunction
endclass