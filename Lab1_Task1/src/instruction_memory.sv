module instruction_memory #(
    parameter IMEM_DEPTH = 64,
    PROG_VALUE = 3
) (
    input [$clog2(PROG_VALUE)-1:0] addr,
    output logic [8:0] instruction
);

localparam IMEM_WIDTH = 8;
  logic [IMEM_WIDTH-1:0] imem[IMEM_DEPTH - 1:0];
  initial $readmemb("/home/it/Vivado_Projects/Arch/Lab1_Task1/src/fib_im.mem", imem);
 
 

assign instruction = imem[addr];

endmodule
