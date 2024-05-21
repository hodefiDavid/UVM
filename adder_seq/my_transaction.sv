// calss transaction uvm sqeuence item
class my_transaction extends uvm_sequence_item;

    // rand bit enable;
     bit enable = 1;
	rand bit [3:0] a, b;
	bit [4:0] sum;
    // rst is not rand, so it will not be randomized
    bit rst = 0;

    `uvm_object_utils(my_transaction);

    function new(string name = "my_transaction");
        super.new(name);
    endfunction

endclass