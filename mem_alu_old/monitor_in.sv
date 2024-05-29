	`include "my_coverage.sv"

class monitor_in extends uvm_monitor;
    `uvm_component_utils (monitor_in)

    uvm_analysis_port# (my_transaction) mon_in_ap; // monitor analysis port

    virtual inf vinf;
    int sum_of_trans_in = 0;
    my_transaction my_tran;
    
    // for coverage porpeses
    my_coverage cov;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        
        //for coverage
        cov = new();
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_config_db#(virtual inf)::get(this,"","inf",vinf);
        mon_in_ap = new("mon_in_ap", this);
    endfunction

    task run_phase(uvm_phase phase);
        my_tran = my_transaction::type_id::create("my_tran", this);
  
        forever begin 
   
            @(posedge vinf.clk);
               #1ps;
            if(vinf.reset == 1 || vinf.enable == 1) 
             begin 
                my_tran.reset <= vinf.reset;
                my_tran.rd_wr <= vinf.rd_wr;
                my_tran.enable <= vinf.enable;   
                my_tran.addr <= vinf.addr;
                my_tran.wr_data <= vinf.wr_data;
                
                mon_in_ap.write(my_tran);
                sum_of_trans_in++;
                
                // for coverage
                cov.coverage_sample(my_tran);
            end
        end
    endtask
endclass