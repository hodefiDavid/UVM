class monitor_out_res extends uvm_monitor;
    `uvm_component_utils (monitor_out_res)

    uvm_analysis_port# (my_transaction) mon_out_ap; // monitor analysis port

    virtual inf vinf;
    my_transaction my_tran;
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
        my_tran = my_transaction::type_id::create("my_tran", this);
        forever begin
			@(vinf.res_out);
			my_tran.res_out = vinf.res_out;
			mon_out_ap.write(my_tran);
            sum_of_trans_out++;
		end
    endtask

endclass
