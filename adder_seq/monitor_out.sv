class monitor_out extends uvm_monitor;
    `uvm_component_utils (monitor_out)

    uvm_analysis_port# (my_transaction) mon_out_ap; // monitor analysis port

    virtual inf vinf;

    my_transaction my_tran;

    bit [4:0] old_sum = 0;

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
                // fork the process to wait for the enable signal
                @(posedge vinf.clk);
                // fork
                    // wait for the enable signal
            //         begin
            //             if(vinf.enable) begin
            //                 @(posedge vinf.clk);
            //                 my_tran.sum = vinf.sum;
            //                 mon_out_ap.write(my_tran);
            //             end
            //         end
            //         // wait for the sum signal
            //         begin
            //             wait(vinf.sum);
            //             my_tran.sum = vinf.sum;
            //             mon_out_ap.write(my_tran);
            //         end
            //     join_any
            //     disable fork;
            // 
                        
                fork
                    // wait for the enable signal
                        if(vinf.enable) begin
                            @(posedge vinf.clk);
                            my_tran.sum = vinf.sum;
                            mon_out_ap.write(my_tran);
                            this.old_sum = vinf.sum;
                        end
                        else if(vinf.sum != this.old_sum) begin
                        my_tran.sum = vinf.sum;
                        mon_out_ap.write(my_tran);
                        this.old_sum = vinf.sum;
                    end
                join_none;
            end
    endtask

endclass