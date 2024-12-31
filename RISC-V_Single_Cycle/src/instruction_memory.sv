module instruction_memory #(
    parameter IMEM_DEPTH = 32,
    IMEM_WIDTH = 32,
    PC_Size = 32
) (
    input [PC_Size-1:0] address,
    output logic [31:0] instruction
);

  logic [IMEM_WIDTH -1:0] imem[IMEM_DEPTH - 1:0];

  initial $readmemh("/home/it/Vivado_Projects/tst.mem", imem);  // test-code for lab_7

  assign instruction = imem[address/4];

endmodule
