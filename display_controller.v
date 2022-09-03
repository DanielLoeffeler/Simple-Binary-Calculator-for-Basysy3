`timescale 1ns / 1ps
/*
Takes a clock signal to set the refresh rate, and a 4 digit decimal number to display
*/

module display_controller(
    input Clk,                  // Refresh Rate Clock signal
    input wire [12:0] number,   // Number to be displayed 
    output reg [3:0] Anode,     // The selection wires which turn on each of the digits on the 7SD in turn for refreshing
    output reg [6:0] LED_o      // The actual wires containing the information to be displayed on each digit of the 7SD
    );
    
    reg [1:0] LED_sel = 2'b00;  // LED Digit selection variable
    reg [3:0] LED_BCD = 0;      // bit coded digit. Holds the bit code for the number to be displayed at a specific digit
    
//    integer numbdisp;
    
    // On each clock pulse the selected display digit is changed from leftmost to rightmose
    // When the digit is changed we need to change the value that will be displayed 
    always @(posedge Clk)
    begin
        LED_sel <= LED_sel + 2'b01;
        
//        numbdisp = number;
        
        case (LED_sel)
        2'b00:begin
            Anode <= 4'b0111; // Selects leftmost digit on 7SD
            LED_BCD <= number/1000; // Isolates leftmost number in 4 digit number passed to the controller
            end
        2'b01:begin
            Anode <= 4'b1011; // Selects digit second from the left on 7SD
            LED_BCD <= (number % 1000)/100; // Isolates number second from the left in 4 digit number passed to the controller
            end
        2'b10:begin
            Anode <= 4'b1101; // Selects digit second from the right on 7SD
            LED_BCD <= ((number % 1000)%100)/10; // Isolates number second from the right in 4 digit number passed to the controller
            end
        2'b11:begin
            Anode <= 4'b1110; // Selects rightmost digit on 7SD
            LED_BCD <= ((number % 1000)%100)%10; // Isolates rightmost number in 4 digit number passed to the controller
            end
        default:begin
            Anode <= 4'b0111; // If there is a hardware error set the leftmost digit to 0 
            LED_BCD <= 4'b0000;
            end
        endcase
    end
    
    // Cathode patterns of the 7-segment LED display 
    always @(*)
    begin
        case(LED_BCD)
        4'b0000: LED_o = 7'b0000001; // "0"     
        4'b0001: LED_o = 7'b1001111; // "1" 
        4'b0010: LED_o = 7'b0010010; // "2" 
        4'b0011: LED_o = 7'b0000110; // "3" 
        4'b0100: LED_o = 7'b1001100; // "4" 
        4'b0101: LED_o = 7'b0100100; // "5" 
        4'b0110: LED_o = 7'b0100000; // "6" 
        4'b0111: LED_o = 7'b0001111; // "7" 
        4'b1000: LED_o = 7'b0000000; // "8"     
        4'b1001: LED_o = 7'b0000100; // "9" 
        default: LED_o = 7'b0000001; // "0"
        endcase
    end
endmodule
