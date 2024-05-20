// this DUT get 12 bits one per clock cycle, 
// and the output is the first 4 bits represente 5 in binary [0101] 
// if the input in the first 4 bit header  is A, 
// the rest 8 bits are the same as the input

module a_to_five(
    input in, valid,
    output [11:0] out
);
    reg [11:0] reg_out;
    reg [3:0] header;
    reg got_header[2:0];
    reg got_data[3:0];

    always @(posedge clk) begin
        if (valid) begin
            if (got_header == 2'b11) begin
                if(header == 4'b1010) begin
                    reg_out[11:got_data] = in;
                    reg_out[3:0] = 4'b0101;
                    got_data = got_data + 1;
                end
                else begin
                    out[11:0] = 12'b0;
                end
            end
        end
    end

    assign out = reg_out;

endmodule
