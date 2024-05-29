class monitor_out extends uvm_monitor;
    `uvm_component_utils (monitor_out)

    uvm_analysis_port# (my_transaction) mon_out_ap; // monitor analysis port

    virtual inf vinf;
    my_transaction my_tran;
    bit next_is_valid = 0;
    int sum_of_trans_out = 0;

    function new (string name, uvm_component parent);
        super.new (name, parent) ;
    endfunction


    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_config_db#(virtual inf)::get(this,"","inf",vinf);
        mon_out_ap = new("mon_out_ap", this);
    endfunction

    task run_phase(uvm_phase phase);
        my_transaction tr_data = new();
        my_transaction tr_res = new();
        
        next_is_valid = 0;

            forever begin
           
            fork
                begin
                @(vinf.rd_data) begin
                    tr_data.rd_data = vinf.rd_data;
                    tr_data.is_data_valid = 1;
                    mon_out_ap.write(tr_data);
                    end
                end

                begin 
                    @(vinf.res_out) begin
                        tr_res.res_out = vinf.res_out;
                        tr_res.is_data_valid = 0;
                    end
                end
            join_any
            disable fork;
            //send the transaction to the analysis port
            sum_of_trans_out++;
            end
    endtask

endclass
