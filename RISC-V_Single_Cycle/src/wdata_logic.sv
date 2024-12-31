module wdata_logic#(parameter PC_Size = 32, REGF_WIDTH = 32)(
    input [6:0] instruction,
    input [PC_Size-1:0] current_pc,
    input [REGF_WIDTH-1:0] imm,
    input [REGF_WIDTH-1:0] alu_result,
    input [REGF_WIDTH-1:0]rdata,
    input mem_to_reg,
    output logic [REGF_WIDTH-1:0] wdata
    );
    
    always @(*) begin
  if (instruction[6:0] == 7'b110_0111) begin  // jalr
       wdata = current_pc + 4;
    end else if (instruction[6:0] == 7'b001_0111) begin  // auipc
      wdata = current_pc + (imm [31:12]);
    end else if (instruction[6:0] == 7'b011_0111) begin  // lui
      wdata = imm [31:12];
      wdata = wdata << 12;
    end else if (instruction[6:0] == 7'b110_1111) begin // jal
      wdata = current_pc + 4;
    end else begin 
      wdata = mem_to_reg ? rdata : alu_result;
    end
  end
endmodule
