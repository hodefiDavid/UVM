`uvm_analysis_imp_decl(_port_in)
`uvm_analysis_imp_decl(_port_out)
`include "ref_model.sv"
`include "my_coverage.sv"
//define enum type for max size of fifo and min size of fifo
typedef enum {MIN_SIZE = 0, MAX_SIZE = 16} fifo_size_enum;

class scoreboard extends uvm_scoreboard;

`uvm_component_utils(scoreboard)   

uvm_analysis_imp_port_in#(my_transaction, scoreboard) scb_port_in;
uvm_analysis_imp_port_out#(my_transaction, scoreboard) scb_port_out;

my_coverage cov;
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
    cov = new();
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    scb_port_in = new("scb_port_in", this); 
    scb_port_out = new("scb_port_out", this);
endfunction

function void connect_phase(uvm_phase phase);
endfunction

virtual function void write_port_in(my_transaction trans);
trans_in.read_en = trans.read_en;
trans_in.write_en = trans.write_en;
trans_in.data_in = trans.data_in;

trans_ref = ref_m.step(trans_in);
my_fifo.push_back(trans_ref);
endfunction

virtual function void write_port_out(my_transaction trans);
// if fifo is empty then wait for the data to be ready
if ((my_fifo.size() == 0)) begin
  wait(my_fifo.size() != 0)
end
else begin
    trans_out.full = trans.full;
    trans_out.empty = trans.empty;
    trans_out.data_out = trans.data_out;

    compare(trans_out, my_fifo.pop_front());
end
endfunction

virtual function void compare(my_transaction dut_out, my_transaction ref_out);
    if((dut_out.empty != ref_out.empty) || (dut_out.full != ref_out.full)) begin
        `uvm_warning("", "TEST FAILED")
    
         if (ref_out.is_data_valid)
            if(dut_out.data_out != ref_out.data_out)
        `uvm_warning("", "TEST FAILED")
            else
        `uvm_info(get_type_name(), "TEST PASSED", UVM_LOW)
    end
    else
        `uvm_info(get_type_name(), "TEST PASSED", UVM_LOW)
    endfunction
endclass
