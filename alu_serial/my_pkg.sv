`include "interface.sv"
`include "alu.sv"
package my_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  `include "my_transaction.sv"
 // `include "coverage.sv"
  `include "my_sequence.sv"
  `include "my_sequencer.sv"
  `include "my_driver.sv"
  `include "monitor_in.sv"
  `include "monitor_out.sv"
  `include "my_agent.sv"
  `include "my_agent_out.sv"
  `include "scoreboard.sv"
  `include "env.sv"
  `include "my_test.sv"
endpackage

