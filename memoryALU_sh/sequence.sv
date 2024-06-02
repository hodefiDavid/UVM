class my_sequence extends uvm_sequence #(my_transaction);

  `uvm_object_utils(my_sequence);

  function new (string name = "");
    super.new(name);
  endfunction
  
  event done;
  
  task body();
	#20
	`uvm_do_with(req, { req.addr == 0; req.rd_wr == 0; req.enable == 1;})
	`uvm_do_with(req, { req.addr == 0; req.rd_wr == 0; req.enable == 0;})
	`uvm_do_with(req, { req.addr == 0; req.rd_wr == 1; req.enable == 1;})
	`uvm_do_with(req, { req.addr == 1; req.rd_wr == 0; req.enable == 1;})
	`uvm_do_with(req, { req.addr == 2; req.wr_data == 1; req.rd_wr == 0; req.enable == 1;})
	`uvm_do_with(req, { req.addr == 3; req.wr_data == 1; req.rd_wr == 0; req.enable == 1;})
	`uvm_do_with(req, { req.addr == 0; req.rd_wr == 0; req.enable == 1;})
	
	repeat(5000) begin
		`uvm_do(req)
	end

    #100;
    ->done;
  endtask
  
endclass
