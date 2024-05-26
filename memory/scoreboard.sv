`uvm_analysis_imp_decl(_port_in)
`uvm_analysis_imp_decl(_port_out)
`include "ref_model.sv"
//define enum type for max size of fifo and min size of fifo
typedef enum {MIN_SIZE = 0, MAX_SIZE = 16} fifo_size_enum;

class scoreboard extends uvm_scoreboard;

`uvm_component_utils(scoreboard)   

uvm_analysis_imp_port_in#(my_transaction, scoreboard) scb_port_in;
uvm_analysis_imp_port_out#(my_transaction, scoreboard) scb_port_out;

ref_model ref_m;
my_transaction trans_ref;
my_transaction trans_in;
my_transaction trans_out;
int num_of_trans_in = 0;
int num_of_trans_out = 0;
my_transaction my_fifo[$];

function new(string name = "scoreboard", uvm_component parent);
    super.new(name, parent);
    trans_ref = new("trans_ref");
    trans_in = new("trans_in");
    trans_out = new("trans_out");
    ref_m = new();
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    scb_port_in = new("scb_port_in", this); 
    scb_port_out = new("scb_port_out", this);
endfunction

function void connect_phase(uvm_phase phase);
endfunction

virtual function void write_port_in(my_transaction trans);
    trans_in.wr_en = trans.wr_en;
    trans_in.rd_en = trans.rd_en;
    trans_in.addr = trans.addr;
    trans_in.wr_data = trans.wr_data;
    trans_ref = ref_m.step(trans_in);
    if(trans_in.rd_en) //insted of valid 
        my_fifo.push_back(trans_ref);
endfunction

virtual function void write_port_out(my_transaction trans);

    // trans_out.rd_data = trans.rd_data;
    //trans_out  = trans;
    compare(trans, my_fifo.pop_front());
endfunction

virtual function void compare(my_transaction dut_out, my_transaction ref_out);
    if(dut_out.rd_data == ref_out.rd_data) begin
        `uvm_info(get_type_name(), "TEST PASSED", UVM_LOW)
    end
            else begin
                `uvm_warning("", "TEST FAILED")
                // print the transaction that failed
                `uvm_info("", "DUT OUT: " , UVM_LOW)
                dut_out.print();
                `uvm_info("", "REF OUT: " , UVM_LOW)
                ref_out.print();
            end
endfunction

endclass
