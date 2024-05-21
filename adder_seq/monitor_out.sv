class monitor_out extends uvm_monitor;
    `uvm_component_utils (monitor_out)

    uvm_analysis_port# (my_transaction) mon_out_ap; // monitor analysis port

    virtual inf vinf;
    my_transaction my_tran;
    bit next_is_valid = 0;
    int sum_of_trans_out = 0;

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
        next_is_valid = 0;
            forever begin
                // fork the process to wait for the enable signal
                @(posedge vinf.clk);
                fork
                    // wait for the enable signal
                    begin
                        #3ns;
                        if(vinf.enable && ~vinf.rst) begin
                            next_is_valid = 1;
                        end
                        else begin
                            next_is_valid = 0;
                        end
                    end
               
                    begin
                        if(next_is_valid) begin
                            my_tran.sum = vinf.sum;
                            //send the transaction to the analysis port
                            sum_of_trans_out++;
                            mon_out_ap.write(my_tran);
                        end
                    end 
                //     begin 
                //         #2ns;  
                //         if(vinf.sum != this.old_sum) begin
                //         my_tran.sum = vinf.sum;
                //         mon_out_ap.write(my_tran);
                //         this.old_sum = vinf.sum;
                //     end
                // end

                join;
            end 
        
    endtask

endclass


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
            // join_any
            // disable fork;
            // 