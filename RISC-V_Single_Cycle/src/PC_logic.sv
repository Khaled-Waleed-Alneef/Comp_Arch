module PC_logic #(
    parameter PC_Size = 32,
    imm_Size = 32
) (
    input [PC_Size-1:0] current_pc,
    input [imm_Size-1:0] offset,
    input [imm_Size-1:0] alu_result,
    input [6:0] opcode,
    input pc_sel,
    output [PC_Size-1:0] next_pc
);
  logic [PC_Size-1:0] PC_add_4, PC_add_offset;
  logic [PC_Size-1:0] PC_is_alu;

  always @(*) begin
    case (opcode[3:2])
      //branch
      2'b00:   PC_add_offset = current_pc + offset;
      //JALR
      2'b01:   PC_add_offset = alu_result;
      //Other
      2'b10:   PC_add_offset = current_pc + offset;
      //JAL 
      2'b11:   PC_add_offset = current_pc + offset;
      default: PC_add_offset = current_pc + offset;
    endcase
  end
  assign PC_add_4 = current_pc + 32'd4;



  assign next_pc  = pc_sel ? PC_add_offset : PC_add_4;

endmodule

