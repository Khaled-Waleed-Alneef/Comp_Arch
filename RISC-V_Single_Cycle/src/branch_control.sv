module branch_control (
    input [6:0] opcode,
    input [2:0] fun3,
    input branch,
    input zero,
    input less_signed,
    input less_unsigned,
    output logic pc_src
);
  always @(*) begin
    //JAL
    if (opcode == 7'b110_1111) pc_src = 1;
    //JALR
    else if (opcode == 7'b110_0111) pc_src = 1;
    else if (branch) begin  // some other instructions have same func3 of branch, so becareful !!
      case (fun3)
        //beq 
        3'b000:  pc_src = zero ? 1 : 0;
        //bne
        3'b001:  pc_src = zero ? 0 : 1;
        //blt
        3'b100:  pc_src = less_signed ? 1 : 0;
        //bge
        3'b101:  pc_src = less_signed ? (zero ? 1 : 0) : 1;
        //bltu
        3'b110:  pc_src = less_unsigned ? 1 : 0;
        //bgeu
        3'b111:  pc_src = less_unsigned ? (zero ? 1 : 0) : 1;
        default: pc_src = 1;
      endcase
    end else pc_src = 0;
  end

endmodule

