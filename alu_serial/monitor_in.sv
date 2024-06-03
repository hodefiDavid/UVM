class monitor_in extends uvm_monitor;

    `uvm_component_utils (monitor_in)

    uvm_analysis_port# (my_transaction) mon_in_ap; // monitor analysis port

    virtual inf vinf;
    int sum_of_trans_in = 0;
    my_transaction my_tran;
    bit state_queue [$];
    bit next_is_valid = 0;
    bit [3:0] state;
    int counter;
    function new(string name, uvm_component parent);
        super.new(name, parent);
        counter = 0;
        state = 4'b0000;
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_config_db#(virtual inf)::get(this,"","inf",vinf);
        mon_in_ap = new("mon_in_ap", this);
    endfunction

    task run_phase(uvm_phase phase);
               
        my_tran = my_transaction::type_id::create("my_tran", this);
        next_is_valid = 0;
        counter = 0;
        state = 4'b0000;
            forever begin
                @(posedge vinf.clk);
                #0ns;
                // here we will check the state of the DUT
                // and if the DUT is ready to accept the transaction
                // we will read the data from the DUT
                // and write it to the analysis port
                // a valid state is 1010
                if(vinf.rst == 1) begin
                    state = 4'b0000;
                    next_is_valid = 0;
                    counter = 0;
                    state_queue.delete();
                    my_tran.res_out = 0;
                    my_tran.rst = 1;
                    mon_in_ap.write(my_tran);
                    continue;
                end
                else begin
                
                    if (next_is_valid == 1) begin
                        if(counter < 32) begin
                            my_tran.data_out[counter] = vinf.data_in;
                            counter++;
                        end
                        else begin
                            mon_in_ap.write(my_tran);
                            counter = 0;
                            next_is_valid = 0;
                            state = 4'b0000;
                            state_queue.delete();
                        end
                    end

                    state = calc_state(state, vinf.data_in);
                    if(state == 4'b1010) begin
                        next_is_valid = 1;
                        state_queue.delete();
                        state = 4'b0000;
                    end 
                end
            end
    endtask

    function bit [3:0] calc_state(bit [3:0] state, bit data_in);
        this.state_queue.push_back(data_in);
        if(this.state_queue.size() > 4) begin
            this.state_queue.pop_front();
        end        
        if(this.state_queue.size() == 4) begin
            if(this.state_queue[0] == 1 && this.state_queue[1] == 0 && this.state_queue[2] == 1 && this.state_queue[3] == 0) begin
                return 4'b1010;
            end
        end
        return 0;
    endfunction
endclass