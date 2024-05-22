// calss transaction uvm sqeuence item

class my_transaction extends uvm_sequence_item;
 
    rand bit write_en;
    rand bit read_en;
    //constraint for write_en and read_en they 
    //should not be high at the same time but both could be low
    constraint c_write_read { !(write_en && read_en); }

    rand bit [3:0] data_in;

    // out put port 
    bit full = 0;
    bit empty = 1;
    bit [3:0] data_out;
    bit rst = 0;
    
    // bit to determine if the transaction data is valid or not 
    // we use it in the scoreboard and the reference model
    bit is_data_valid = 0;


    // `uvm_object_utils(my_transaction);

    function new(string name = "my_transaction");
        super.new(name);
    endfunction

    `uvm_object_utils_begin(my_transaction)
        `uvm_field_int(rst, UVM_ALL_ON);
        `uvm_field_int(write_en, UVM_ALL_ON);
        `uvm_field_int(read_en, UVM_ALL_ON);
        `uvm_field_int(data_in, UVM_ALL_ON);
        `uvm_field_int(full, UVM_ALL_ON);
        `uvm_field_int(empty, UVM_ALL_ON);
        `uvm_field_int(data_out, UVM_ALL_ON);

   `uvm_object_utils_end

endclass