module fifo  #(
// parameter declarations
parameter AWIDTH = 4,  
parameter DWIDTH = 4
)
(

// port declarations
input 	   clk, rst, write_en, read_en,
input	      [DWIDTH-1:0] data_in,
output      full, empty,
output reg  [DWIDTH-1:0] data_out
);

// variable declarations
localparam DEPTH = 2** AWIDTH;  
reg [DWIDTH-1:0] mem [0:DEPTH-1];

reg [AWIDTH-1:0] wptr;  
reg [AWIDTH-1:0] rptr;  
reg wrote;

// functional code
always @(posedge clk or posedge rst) begin
	if (rst) begin
		rptr <= 1'b0;
		wptr <= 1'b0;
		wrote <= 1'b0;  
	end
	else if (read_en && !empty)  begin
			data_out <= mem[rptr];
			rptr <= rptr + 1;  
			wrote <= 0;
	end
	else if (write_en && !full)  begin
		mem[wptr] <= data_in;
		wptr <= wptr + 1;
		wrote <= 1;  
	end 
end

assign empty = (rptr == wptr) && !wrote;  
assign full  = (rptr == wptr) &&	wrote;

endmodule
