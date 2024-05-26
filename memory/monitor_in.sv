`include "my_coverage.sv"

class monitor_in extends uvm_monitor;
    `uvm_component_utils (monitor_in)

    uvm_analysis_port# (my_transaction) mon_in_ap; // monitor analysis port

    virtual inf vinf;
    int sum_of_trans_in = 0;
    my_transaction my_tran;

  //For coverage
    my_transaction my_tran_cov;
    my_coverage cvg;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        cvg = new();
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
            if(vinf.wr_en == 1'b1 || vinf.rd_en == 1'b1 || vinf.rst == 1'b1)
             begin 
                my_tran.rst = vinf.rst;
                my_tran.wr_en = vinf.wr_en;
                my_tran.rd_en = vinf.rd_en;
                my_tran.addr = vinf.addr;
                my_tran.wr_data = vinf.wr_data;
                
                mon_in_ap.write(my_tran);
                sum_of_trans_in++;

                // for coverage
                my_tran_cov = my_tran;
                my_tran_cov.rd_data = vinf.rd_data;
                cvg.sample(my_tran_cov);
                
            end
        end
    endtask
endclass