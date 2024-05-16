// header - package file to include the env and test
package header;

	import uvm_pkg::*;
	`include "uvm_macros.svh"
	//`include "interface.sv" we shuld declear the interface in here
	`include "driver.sv"
	`include "env.sv"
	`include "random_test.sv"

endpackage