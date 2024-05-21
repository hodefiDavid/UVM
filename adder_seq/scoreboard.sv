class scoreboard extends uvm_scoreboard;
    `uvm_component_utils(scoreboard)
    
    uvm_analysis_export #(my_transaction) scb_export_in;
    uvm_analysis_export #(my_transaction) scb_export_out;

    uvm_tlm_analysis_fifo #(my_transaction) fifo_in;
    uvm_tlm_analysis_fifo #(my_transaction) fifo_out;

    my_transaction trans_in;
    my_transaction trans_out;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        trans_in = new("trans_in");
        trans_out = new("trans_out");
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        scb_export_in = new("scb_export_in", this);
        scb_export_out = new("scb_export_out", this);
        fifo_in = new("fifo_in", this);
        fifo_out = new("fifo_out", this);

    endfunction

    function void connect_phase(uvm_phase phase);
        scb_export_in.connect(fifo_in.analysis_export);
        scb_export_out.connect(fifo_out.analysis_export);
    endfunction

    task run();
            fifo_out.get(trans_out);
            fifo_out.get(trans_out);

        forever begin
            fifo_in.get(trans_in);
            fifo_out.get(trans_out);
            `uvm_info("", {"comparing transactions"}, UVM_LOW)
            `uvm_info("", $sformatf("trans_out.sum %0d, trans_in.a %0d, trans_in.b %0d",trans_out.sum,trans_in.a,trans_in.b), UVM_LOW)
            //compare the transactions
            if (trans_out.sum == trans_in.a + trans_in.b) begin
                `uvm_info("compare", {"test: OK!"}, UVM_LOW)
            end
            else begin
                //add a message to the report if the test fails
                // using the uvm error macro
                `uvm_warning("compare", {"test: Fail!"})
                //`uvm_info("compare", {"test: Fail!"}, UVM_MEDIUM)
            end
        end
    endtask

endclass