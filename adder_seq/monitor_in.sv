class monitor_in extends uvm_monitor;
    `uvm_component_utils (monitor_in)

    uvm_analysis_port# (my_transaction) mon_in_ap; // monitor analysis port

    virtual inf vinf;

    my_transaction my_tran;

    //For coverage
    my_transaction my_tran_cov;
    //Define coverpoints
    covergroup adder_cov;
        coverpoint my_tran_cov.a;
        coverpoint my_tran_cov.b;
    endgroup

    function new(string name, uvm_component parent);
        super.new(name, parent);
        my_tran_cov = new(); 
        adder_cov = new();
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_config_db#(virtual inf)::get(this,"","inf",vinf);
        mon_in_ap = new("mon_in_ap", this);
    endfunction


    task run_phase(uvm_phase phase);
        my_tran = my_transaction::type_id::create("my_tran", this);

        forever begin 
            // wait(vinf.enable);
            // @(posedge vinf.clk);
            @(posedge vinf.clk);
            if(vinf.enable)
             begin 
                my_tran.a = vinf.a;
                my_tran.b = vinf.b;
                // for coverage
                my_tran_cov = my_tran;
                adder_cov.sample();
                `uvm_info(" ", $sformatf("Monitor expected enable=%0d, a=%0d, b=%0d, sum=%d", vinf.enable,vinf.a, vinf.b, vinf.sum), UVM_MEDIUM);
                //send the transaction to the analysis port
                mon_in_ap.write(my_tran);
            end
        end
    endtask
endclass