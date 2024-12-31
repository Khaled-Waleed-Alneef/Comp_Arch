module Data_Memory #(
    parameter DATA_WIDTH   = 32,  // data width (our ISA handles with data have 32-bits)
    parameter address_bits = 10   // DEPTH --> num_addresses = 2**address_bits
) (
    input                              clk,
    input                              reset_n,
    input                              mem_read,
    input                              mem_write,
    input        [                2:0] func3,      // comes from instruciton itself
    input        [address_bits -1 : 0] addr,       // selected address (selector)
    input        [ DATA_WIDTH - 1 : 0] wdata,      // Write Data
    output logic [ DATA_WIDTH - 1 : 0] rdata       // data read from memory
);


  // word addressable and 4 bytes  for each address ...
  logic [DATA_WIDTH-1 : 0] memory [0 : (2**(address_bits-2))-1];      // actually, it's byte addressable not word adressable
  /*
    byte addressable means: each address contains a value represented with single byte (8 bits)
    word addressable means: each address contains a value represented with 4 bytes (32 bits)
    32 bits -> 4 bytes  --> memory size = DEPTH x WIDTH = 2^8 x 4 = 1024 byte = 1KB
    */

  logic [address_bits-2-1 : 0] mem_addr;
  assign mem_addr = addr[address_bits-1 : 2];

  // Writing logic
  always_ff @(posedge clk, negedge reset_n) begin
    if (!reset_n) begin
      $readmemh("/home/abdu/MCA_projects/MCA_Lab6_files/lab6_assets_files/DMem_word.mem", memory);
    end // end if
        else if (mem_write) begin
      case (func3[1:0])
        2'b00:  // sb (Store Byte)
        case (addr[1:0])
          2'b00: memory[mem_addr][7:0] <= wdata[7:0];
          2'b01: memory[mem_addr][15:8] <= wdata[7:0];
          2'b10: memory[mem_addr][23:16] <= wdata[7:0];
          2'b11: memory[mem_addr][31:24] <= wdata[7:0];
        endcase

        2'b01:  // sh (Store Halfword)
        case (addr[1])
          1'b0: memory[mem_addr][15:0] <= wdata[15:0];
          1'b1: memory[mem_addr][31:16] <= wdata[15:0];
        endcase

        2'b10:  // sw (Store Word)
        memory[mem_addr] <= wdata;

        default: ;  // Do nothing
      endcase
    end  // end else-if
  end

  // memory reading logic (load data) ...
  // NOTE: read from data-memory doesn't need to be sync with clk. Only writing needs that !
  logic [DATA_WIDTH - 1 : 0] read_data;
  //    always @(negedge reset_n, mem_read, mem_addr) begin
  always @(*) begin
    //        if (!reset_n) begin
    //            read_data = 'b0;
    //        end else 
    if (mem_read) begin
      read_data = memory[mem_addr];
    end else begin
      read_data = 'b0;
    end
  end  // end always "reading"

  // handling with lb, lbu, lh, lhu, and lw instrucitons via memory_alignment ...
  width_alignment #(
      .DATA_WIDTH(DATA_WIDTH),
      .num_bytes (DATA_WIDTH / 8)
  ) memroy_alignment (
      .data        (read_data),
      .desired_byte(addr[1:0]),  // its byte-address
      .func3       (func3),      // control singals
      .aligned_data(rdata)
  );

endmodule
