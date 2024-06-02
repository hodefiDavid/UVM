class monitor_out extends uvm_monitor;
    `uvm_component_utils (monitor_out)

    uvm_analysis_port# (my_transaction) mon_out_ap_data; // monitor analysis port
    uvm_analysis_port# (my_transaction) mon_out_ap_res; // monitor analysis port


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
        mon_out_ap_data = new("mon_out_ap_data", this);
        mon_out_ap_res = new("mon_out_ap_res", this);
    endfunction

    task run_phase(uvm_phase phase);
        my_transaction tr_data = new();
        my_transaction tr_res = new();
        next_is_valid = 0;
        fork

            begin
                forever begin
                    @(vinf.rd_data) begin
                        tr_data.rd_data = vinf.rd_data;
                        mon_out_ap_data.write(tr_data);
                        sum_of_trans_out++;
                    end
                end

            end


            begin
                forever begin
                    @(vinf.res_out) begin
                        tr_res.res_out = vinf.res_out;
                        mon_out_ap_res.write(tr_res);
                        sum_of_trans_out++;
                    end
                end

            end
        join
    endtask

endclass
