`timescale 1ns / 1ps
/*
This is the Top level design file which handles all of the interconnections between modules.
This file should be selected for Bitstream Generation.
*/

module Top(
    input [15:0] sw,            // The 16 input switches
    input Clk_100MHz,           // The 100MHz built in clock on the Basys3
    output [15:0] led,          // The 16 indicator LEDs
    output wire [3:0] Anode_A,  // The selection wires which turn on each of the digits on the 7SD in turn for refreshing
    output wire [6:0] LED_out   // The actual wires containing the information to be displayed on each digit of the 7SD
    );
    
    wire div_Clk; // The reduced clock rate output by the clock divider
    wire [12:0] results; // The math result from the ALU to be displayed on the 7SD
    localparam div_value = 100000; // Required value to reduce the clock speed from 100MHz
    
    // The clock divider takes 100MHz and will output a reduced value (currently 500Hz) to be used as the 7SD refresh rate
    clock_divider Cdiv(
    .clock_100MHz(Clk_100MHz), 
    .div_count_value(div_value),
    .clock_divided(div_Clk)
    );
    
    // The display controller is what controls the 7 Segment Display (7SD); its refresh rate and what is displayed
    display_controller SDC(
    .Clk(div_Clk), 
    .number(results), 
    .Anode(Anode_A), 
    .LED_o(LED_out)
    );
    
    // The ALU handles the inputs from the switches and figures out which math operation to do based on those
    ALU AU(
    .switches(sw), 
    .leds(led),
    .result(results)
    );
endmodule
