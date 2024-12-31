`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.12.2024 18:29:09
// Design Name: 
// Module Name: width_alignment
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module width_alignment #(
    parameter DATA_WIDTH = 32,
    parameter num_bytes = 4
    ) (
    input [DATA_WIDTH -1 : 0] data,
    input [$clog2(num_bytes) - 1 : 0] desired_byte,     // its byte-address
    input [2:0] func3,                                                           // control singals
    output logic [DATA_WIDTH -1 : 0] aligned_data
    );

    // lb instruction logic (load byte)
    logic [7 : 0] lb_value;
    logic [DATA_WIDTH -1 : 0] extended_lb_value;
    always @ (*) begin
        case (desired_byte[1:0])
            2'b00: lb_value = data[7 : 0];
            2'b01: lb_value = data[15 : 8];
            2'b10: lb_value = data[23 : 16];
            2'b11: lb_value = data[31 : 24];
        endcase
        
        // zero/sign extension
        case(func3[2])
            1'b0: extended_lb_value = { {24{lb_value[7]}} , lb_value };   // sign extension
            1'b1: extended_lb_value = { {24{1'b0}} , lb_value };               // zero extension (unsigned value)
        endcase
    end 
    
    
    // lh instruction logic (load half-word)
    logic [15 : 0] lh_value;
    logic [DATA_WIDTH -1 : 0] extended_lh_value;
    always @ (*) begin
        case (desired_byte[1])      // desired double-bytes (half-word)
            2'b0: lh_value = data[15 : 0];
            2'b1: lh_value = data[31 : 16];
        endcase
        
        // zero/sign extension
        case(func3[2])
            1'b0: extended_lh_value = { {16{lh_value[15]}} , lh_value };   // sign extension
            1'b1: extended_lh_value = { {16{1'b0}} , lh_value };               // zero extension (unsigned value)
        endcase
    end

    
    // lw instruction logic (load word)
    always @ (*) begin
        case (func3[1:0])
            2'b00: aligned_data = extended_lb_value;
            2'b01: aligned_data = extended_lh_value;
            2'b10: aligned_data = data;
            2'b11: aligned_data = 'b0;
        endcase
    end
    
endmodule