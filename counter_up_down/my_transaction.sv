// calss transaction uvm sqeuence item
class my_transaction extends uvm_sequence_item;
    
    rand bit up_down;
    rand bit load;
    
	rand bit [7:0] data_in;
    // manege the disterbtion of the data_in
    // constraint c_data_in { data_in dist {0 := 10, {[0:255]}:30, 8'b11111110:= 10}; }
    
    bit [7:0] count;
    // rst is not rand, so it will not be randomized
    bit rst = 0;
    
    `uvm_object_utils(my_transaction);

    function new(string name = "my_transaction");
        super.new(name);
    endfunction

endclass