module top_RV32 #(
    parameter PC_Size = 32,
    parameter IMEM_DEPTH = 32,
    parameter IMEM_WIDTH = 32,
    parameter DATA_WIDTH = 32,  //REGF_WIDTH
    parameter REGF_DEPTH = 32
) (
    input clk,
    input reset_n
);

  // pc module
  logic [PC_Size-1:0] next_pc;
  logic [PC_Size-1:0] current_pc;

  PC #(
      .PC_Size(PC_Size)
  ) pc (
      .clk(clk),
      .rst_n(reset_n),
      .next_pc(next_pc),
      .current_pc(current_pc)
  );

  // generate control signals
  logic branch, mem_write_en, mem_to_reg, ALU_src, reg_write, mem_read_en;
  logic [1:0] ALU_op;

  // fetch instruction stage (ROM module) ...
  logic [IMEM_WIDTH-1 : 0] instruction;

  instruction_memory #(
      .IMEM_DEPTH(IMEM_DEPTH),
      .IMEM_WIDTH(IMEM_WIDTH),
      .PC_Size(PC_Size)
  ) inst_mem (
      .address(current_pc),
      .instruction(instruction)
  );

  // decoding stage ...
  //Main Control Module
  control controller (
      .opcode(instruction[6:0]),
      .branch(branch),  // is the instruction branch?
      .mem_read_en(mem_read_en),
      .mem_write_en(mem_write_en),  // memory write enable
      .mem_to_reg(mem_to_reg),  // memory or ALU_out
      .ALU_src(ALU_src),  // ALU 2nd op is imm or reg?
      .ALU_op(ALU_op),  // to control ALU_control
      .reg_write(reg_write)  // enables writing to register 
  );
  // ALU_control module 
  logic [3:0] alu_ctrl;
  ALU_control alu_controller (
      .fun7(instruction[30]),
      .fun3(instruction[14 : 12]),
      .alu_op(ALU_op),
      .alu_ctrl(alu_ctrl)
  );

  // decoding values (imm & regs)
  logic [DATA_WIDTH - 1 : 0] rdata;
  logic [DATA_WIDTH - 1 : 0] wdata;
  logic [DATA_WIDTH - 1 : 0] rdata1;
  logic [DATA_WIDTH - 1 : 0] rdata2;

  register_file #(
      .REGF_WIDTH(DATA_WIDTH),
      .REGF_DEPTH(REGF_DEPTH)
  ) reg_file (
      .clk(clk),
      .rst_n(reset_n),
      .reg_write(reg_write),  // from controller
      .raddr1(instruction[19 : 15]),
      .raddr2(instruction[24 : 20]),
      .waddr(instruction[11 : 7]),
      .wdata(wdata),  // assigned in the end of this module
      .rdata1(rdata1),
      .rdata2(rdata2)
  );

  // immediate bits generator
  logic [DATA_WIDTH-1:0] imm;
  imm_gen #(
      .REGF_WIDTH(DATA_WIDTH)
  ) immGen (
      .inst(instruction),
      .imm (imm)
  );




  logic [DATA_WIDTH - 1 : 0] alu_result;
  logic [DATA_WIDTH - 1 : 0] op2;
  assign op2 = ALU_src ? imm : rdata2;
  logic zero;
  logic less_signed, less_unsigned;

  //Execute
  //ALU module
  ALU #(
      .REGF_WIDTH(DATA_WIDTH)
  ) alu (
      .op1(rdata1),
      .op2(op2),
      .alu_ctrl(alu_ctrl),
      .alu_result(alu_result),
      .zero(zero),
      .less_signed(less_signed),
      .less_unsigned(less_unsigned)
  );

  //MEM Stage
  Data_Memory #(
      .DATA_WIDTH(DATA_WIDTH),

      .address_bits(10)
  ) DMEM (
      .clk      (clk),
      .reset_n  (reset_n),
      .mem_read (mem_read_en),
      .mem_write(mem_write_en),
      .func3    (instruction[14 : 12]),  // comes from instruction itself
      .addr     (alu_result),            // selected address (selector)
      .wdata    (rdata2),                // Write Data
      .rdata    (rdata)                  // data read from memory
  );

  //Branch Control + (JAL and JALR)
  logic pc_src;
  branch_control br_ctrl (
      .opcode(instruction[6:0]),
      .fun3(instruction[14 : 12]),
      .branch(branch),
      .zero(zero),
      .less_signed(less_signed),
      .less_unsigned(less_unsigned),
      .pc_src(pc_src)
  );

  logic pc_sel;

  // pc logic module
  assign pc_sel = branch & pc_src;  // actually, no need for branch signal, it's already used inside to generate pc_src
  PC_logic #(
      .PC_Size (PC_Size),
      .imm_Size(IMEM_WIDTH)  // must be same size
  ) pc_logic (
      .current_pc(current_pc),
      .offset(imm),
      .alu_result(alu_result),
      .opcode(instruction[6:0]),
      .pc_sel(pc_sel),
      .next_pc(next_pc)
  );

  //Write Back Stage
  // Writing Data Logic Module
  wdata_logic #(PC_Size, DATA_WIDTH) wd_l (
      .instruction(instruction[6:0]),
      .current_pc(current_pc),
      .imm(imm),
      .alu_result(alu_result),
      .rdata(rdata),
      .mem_to_reg(mem_to_reg),
      .wdata(wdata)
  );




endmodule
