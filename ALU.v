`timescale 1ns / 1ps
/*
Takes the switch input, sets the leds for which switches are on.
Uses a priority encoder to control the mathematical operation being done on the input numbers.
*/

module ALU(
    input [15:0] switches,
    output [15:0] leds,
    output reg [12:0] result
    );
    
    wire [5:0] X, Y;
    wire [3:0] Opsw;
    
    reg [2:0] Op;
    
    assign Y = switches[5:0];
    assign X = switches[11:6];
    assign Opsw = switches[15:12];
    assign leds = switches;
    
    
    always @(*)
    begin
        // Priority encoder to decide which operation to do left to right +,-,/,*
        if (Opsw[3]==1) Op=3'b000;      // if leftmost switch is on then ADD code 00
        else if (Opsw[2]==1) Op=3'b001; // if second from the left switch is on then SUBTRACT code 01
        else if (Opsw[1]==1) Op=3'b010; // if second from the right switch is on then DIVIDE code 01
        else if (Opsw[0]==1) Op=3'b011; // if rightmost switch is on then MULTIPLY code 11
        else Op=3'b100;                 // if no switches are on set encoder to 0
        
        case (Op)
            2'b000: result <= X+Y;
            2'b001: result <= X-Y;
            2'b010: result <= X/Y;
            2'b011: result <= X*Y;
            2'b100: result <= 0;
            default: result <= 0;
        endcase
    end
    
    
endmodule
