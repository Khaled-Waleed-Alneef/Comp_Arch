`timescale 1ns / 1ps
module Top_tb;
logic rst_n, clk;

Top DUT (.*);

initial
clk = 0;

always
#2 clk = !clk;

initial
    begin
    rst_n = 1;
    #1 rst_n = 0;
    #1 rst_n = 1;
    #30
    $finish;
    end
    
endmodule
