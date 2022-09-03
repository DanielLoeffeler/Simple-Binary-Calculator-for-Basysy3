`timescale 1ns / 1ps
/*
Divides the boards 100MHz clock signal into a smaller more usable frequency

Equation to find div_value for desired freq(DF): 1/((1/Clk)*DF*2) 
so here Clk = 100MHz if we want DF=60Hz then 1/((1/100M)*60*2)=833333.33
so count up to 833333 to get about 60Hz
*/

module clock_divider(
    input wire clock_100MHz,            // 100MHz clock built into the Basys 3
    input wire [31:0] div_count_value,  // A passable value that sets the output speed of the divider. Use above equation
    output reg clock_divided = 0        // The reduced output clock speed
    );
    
    integer counter_val = 0; // An intermediary counter variable that gets incremented and reset, used internally 
                             // to know when to pulse the reduced clock rate
    
    /*
    To do this we take a clock signal and use it to drive a counter up to a certain value. 
    Once this value is reached we flip the divided output clock signal and reset the counter.
    With this the time it takes to reach that value is half of one divided clock cycle.
    */
    always @(posedge clock_100MHz)
    begin
        if (counter_val == div_count_value) counter_val <= 0;
        else counter_val <= counter_val + 1;
    end
    
    always @(posedge clock_100MHz)
    begin
        if (counter_val == div_count_value) clock_divided <= ~clock_divided;
        else clock_divided <= clock_divided;
    end
    
endmodule
