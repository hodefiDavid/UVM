
class my_sequence extends uvm_sequence #(my_transaction);
    `uvm_object_utils(my_sequence)
    
    function new(string name = "my_sequence");
        super.new(name);
    endfunction

    task body();

        repeat(2000) begin
            // start_item() is a method of uvm_sequence that creates a new transaction
            // and sends it to the sequencer
            req = my_transaction::type_id::create("req");
            start_item(req);
            if(!req.randomize())
                `uvm_error(get_type_name(), "randomize failed")

            // finish_item() is a method of uvm_sequence that sends the transaction to the driver
            // and waits for the driver to finish processing the transaction
            finish_item(req);
        end

    endtask

    
endclass