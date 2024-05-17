
class my_sequence extends uvm_sequence #(my_transaction);
    `uvm_object_utils(my_sequence)
    
    function new(string name = "my_sequence");
        super.new(name);
    endfunction

    task body();

        repeat(10) begin
            // this is the transaction that will be created and randomized
            
            req = my_transaction::type_id::create("req");
            start_item(req);
            if(!req.randomize())
                `uvm_error(get_type_name(), "randomize failed")

            `uvm_info(get_type_name(), {"data_in=", req.data_in, " load=", req.load, " enable=", req.enable}, UVM_MEDIUM)
            finish_item(req);
        end

    endtask

    
endclass