`uvm_analysis_imp_decl(_port_res_out)
`uvm_analysis_imp_decl(_port_data_out)
`uvm_analysis_imp_decl(_port_in)
class scoreboard extends uvm_scoreboard;

  `uvm_component_utils(scoreboard)
  uvm_analysis_imp_port_in #(my_transaction, scoreboard) scb_port_in;
  uvm_analysis_imp_port_res_out #(my_transaction, scoreboard) scb_port_res_out;
  uvm_analysis_imp_port_data_out #(my_transaction, scoreboard) scb_port_data_out;

  logic [7:0] rd_data;
  reg [15:0] res_out;
  reg [15:0] last_res_out;
  bit [7:0] mem[4];

  bit [15:0] fifo[$];


  function new(string name, uvm_component parent);
    super.new(name, parent);
    reset();
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    scb_port_in = new("scb_port_in", this);
    scb_port_res_out = new("scb_port_res_out", this);
    scb_port_data_out = new("scb_port_data_out", this);
  endfunction

  virtual function void write_port_in(my_transaction trans);
    if (trans.enable) begin
      if (trans.rd_wr) begin
        case (trans.addr)
          0: rd_data = mem[trans.addr];
          1: rd_data = mem[trans.addr];
          2: rd_data = mem[trans.addr][2:0];
          3: rd_data = mem[trans.addr][0];
        endcase
      end else mem[trans.addr] = trans.wr_data;

    end

    if (mem[3][0] == 1) begin
      int A = mem[0];
      int B = mem[1];
      int OPER = mem[2][2:0];
      case (OPER)
        0: res_out = 0;
        1: res_out = A + B;
        2: res_out = A - B;
        3: res_out = A * B;
        4: res_out = (B == 0) ? 16'hDEAD : A / B;
      endcase
      if (last_res_out !== res_out) begin
        fifo.push_front(res_out);
        last_res_out = res_out;
      end
    end
  endfunction

  virtual function void write_port_res_out(my_transaction trans);
    if (fifo.size() == 0) $display("ERROR: FIFO EMPTY !!");
    else begin
      bit [15:0] temp = fifo.pop_back();
      if (temp != trans.res_out) begin
        $display("----------------------------------");
        $display("SCB res: %d, DUT res: %d", temp, trans.res_out);
        $display("----------------------------------");
      end else begin
        $display("Test Passed !!");
      end
    end
  endfunction

  virtual function void write_port_data_out(my_transaction trans);
    if (rd_data != trans.rd_data) begin
      $display("----------------------------------");
      $display("SCB read: %d, DUT read: %d", rd_data, trans.rd_data);
      $display("----------------------------------");
    end else begin
      $display("Test Passed !!");
    end
  endfunction

  function void reset();
    fifo.push_front(0);
    rd_data = 0;
  endfunction
endclass
