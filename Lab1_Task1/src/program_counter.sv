module program_counter #(
    parameter PROG_VALUE = 3
) (
    input clk,
    input rst_n,
    output logic [$clog2(PROG_VALUE)-1:0] Q
);
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) Q = 0;

    else Q = Q + 1;
  end
endmodule
