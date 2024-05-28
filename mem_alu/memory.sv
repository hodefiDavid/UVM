

//! {
//!   signal: [
//!     { name: "clk",        wave: "P.....",                                           period: 2  },
//!     { name: "enable", wave: "01010.",                                           period: 2  },
//!     { name: "rd_wr",     wave: "101...",                                           period: 2  },
//!     { name: "addr",   wave: "x.2.x.2.x...",   data: ["addr","addr"] },
//!     { name: "wr_data",   wave: "x.2.x..x....",   data: ["write data"] },
//!     { name: "rd_data",wave: "x.......2.x.",   data: ["read data"] },
//!   ],
//!   head:{
//!     text:'WaveDrom Memory Example',
//!     tick:0,
//!     every:2
//!   }
//! }

//! This module can execute simple arithmetic operations (addition, subtraction, multiplication, and division) based on operation codes stored in specific memory locations (OPER, A, B). The result of the operation is stored in res_out. If division is attempted with a divisor of zero, a default error code (0xDEAD) is stored in res_out to indicate the error. The operations are triggered by a specific execution bit in the memory (EXECUTE).

//!   Overall, this module combines basic memory functionality with simple arithmetic processing, all controlled via input signals and internal memory organization

module memory
  #( parameter int ADDR_WIDTH = 2, //! bit address width drive by master
     parameter int DATA_WIDTH = 8 //! bit data width
   )
  (
    input clk, //! 100 MHz
    input reset, //! active high
    
    //control signals
    input [ADDR_WIDTH-1:0]  addr, //! Address for writing/reading
    input                   enable,//! enable for writing/reading
    input                   rd_wr,//! 0-write 1-read
    
    //data signals
    input  [DATA_WIDTH-1:0] wr_data,//! write data drive by master
    output reg [DATA_WIDTH-1:0] rd_data,//! read data drive by slave
	  output reg [16-1:0] res_out //! output result
  ); 
  
  
  parameter A = 0;
  parameter B = 1;
  parameter OPER = 2;
  parameter EXECUTE = 3;
  

  
  //Memory
  reg [DATA_WIDTH-1:0] mem [2**ADDR_WIDTH];

  always @(posedge clk or posedge reset) begin
    if(reset) begin
      mem <= '{default:'0};
      rd_data <=0;
      res_out <=0;
    end
  end
  // Write data to Memory
  always @(posedge clk) 
    if (!(rd_wr)  & enable) begin  
      if(addr<2)
        mem[addr] <= wr_data;
      else if (addr==2)
        mem[addr][2:0] <= wr_data;
      else if (addr==3)
        mem[addr][0] <= wr_data;
    end
    
  // Read data from memory
  always @(posedge clk)
    if ((rd_wr) & enable) rd_data <= mem[addr];
  always @(posedge clk)
    if (mem[EXECUTE][0])begin
		if(mem[OPER]==0)
			res_out<=0;
		else if (mem[OPER]==1)
			res_out<=mem[A]+mem[B];
		else if (mem[OPER]==2)
			res_out<=mem[A]-mem[B];
		else if (mem[OPER]==3)
			res_out<=mem[A]*mem[B];
		else if (mem[OPER]==4)
			if(mem[B]!=0)
				res_out<=mem[A]/mem[B];
			else
				res_out<=16'hdead;
			
	end

endmodule












