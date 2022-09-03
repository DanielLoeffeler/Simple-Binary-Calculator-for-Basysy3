`timescale 1ns / 1ps
module top_TEST;

reg clk=0;
reg [15:0] switch = 0;
wire [15:0] leds;

Top UUT(.sw(switch), .Clk_100MHz(clk), .led(leds));

initial
begin
    #10 switch = 16'b0000000000000001;
    #10 switch = 16'b1000000000000001;
    #10 switch = 16'b1111000011000011;
    #10 switch = 16'b0111000100000011;
    #10 switch = 16'b0011000100000010;
    #10 switch = 16'b0001000100000010;
end

always #5 clk=~clk;

endmodule

