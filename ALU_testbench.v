`timescale 1ns / 1ps
module ALU_testbench;
    reg clk=0;
    
    wire [32:0] result;
    
    wire [15:0] ledout;
    reg [15:0] swin;
    
    ALU UUT(
    .switches(swin), .leds(ledout), .result(result)
    );
    
    initial
    begin
    #10 swin = 16'b0000000010000010;
//    #10 swin = 16'b1000000000000001;
//    #10 swin = 16'b1111000011000011;
//    #10 swin = 16'b0111000100000011;
//    #10 swin = 16'b0011000100000010;
//    #10 swin = 16'b0001000100000010;
    end
    
    always #5 clk = ~clk;

endmodule
