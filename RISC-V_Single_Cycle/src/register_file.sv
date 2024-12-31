module register_file #(
    parameter REGF_WIDTH = 32,
    REGF_DEPTH = 32
) (
    input clk,
    input rst_n,
    input reg_write,
    input [4:0] raddr1,
    input [4:0] raddr2,
    input [4:0] waddr,
    input [REGF_WIDTH-1:0] wdata,
    output logic [REGF_WIDTH-1:0] rdata1,
    output logic [REGF_WIDTH-1:0] rdata2
);
  logic [REGF_WIDTH-1:0] X[0:REGF_DEPTH-1];
  assign X[0]   = 0;

  assign rdata1 = X[raddr1];  // mux1 
  assign rdata2 = X[raddr2];  // mux2

  always @(posedge clk, negedge rst_n) begin
    if (~rst_n) begin
      for (int i = 1; i < 32; i = i + 1) X[i] <= 0;
    end else if (reg_write) begin
      if (waddr != 0) begin
        X[waddr] <= wdata;
      end
    end
  end
endmodule
