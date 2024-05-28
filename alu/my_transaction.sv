// calss transaction uvm sqeuence item

class my_transaction extends uvm_sequence_item;
 
    bit rst_n;
    rand bit  [3:0] A, B;
    rand bit  [1:0] mode;
    bit [4:0] Y;

    function new(string name = "my_transaction");
        super.new(name);
    endfunction

    `uvm_object_utils_begin(my_transaction)
        `uvm_field_int(rst_n, UVM_ALL_ON | UVM_UNSIGNED)
        `uvm_field_int(A, UVM_ALL_ON | UVM_UNSIGNED)
        `uvm_field_int(B, UVM_ALL_ON | UVM_UNSIGNED)
        `uvm_field_int(mode, UVM_ALL_ON | UVM_UNSIGNED)
        `uvm_field_int(Y, UVM_ALL_ON | UVM_UNSIGNED)
   `uvm_object_utils_end

endclass