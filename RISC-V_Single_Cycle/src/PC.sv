module PC #(
    parameter PC_Size = 32
) (
    input clk,
    input rst_n,
    input [PC_Size-1:0] next_pc,
    output logic [PC_Size-1:0] current_pc
);

  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) current_pc = 0;
    else current_pc = next_pc;
  end

endmodule

