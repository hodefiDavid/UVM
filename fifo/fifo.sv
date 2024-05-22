module fifo  #(
// parameter declarations
parameter AWIDTH = 4,  
parameter DWIDTH = 4
)
(
// port declarations
inf.DUT i_inf
);

// variable declarations
localparam DEPTH = 2** AWIDTH;  
reg [DWIDTH-1:0] mem [0:DEPTH-1];

reg [AWIDTH-1:0] wptr;  
reg [AWIDTH-1:0] rptr;  
reg wrote;

// functional code
always @(posedge i_inf.clk or posedge i_inf.rst) begin
	if (i_inf.rst) begin
		rptr <= 1'b0;
		wptr <= 1'b0;
		wrote <= 1'b0;  
	end
	else if (i_inf.read_en && !i_inf.empty)  begin
			i_inf.data_out <= mem[rptr];
			rptr <= rptr + 1;  
			wrote <= 0;
	end
	else if (i_inf.write_en && !i_inf.full)  begin
		mem[wptr] <= i_inf.data_in;
		wptr <= wptr + 1;
		wrote <= 1;  
	end 
end

assign i_inf.empty = (rptr == wptr) && !wrote;  
assign i_inf.full  = (rptr == wptr) &&	wrote;

endmodule