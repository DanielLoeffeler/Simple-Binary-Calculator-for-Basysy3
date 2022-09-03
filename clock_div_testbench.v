`timescale 1ns / 1ps
module clock_div_testbench;

    reg clk = 0;
    wire div_clk;
    
    clock_divider UUT(.clock_100MHz(clk), .clock_divided(div_clk));
    
    always #5 clk=~clk; //5ns flip -> 10ns period -> 100MHz
endmodule
