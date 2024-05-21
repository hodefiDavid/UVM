class monitor_in extends uvm_monitor;
    `uvm_component_utils (monitor_in)

    uvm_analysis_port# (my_transaction) mon_in_ap; // monitor analysis port

    virtual inf vinf;
    int sum_of_trans_in = 0;
    my_transaction my_tran;

    //For coverage
    my_transaction my_tran_cov;
    //Define coverpoints
    covergroup adder_cov;
        cov_a: coverpoint my_tran_cov.a;
        cov_b: coverpoint my_tran_cov.b;
        cov_ab: cross cov_a, cov_b;
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

              #2ps;
            if(vinf.enable && ~vinf.rst)
             begin 
                my_tran.a = vinf.a;
                my_tran.b = vinf.b;
                // for coverage
                my_tran_cov = my_tran;
                adder_cov.sample();
                //`uvm_info(" ", $sformatf("Monitor expected enable=%0d, a=%0d, b=%0d, sum=%d", vinf.enable,vinf.a, vinf.b, vinf.sum), UVM_MEDIUM);
                //send the transaction to the analysis port
                // @(posedge vinf.clk);
                mon_in_ap.write(my_tran);
                sum_of_trans_in++;
            end
        end
    endtask
endclass