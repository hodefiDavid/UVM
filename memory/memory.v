module memory
  #(  
  parameter ADDR_WIDTH = 3,
  parameter DATA_WIDTH = 8
  )
  (
    input clk,
    input rst,
    
    //control signals
    input [ADDR_WIDTH-1:0]  addr,
    input                   wr_en,
    input                   rd_en,
    
    //data signals
    input  [DATA_WIDTH-1:0]     wr_data,
    output reg [DATA_WIDTH-1:0] rd_data
  ); 
  
  int i;
  
  //Memory
  // 8 bit data width and 8 bit address width
  reg [DATA_WIDTH-1:0] mem [2**ADDR_WIDTH];

  //Reset 
  always @(posedge rst) 
    for(i=0;i<2**ADDR_WIDTH;i++) mem[i]=8'hFF;
   
  // Write data to Memory
  always @(posedge clk) 
    if (wr_en)    mem[addr] <= wr_data;

  // Read data from memory
  always @(posedge clk)
    if (rd_en) rd_data <= mem[addr];

endmodule
