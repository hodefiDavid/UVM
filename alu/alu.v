//mine alu module for testing
module ALU #(
    parameter WIDTH = 4
) (
    clk,
    rst_n,
    A,
    B,
    mode,
    Y
);

  input [WIDTH-1:0] A, B;
  input [1:0] mode;
   input clk, rst_n;
  output reg [WIDTH:0] Y;

  always @(posedge clk or negedge rst_n)
    if (!rst_n) Y = 0;
    else begin
      case (mode)
        0: Y = A + B;
        1: Y = A - B;
        2: Y = A + 1;
        3: Y = B + 1;
      endcase

    end

endmodule
