class my_sequencer extends uvm_sequencer #(my_transaction);

   `uvm_sequencer_utils(my_sequencer)
          // my_sequence my_seq;
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  

endclass