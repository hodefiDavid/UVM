// calss transaction uvm sqeuence item
class my_transaction extends uvm_sequence_item;
    
    rand bit write_en;
    rand bit read_en;
    //constraint for write_en and read_en they 
    //should not be high at the same time but both could be low
    constraint c_write_read { !(write_en && read_en); }


    rand bit [3:0] data_in;

    // out put port 
    bit full;
    bit empty;
    bit [3:0] data_out;
    bit rst = 0;
    
    `uvm_object_utils(my_transaction);

    function new(string name = "my_transaction");
        super.new(name);
    endfunction

endclass