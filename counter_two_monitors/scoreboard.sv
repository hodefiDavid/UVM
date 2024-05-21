`uvm_analysis_imp_decl(_port_in)
`uvm_analysis_imp_decl(_port_out)


class scoreboard extends uvm_scoreboard;
    `uvm_component_utils(scoreboard)
    
    uvm_analysis_imp_port_in#(my_transaction, scoreboard) scb_port_in;
    uvm_analysis_imp_port_out#(my_transaction, scoreboard) scb_port_out;
    
    my_transaction queue_trans_in  [$];
    my_transaction queue_trans_out [$];
    bit [7:0] old_count = 0;
    my_transaction tr_in;
    my_transaction tr_out;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        tr_in = new("tr_in");
        tr_out = new("tr_out");
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        scb_port_in = new("scb_port_in", this);
        scb_port_out = new("scb_port_out", this);

    endfunction



    function void connect_phase(uvm_phase phase);
    endfunction

    virtual function void write_port_in(my_transaction trans_in);
   
        this.tr_in.enable = trans_in.enable;
        this.tr_in.load = trans_in.load;
        this.tr_in.data_in = trans_in.data_in;
        this.tr_in.rst = trans_in.rst;

    endfunction

    virtual function void write_port_out(my_transaction trans_out);
        this.tr_out.count = trans_out.count; 
        compare_outcome(this.tr_in, this.tr_out);
    endfunction

    task compare_outcome(my_transaction t_in, my_transaction t_out);
        
       if(t_in.rst == 1) begin
            this.old_count = 0;
            if(t_out.count == 0) begin
                print_success();
            end
            else
                print_fail(t_in,t_out);
       end
         else begin
                if(t_in.load == 1)begin
                    this.old_count = t_in.data_in;
                    if(t_out.count == t_in.data_in) 
                        print_success();
                    else
                        print_fail(t_in,t_out);
                end
                else if(t_in.enable == 1) begin
                    if(t_out.count == this.old_count) //+1
                        print_success();
                    else
                        print_fail(t_in,t_out);
                end
                this.old_count = this.old_count + 1;
         end
        if(t_in.load == 0 && t_in.enable == 0 && t_in.rst == 0)
            print_ignore();
    endtask
    
    task print_success();
        `uvm_info("", {"test: OK!"}, UVM_LOW)
    endtask

    task print_fail(my_transaction t_in, my_transaction t_out);
        `uvm_warning("compare", {"test: Fail!"})
        `uvm_info("", $sformatf("t_in.rst %0d",t_in.rst), UVM_LOW)
        `uvm_info("", $sformatf("t_in.load %0d",t_in.load), UVM_LOW)
        `uvm_info("", $sformatf("t_in.data_in %0d",t_in.data_in), UVM_LOW)
        `uvm_info("", $sformatf("t_in.enable %0d",t_in.enable), UVM_LOW)
        `uvm_info("", $sformatf("t_out.count %0d",t_out.count), UVM_LOW)

    endtask

    task print_ignore();
        `uvm_info("", {"test: Ignore!"}, UVM_LOW)
    endtask
    
    // task run();
    //         fifo_out.get(trans_out);
    //         fifo_out.get(trans_out);

    //     forever begin
    //         fifo_in.get(trans_in);
    //         fifo_out.get(trans_out);
    //         `uvm_info("", {"comparing transactions"}, UVM_LOW)
    //         `uvm_info("", $sformatf("trans_out.sum %0d, trans_in.a %0d, trans_in.b %0d",trans_out.sum,trans_in.a,trans_in.b), UVM_LOW)
    //         //compare the transactions
    //         if (trans_out.sum == trans_in.a + trans_in.b) begin
    //             `uvm_info("compare", {"test: OK!"}, UVM_LOW)
    //         end
    //         else begin
    //             //add a message to the report if the test fails
    //             // using the uvm error macro
    //             `uvm_warning("compare", {"test: Fail!"})
    //             //`uvm_info("compare", {"test: Fail!"}, UVM_MEDIUM)
    //         end
    //     end
    // endtask

endclass