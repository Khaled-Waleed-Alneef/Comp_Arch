module ALU #(
    parameter REGF_WIDTH = 32
) (
    input [REGF_WIDTH-1:0] op1,
    input [REGF_WIDTH-1:0] op2,
    input [3:0] alu_ctrl,
    output logic [REGF_WIDTH-1:0] alu_result,
    output logic zero,
    output logic less_signed,
    output logic less_unsigned
);

  always @(*) begin
    case (alu_ctrl)
      // ADD
      4'b0000: alu_result = $signed(op1) + $signed(op2);
      // SLL
      4'b0001: alu_result = $unsigned(op1) << $unsigned(op2);
      // SLT
      4'b0010: begin
        if ($signed(op1) < $signed(op2)) alu_result = 1;
        else alu_result = 0;
      end
      // SLTU
      4'b0011: begin
        if ($unsigned(op1) < $unsigned(op2)) alu_result = 1;
        else alu_result = 0;
      end
      // XOR
      4'b0100: alu_result = op1 ^ op2;
      // SRL
      4'b0101: alu_result = $unsigned(op1) >> $unsigned(op2);
      // OR
      4'b0110: alu_result = op1 | op2;
      //AND
      4'b0111: alu_result = op1 & op2;
      // SUB
      4'b1000: alu_result = op1 - op2;
      // SRA
      4'b1101: alu_result = $signed(op1) >>> op2;
      //default
      default: alu_result = 0;
    endcase

    if (alu_result == 32'd0) begin
      zero = 1;
    end else zero = 0;
    if ($signed(op1) < $signed(op2)) begin
      less_signed = 1;
    end else less_signed = 0;
    if ($unsigned(op1) < $unsigned(op2)) begin
      less_unsigned = 1;
    end else less_unsigned = 1;
  end

endmodule
