// calss transaction uvm sqeuence item

class my_transaction extends uvm_sequence_item;
    
    parameter int ADDR_WIDTH = 2;
    parameter int DATA_WIDTH = 8;
    // 0-write, 1-read
    rand bit rd_wr;
    // address to be written/read
    rand bit [ADDR_WIDTH-1:0] addr;
    // enable for writing/reading
    rand bit enable;
    // data to be written
    rand bit [DATA_WIDTH-1:0] wr_data;
    bit reset = 0;

    // out put port 
    bit [DATA_WIDTH-1:0] rd_data;
    bit [16-1:0] res_out;
    // bit to determine if the transaction data is valid or not 
    // we use it in the scoreboard and the reference model
    bit is_data_valid = 0;


    // `uvm_object_utils(my_transaction);

    function new(string name = "my_transaction");
        super.new(name);
    endfunction

    `uvm_object_utils_begin(my_transaction)
        `uvm_field_int(rd_wr, UVM_ALL_ON | UVM_UNSIGNED)
        `uvm_field_int(addr, UVM_ALL_ON | UVM_UNSIGNED)
        `uvm_field_int(wr_data, UVM_ALL_ON | UVM_UNSIGNED)
        `uvm_field_int(rd_data, UVM_ALL_ON | UVM_UNSIGNED)
        `uvm_field_int(res_out, UVM_ALL_ON | UVM_UNSIGNED)
        `uvm_field_int(reset, UVM_ALL_ON | UVM_UNSIGNED)
        `uvm_field_int(is_data_valid, UVM_ALL_ON | UVM_UNSIGNED)

   `uvm_object_utils_end

endclass