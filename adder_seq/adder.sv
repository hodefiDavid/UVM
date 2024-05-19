module adder(inf.DUT i_inf);

  reg [4:0] tmp_sum;

  // reset + add operation
  always @(posedge i_inf.clk, posedge i_inf.rst)
    if (i_inf.rst)           tmp_sum <= 0;
    else if (i_inf.enable)   tmp_sum <= i_inf.a + i_inf.b;

  //  // Delay the output in 1 clock
  // always @(posedge i_inf.clk, posedge i_inf.rst)
  //   if (i_inf.rst)           i_inf.sum <= 0;
  //   else                     i_inf.sum <= tmp_sum;
  assign i_inf.sum = tmp_sum;

endmodule


