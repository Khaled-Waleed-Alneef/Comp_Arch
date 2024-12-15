module Top #(
    parameter REGF_WIDTH = 16,
    parameter PROG_VALUE = 3,
    parameter ALU_WIDTH  = 16,
    parameter IMEM_DEPTH = 4
) (
    input clk,
    input rst_n
);
  logic [$clog2(PROG_VALUE)-1:0]addr;
  logic [7:0] instruction;

  logic [1:0] opcode, rs1, rs2, rd;
  logic [REGF_WIDTH-1:0] op1, op2;
  logic [ALU_WIDTH-1:0] ALUo;

  assign opcode = instruction[1:0];
  assign rs1 = instruction[3:2];
  assign rs2 = instruction[5:4];
  assign rd = instruction[7:6];

  program_counter #(PROG_VALUE) pc (
      .clk(clk),
      .rst_n(rst_n),
      .Q(addr)
  );
  instruction_memory #(IMEM_DEPTH, PROG_VALUE) ROM (
      .addr(addr),
      .instruction(instruction)
  );



  alu #(ALU_WIDTH) ALU (
      .a  (op1),
      .b  (op2),
      .sel(opcode),
      .out(ALUo)
  );
  register_file #(REGF_WIDTH, ALU_WIDTH) X (
      .clk (clk),
      .rs1 (rs1),
      .rs2 (rs2),
      .rd  (rd),
      .ALUo(ALUo),
      .op1 (op1),
      .op2 (op2)
  );

endmodule
