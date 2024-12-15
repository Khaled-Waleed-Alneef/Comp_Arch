module register_file #(

    parameter ALU_WIDTH = 16,
    REGF_WIDTH = 16
) (
    input clk,
    input [1:0] rs1,
    input [1:0] rs2,
    input [1:0] rd,
    input [ALU_WIDTH-1:0] ALUo,
    output logic [REGF_WIDTH-1:0] op1,
    output logic [REGF_WIDTH-1:0] op2
);
  logic [REGF_WIDTH-1:0] X[0:3];
    assign X[0] = 0;

  initial $readmemb("/home/it/Vivado_Projects/Arch/Lab1_Task1/src/fib_rf.mem", X);
  always @(posedge clk) begin
    case (rd)
      1: X[1] = ALUo;
      2: X[2] = ALUo;
      3: X[3] = ALUo;
    endcase


  end
  always_comb begin
    case (rs1)
      0: op1 = X[0];
      1: op1 = X[1];
      2: op1 = X[2];
      3: op1 = X[3];
    endcase


  end

  always_comb begin
    case (rs2)
      0: op2 = X[0];
      1: op2 = X[1];
      2: op2 = X[2];
      3: op2 = X[3];
    endcase


  end
endmodule

