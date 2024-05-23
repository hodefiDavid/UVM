`uvm_analysis_imp_decl(_port_in)
`uvm_analysis_imp_decl(_port_out)
`include "ref_model.sv"

class scoreboard extends uvm_scoreboard;
    `uvm_component_utils(scoreboard)
    
    uvm_analysis_imp_port_in#(my_transaction, scoreboard) scb_port_in;
    uvm_analysis_imp_port_out#(my_transaction, scoreboard) scb_port_out;
    
    ref_model ref_m;
    my_transaction my_fifo[$];

    my_transaction tr_in;
    my_transaction tr_out;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        tr_in = new("tr_in");
        tr_out = new("tr_out");
        ref_m = new();
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        scb_port_in = new("scb_port_in", this);
        scb_port_out = new("scb_port_out", this);
    endfunction



    function void connect_phase(uvm_phase phase);
    endfunction

    virtual function void write_port_in(my_transaction trans_in);
   
        this.tr_in.up_down = trans_in.up_down;
        this.tr_in.load = trans_in.load;
        this.tr_in.data_in = trans_in.data_in;
        this.tr_in.rst = trans_in.rst;
        my_fifo.push_back(ref_m.step(this.tr_in));
    endfunction

    virtual function void write_port_out(my_transaction trans_out);
        compare(trans_out, my_fifo.pop_front());
    endfunction

    task compare(my_transaction t_in, my_transaction t_out);
        if(t_in.count == t_out.count) begin
            print_success();
        end
        else begin
            print_fail(t_in,t_out);
        end
    endtask

    
    task print_success();
        `uvm_info("", {"test: OK!"}, UVM_LOW)
    endtask

    task print_fail(my_transaction t_in, my_transaction t_out);
        `uvm_warning("compare", {"test: Fail!"})
        `uvm_info("", $sformatf("t_in.rst %0d",t_in.rst), UVM_LOW)
        `uvm_info("", $sformatf("t_in.load %0d",t_in.load), UVM_LOW)
        `uvm_info("", $sformatf("t_in.data_in %0d",t_in.data_in), UVM_LOW)
        `uvm_info("", $sformatf("t_in.enable %0d",t_in.up_down), UVM_LOW)
        `uvm_info("", $sformatf("t_out.count %0d",t_out.count), UVM_LOW)

    endtask

    task print_ignore();
        `uvm_info("", {"test: Ignore!"}, UVM_LOW)
    endtask


   endclass 
   

