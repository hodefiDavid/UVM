`uvm_analysis_imp_decl(_port_in)
`uvm_analysis_imp_decl(_port_out)
//define enum type for max size of fifo and min size of fifo

class scoreboard extends uvm_scoreboard;

  `uvm_component_utils(scoreboard)

  uvm_analysis_imp_port_in #(my_transaction, scoreboard) scb_port_in;
  uvm_analysis_imp_port_out #(my_transaction, scoreboard) scb_port_out;

  reg [15:0] res_out;
  reg [15:0] last_res_out;

  bit [15:0] fifo[$];


  function new(string name, uvm_component parent);
    super.new(name, parent);
    reset();
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    scb_port_in  = new("scb_port_in", this);
    scb_port_out = new("scb_port_out", this);
  endfunction

  virtual function void write_port_in(my_transaction trans);


    trans.EXE = trans.data_out[0];
    trans.OP  = trans.data_out[10:8];
    trans.B   = trans.data_out[23:16];
    trans.A   = trans.data_out[31:24];

    $display("SCB: full_register=%b",trans.data_out);
    $display("SCB: A=%d B=%d OP=%d EXE=%d,   time = %d",trans.A,trans.B,trans.OP,trans.EXE,$time);
    if(trans.rst == 1) begin
      fifo.delete();
      last_res_out = 0;
      res_out = 0;
      fifo.push_front(0);
      return;
    end

    if (trans.EXE[0]) begin
      int OPER = trans.OP[2:0];
      case (OPER)
        0: res_out = 0;
        1: res_out = trans.A + trans.B;
        2: res_out = trans.A - trans.B;
        3: res_out = trans.A * trans.B;
        4: begin
          if (trans.B == 0) res_out = 16'hDEAD;
          else res_out = trans.A / trans.B;
        end
        default: res_out = last_res_out;
      endcase

      if (last_res_out !== res_out) begin
        fifo.push_front(res_out);
        last_res_out = res_out;
      end
    end
  endfunction

  virtual function void write_port_out(my_transaction trans);
    if (fifo.size() == 0) $display("ERROR: FIFO EMPTY !!");
    else begin
      bit [15:0] temp = fifo.pop_back();
      if (temp != trans.res_out) begin
        $display("----------------------------------");
        `uvm_warning("", "compare res TEST FAILED !!")
        $display("SCB res: %d, DUT res: %d", temp, trans.res_out);
        $display("----------------------------------");
      end else begin
        $display("Test Passed !!");
      end
    end
  endfunction

  function void reset();
    // fifo.push_front(0); // problem wit the dut
  endfunction
endclass
