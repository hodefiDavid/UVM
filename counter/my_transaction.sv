// calss transaction uvm sqeuence item
class my_transaction extends uvm_sequence_item;

    //declare the transaction fields
    rand bit [7:0] data_in;
    rand bit load;
    rand bit enable;
       bit [7:0] count;
    bit rst = 0;

    `uvm_object_utils(my_transaction);

    function new(string name = "my_transaction");
        super.new(name);
    endfunction

endclass