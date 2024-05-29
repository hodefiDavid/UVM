`uvm_analysis_imp_decl(_port_in)
`uvm_analysis_imp_decl(_port_out)

`include "ref_model.sv"

class scoreboard extends uvm_scoreboard;

`uvm_component_utils(scoreboard)   

uvm_analysis_imp_port_in#(my_transaction, scoreboard) scb_port_in;
uvm_analysis_imp_port_out#(my_transaction, scoreboard) scb_port_out;

ref_model ref_m;
my_transaction trans_ref;
my_transaction trans_out;
int num_of_trans_in = 0;
int num_of_trans_out = 0;
my_transaction last_expected;
my_transaction my_res_fifo[$];
my_transaction my_data_fifo[$];

function new(string name = "scoreboard", uvm_component parent);
    super.new(name, parent);
    trans_ref = new("trans_ref");
    trans_out = new("trans_out");
    last_expected = new("last_expected");
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
    trans_ref = ref_m.step(trans);
    insert_into_data_fifo(trans_ref);
    insert_into_res_fifo(trans_ref);
endfunction

function void insert_into_data_fifo(my_transaction tr);

    if(tr.is_data_valid == 1) begin
        // need to fix it 
        if(my_data_fifo.size() == 0)
            my_data_fifo.push_back(tr);

        else if(my_data_fifo[my_data_fifo.size()-1].rd_data != tr.rd_data)
            my_data_fifo.push_back(tr);

    end
endfunction

function void insert_into_res_fifo(my_transaction tr);

    if(tr.is_data_valid == 0) begin
        // need to fix it 
        if(my_res_fifo.size() == 0)
            my_res_fifo.push_back(tr);

        else if(my_res_fifo[my_res_fifo.size()-1].res_out != tr.res_out)
            my_res_fifo.push_back(tr);

    end
endfunction

virtual function void write_port_out(my_transaction trans);
// if fifo is empty then wait for the data to be ready
    if(trans.is_data_valid == 1)
        compare_data(trans, my_data_fifo.pop_front());
    else
        compare_res(trans_out, my_res_fifo.pop_front());

endfunction

function void compare_data(my_transaction dut_out, my_transaction ref_out);
    if(dut_out.rd_data != ref_out.rd_data )
        test_failed(dut_out, ref_out);
    else
        test_passed(dut_out, ref_out);
endfunction

function void compare_res(my_transaction dut_out, my_transaction ref_out);
    if(dut_out.res_out != ref_out.res_out )
        test_failed(dut_out, ref_out);
    else
        test_passed(dut_out, ref_out);
    endfunction

function void test_passed(my_transaction dut_out, my_transaction ref_out);
            `uvm_info(get_type_name(), "TEST PASSED", UVM_LOW )
            print_more_data(dut_out, ref_out);
endfunction

function void test_failed(my_transaction dut_out, my_transaction ref_out);
            `uvm_warning("", "TEST FAILED")
            print_more_data(dut_out, ref_out);
endfunction

function void print_more_data(my_transaction dut_out, my_transaction ref_out);
    $display("DUT OUT: %0d %0d", dut_out.res_out, dut_out.rd_data);
    $display("REF OUT: %0d %0d", ref_out.res_out, ref_out.rd_data);
    $display("time: %0t", $time);
    // ref_out.print();
    // dut_out.print();
endfunction

endclass
