module imm_gen #(
    parameter REGF_WIDTH = 32
) (
    input [REGF_WIDTH-1:0] inst,
    output logic [REGF_WIDTH-1:0] imm

);

  logic [6:0] opcode;
  assign opcode = inst[6:0];

  always @(*) begin
    case (opcode)
      //I-Type 
      7'b0010011: imm = {{20{inst[31]}}, inst[31:20]};
      //S-Type
      7'b0100011: imm = {{20{inst[31]}}, inst[31:25], inst[11:7]};
      //Load
      7'b0000011: imm = {{20{inst[31]}}, inst[31:20]};
      //B-Type
      7'b1100011: imm = {{19{inst[31]}}, inst[31], inst[7], inst[30:25], inst[11:8], 1'b0};
      //R-Type
      7'b0110011: imm = 32'b0;
      //JAL
      7'b1101111: imm = {{11{inst[31]}}, inst[31], inst[19:12], inst[20], inst[30:21], 1'b0};
      //JALR
      7'b1100111: imm = {{20{inst[31]}}, inst[31:20]};
      //AUIPC
      7'b0010111: imm = {inst[31:12], 12'b0};
      //LUI
      7'b0110111: imm = {inst[31:12], 12'b0};
      default: imm = 32'b0;
    endcase
  end
endmodule

