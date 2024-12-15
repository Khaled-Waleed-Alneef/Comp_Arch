module alu #(
    parameter ALU_WIDTH = 4
) (
    input [ALU_WIDTH-1:0] a,
    input [ALU_WIDTH-1:0] b,
    input [1:0] sel,
    output logic [ALU_WIDTH-1:0] out
);

  always @(a, b) begin
    case (sel)
      0: out = a + b;
      1: out = a & b;
      2: out = a | b;
      3: out = a - b;
    endcase
  end





endmodule
