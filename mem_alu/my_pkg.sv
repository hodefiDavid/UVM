`include "interface.sv"
`include "memory.sv"
package my_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  `include "my_transaction.sv"
 // `include "coverage.sv"
  `include "my_sequence.sv"
  `include "my_sequencer.sv"
  `include "my_driver.sv"
  `include "monitor_in.sv"
  `include "monitor_out_res.sv"
  `include "monitor_out_data.sv"
  `include "my_agent_res.sv"
  `include "my_agent_data.sv"
  `include "my_agent.sv"
  `include "my_scoreboard.sv"
  `include "my_env.sv"
  `include "test.sv"
endpackage

