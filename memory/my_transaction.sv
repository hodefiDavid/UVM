// calss transaction uvm sqeuence item

class my_transaction extends uvm_sequence_item;
    parameter ADDR_WIDTH = 3;
    parameter DATA_WIDTH = 8;
    
    // input port
         bit rst = 0;
    rand bit wr_en;
    rand bit rd_en;
    rand bit [ADDR_WIDTH-1:0]  addr;
    rand bit [DATA_WIDTH-1:0]  wr_data;
    //constraint for write_en and read_en they 
    //should not be high at the same time but both could be low
    // constraint c_write_read { !(wr_en && rd_en); }


    // out put port 
    bit [DATA_WIDTH-1:0]  rd_data;
    
    // bit to determine if the transaction data is valid or not 
    // we use it in the scoreboard and the reference model
    bit is_data_valid = 0;

    // `uvm_object_utils(my_transaction);

    function new(string name = "my_transaction");
        super.new(name);
    endfunction

    `uvm_object_utils_begin(my_transaction)
        `uvm_field_int(rst, UVM_ALL_ON | UVM_DEC)
        `uvm_field_int(wr_en, UVM_ALL_ON | UVM_DEC)
        `uvm_field_int(rd_en, UVM_ALL_ON | UVM_DEC)
        `uvm_field_int(addr, UVM_ALL_ON | UVM_DEC)
        `uvm_field_int(wr_data, UVM_ALL_ON | UVM_DEC)
        `uvm_field_int(rd_data, UVM_ALL_ON | UVM_DEC)
        `uvm_field_int(is_data_valid, UVM_ALL_ON | UVM_DEC)
        //UVM_DEC change the default printer to print in unsigned format
   `uvm_object_utils_end

endclass