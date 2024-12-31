module ALU_control (
    input fun7,
    input [2:0] fun3,
    input [1:0] alu_op,
    output logic [3:0] alu_ctrl
);
  always @(*) begin
    case (alu_op)

      //Load & Store + JALR + AUIPC
      2'b00:   alu_ctrl = 4'b0000;
      //branch
      2'b01:   alu_ctrl = 4'b1000;  //{1'b1, fun3};
      //R-Type
      2'b10:   alu_ctrl = {fun7, fun3};
      //I-Type
      2'b11: begin
        if (fun3 == 3'b001) alu_ctrl = {fun7, fun3};
        else if (fun3 == 3'b101) alu_ctrl = {fun7, fun3};
        else alu_ctrl = {1'b0, fun3};
      end
      default: alu_ctrl = 4'bx;
    endcase
  end


endmodule

