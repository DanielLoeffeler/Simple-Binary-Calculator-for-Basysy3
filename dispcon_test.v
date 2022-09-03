`timescale 1ns / 1ps

module dispcon_test;
    
    reg Clock = 0;
    reg [12:0] result = 0;
    wire [3:0] Anode_A;
    wire [6:0] LED_out;

    display_controller UUT(
        .Clk(Clock),
        .number(result),
        .Anode(Anode_A),
        .LED_o(LED_out)
        );

    initial
    begin
        #10000000 result = 12'b101010101010;
        #10000000 result = 12'b111111111111;
        #10000000 result = 12'b000000111111;
        #10000000 result = 12'b111111000000;
    end
    
    always #1000000 Clock = ~Clock;

endmodule
