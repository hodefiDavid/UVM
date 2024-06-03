class my_sequence extends uvm_sequence #(my_transaction);

  `uvm_object_utils(my_sequence);

  function new (string name = "");
    super.new(name);
  endfunction
  
  event done;
  bit [7:0] num;
  task body();
	#20

	repeat(10) begin
		num = num + 1;
	`uvm_do_with(req, {req.EXE == 1; req.OP == 1; req.A == num; req.B == num;})
	end

	repeat(10) begin
		`uvm_do(req)
	end

    #100;
    ->done;
  endtask
  
endclass
