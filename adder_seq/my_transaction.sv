// calss transaction uvm sqeuence item
class my_transaction extends uvm_sequence_item;

    rand bit enable;
	rand bit [3:0] a, b;
	bit [4:0] sum;
    // rst is not rand, so it will not be randomized
    bit rst = 0;

    `uvm_object_utils(my_transaction);

    function new(string name = "my_transaction");
        super.new(name);
    endfunction
    
    // function void do_print(uvm_printer printer);
    //     super.do_print(printer);
    //     printer.print_field_int("a", a, $bits(a), UVM_DEC, ".", "size");
    //     printer.print_field_int("b", b, $bits(b), UVM_DEC, ".", "size");
    //     printer.print_field_int("sum", sum, $bits(sum), UVM_DEC, ".", "size");
    //     printer.print_field_int("enable", enable, $bits(enable), UVM_BIN, ".", "size");
    //     printer.print_field_int("rst", rst, $bits(rst), UVM_BIN, ".", "size");
    // endfunction

endclass