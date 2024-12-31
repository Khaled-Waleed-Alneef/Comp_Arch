module control (
    input [6:0] opcode,
    output logic branch,  // is the instruction branch ro jump?
    output logic mem_read_en,  // memory read enable
    output logic mem_write_en,  // memory write enable
    output logic mem_to_reg,  // memory or ALU_out
    output logic ALU_src,  // ALU 2nd op is imm or reg?
    output logic [1:0] ALU_op,  // to control ALU_control
    output logic reg_write  // enables writing to register 
);
  always @(opcode) begin
    case (opcode)
      // R-Type 
      7'b0110011: begin
        reg_write = 1;
        mem_write_en = 0;
        mem_to_reg = 0;
        ALU_op = 10;
        ALU_src = 0;
        branch = 0;
        mem_read_en = 0;
      end
      // I-Type
      7'b0010011: begin
        reg_write = 1;
        mem_write_en = 0;
        mem_to_reg = 0;     // wdata could differ depends on 
        ALU_op = 11;
        ALU_src = 1;
        branch = 0;
        mem_read_en = 0;  // zero?? yes, I think so
      end
      //Load
      7'b0000011: begin
        reg_write = 1;
        mem_write_en = 0;
        mem_to_reg = 1;
        ALU_op = 00;
        ALU_src = 1;
        branch = 0;
        mem_read_en = 1;
      end
      //Store
      7'b0100011: begin
        reg_write = 0;
        mem_write_en = 1;
        mem_to_reg = 0;
        ALU_op = 00;
        ALU_src = 1;
        branch = 0;
        mem_read_en = 0;
      end
      //Branch    
      7'b1100011: begin
        reg_write = 0;
        mem_write_en = 0;
        mem_to_reg = 0;
        ALU_op = 01;
        ALU_src = 0;
        branch = 1;
        mem_read_en = 0;
      end
      //JAL
      7'b1101111: begin
        reg_write = 1;
        mem_write_en = 0;
        mem_to_reg = 0;
        ALU_op = 00;
        ALU_src = 0;
        branch = 1;
        mem_read_en = 0;
      end

      //JALR
      7'b1100111: begin
        reg_write = 1;
        mem_write_en = 0;
        mem_to_reg = 0;
        ALU_op = 00;
        ALU_src = 1;
        branch = 1;
        mem_read_en = 0;
      end

      //AUIPC
      7'b0010111: begin
        reg_write = 1;
        mem_write_en = 0;
        mem_to_reg = 0;
        ALU_op = 00;
        ALU_src = 0;
        branch = 0;
        mem_read_en = 0;
      end
      //LUI
      7'b0110111: begin
        reg_write = 1;
        mem_write_en = 0;
        mem_to_reg = 0;
        ALU_op = 00;
        ALU_src = 1;
        branch = 0;
        mem_read_en = 0;
      end


      default: begin
        reg_write = 0;
        mem_write_en = 0;
        mem_to_reg = 0;
        ALU_op = 00;
        ALU_src = 0;
        branch = 0;
        mem_read_en = 0;
      end

    endcase

  end
endmodule
