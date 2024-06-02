`include "interface.sv"
`include "memory.sv"
package my_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  `include "transaction.sv"
 // `include "coverage.sv"
  `include "sequence.sv"
  `include "sequencer.sv"
  `include "driver.sv"
  `include "monitorIn.sv"
  `include "monitorOut.sv"
  `include "monitorOut2.sv"
  `include "agent.sv"
  `include "agent2.sv"
  `include "scoreboard.sv"
  `include "environment.sv"
  `include "test.sv"
endpackage

