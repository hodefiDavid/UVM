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
// int fifo_size = 0;
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
trans_in.read_en = trans.read_en;
trans_in.write_en = trans.write_en;
trans_in.data_in = trans.data_in;

trans_ref = ref_m.step(trans_in);
my_fifo.push_back(trans_ref);
endfunction

virtual function void write_port_out(my_transaction trans);
trans_out.full = trans.full;
trans_out.empty = trans.empty;
trans_out.data_out = trans.data_out;

compare(trans_out, my_fifo.pop_front());
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








// `uvm_analysis_imp_decl(_port_in)
// `uvm_analysis_imp_decl(_port_out)

// class scoreboard extends uvm_scoreboard;
//     `uvm_component_utils(scoreboard)
    
//     uvm_analysis_imp_port_in#(my_my_transaction, scoreboard) scb_port_in;
//     uvm_analysis_imp_port_out#(my_my_transaction, scoreboard) scb_port_out;
    
//     my_my_transaction queue_trans_in  [$];
//     my_my_transaction queue_trans_out [$];
//     my_my_transaction tr_in;
//     my_my_transaction tr_out;

// /////////////data structurs//////////////////
//     bit [3:0] queue_data[$];
//     int MIN_SIZE = 0;
//     int MAX_SIZE = 16;
    
// ////////////////////////////////////////////
//     function new(string name, uvm_component parent);
//         super.new(name, parent);
//         tr_in = new("tr_in");
//         tr_out = new("tr_out");
//     endfunction
    
//     function void build_phase(uvm_phase phase);
//         super.build_phase(phase);
//         scb_port_in = new("scb_port_in", this);
//         scb_port_out = new("scb_port_out", this);

//     endfunction



//     function void connect_phase(uvm_phase phase);
//     endfunction

//     virtual function void write_port_in(my_my_transaction trans_in);
   
//         this.tr_in.rst = trans_in.rst;
//         this.tr_in.write_en = trans_in.write_en;
//         this.tr_in.read_en = trans_in.read_en;
//         this.tr_in.data_in = trans_in.data_in;
//         `uvm_info("", {"scoreboard: write_port_in"}, UVM_LOW)
//         trans_in.print();

//     endfunction

//     virtual function void write_port_out(my_my_transaction trans_out);
//         `uvm_info("", {"scoreboard: write_port_out"}, UVM_LOW)
//         trans_out.print();
//         this.tr_out.full = trans_out.full;
//         this.tr_out.empty = trans_out.empty;
//         this.tr_out.data_out = trans_out.data_out;
//         compare_outcome(this.tr_in, this.tr_out);
//     endfunction

//     task compare_outcome(my_my_transaction t_in, my_my_transaction t_out);

//         if(t_in.rst == 1'b1) begin

//             if(t_out.full == 1'b0 && t_out.empty == 1'b1 ) begin
//                 print_success();
//             end
//             else begin
//                 print_fail(t_in, t_out);
//             end
//             queue_data.delete();
//         end
//         else begin
//             // i assume that the rst is "stronger" than the write_en and read_en assertion
//                 assert (t_in.write_en && t_in.read_en) 
//                 else begin
//                         $error("Error: Both t_in.write_en and t_in.read_en are 1");
//                         print_fail(t_in, t_out);
//                         return;
//                     end
//             if(t_in.write_en == 1'b1) begin
//                 if(queue_data.size() < MAX_SIZE) begin
//                     queue_data.push_back(t_in.data_in);
//                     cmp_em_full(t_in,t_out);
//                 end
//             end
//             else if(t_in.read_en == 1'b1) begin
//               if(!is_empty()) begin
//                     cmp_em_full_data(t_in,t_out, queue_data.pop_front());  
//               end
//               else begin
//                     cmp_em_full(t_in,t_out);
//               end  
//             end
//         end

//     endtask
    
//     function bit cmp_em_full_data(my_my_transaction t_in,my_my_transaction t_out, bit[3:0] data);
//         if(cmp_em_full(t_in,t_out) && t_out.data_out == data) begin
//             print_success();
//         end
//         else begin
//             print_fail(t_in, t_out);
//         end
//     endfunction

//     function bit cmp_em_full(my_my_transaction t_in,my_my_transaction t_out);
//              if(t_out.full == is_full() && t_out.empty == is_empty()) begin
//                             print_success();
//                             return 1;
//                         end
//                         else begin
//                             print_fail(t_in, t_out);
//                             return 0;
                
//                         end
//     endfunction

//     function bit is_full();
//         if(this.queue_data.size() == this.MAX_SIZE) begin
//             return 1;
//         end
//         else begin
//             return 0;
//         end
//     endfunction

//     function bit is_empty();
//         if(this.queue_data.size() == this.MIN_SIZE) begin
//             return 1;
//         end
//         else begin
//             return 0;
//         end
//     endfunction


//     function void print_success();
//         `uvm_info("", {"test: OK!"}, UVM_LOW)
//     endfunction

//     function void print_fail(my_my_transaction t_in, my_my_transaction t_out);
//         `uvm_warning("compare", {"test: Fail!"})
//         `uvm_info("", {"transction IN : "}, UVM_LOW)
//         t_in.print();
//         `uvm_info("", {"transction OUT : "}, UVM_LOW)
//         t_out.print();
//     endfunction

//     function void print_ignore();
//         `uvm_info("", {"test: Ignore!"}, UVM_LOW)
//     endfunction


//    endclass 
   

