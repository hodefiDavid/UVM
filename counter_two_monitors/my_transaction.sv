// calss transaction uvm sqeuence item
class my_transaction extends uvm_sequence_item;
    
    rand bit enable;
    // manege the disterbtion of the enable
    constraint c_enable { enable dist {0 := 10, 1 := 90}; }

    rand bit load;
    // manege the disterbtion of the load
    constraint c_load { load dist {1 := 10, 0 := 90}; }
    
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