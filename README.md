# Simple-Binary-Calculator-for-Basysy3
A simple on board binary calculator which will display its result input with the 16 switches on the 4 digit 7-segment display.

Usage is very simple. I've subdivided the 16 switches on the Basys 3 board and use those as inputs. Starting from the leftmost switch, the first four switches are used to input the math operation we want to do.
Currently only four operations are implemented: Addition, Subtraction, Division, Multiplication, and the selection is managed by a priority encoder with the priority being (+, -, /, x). When none of the four switches are toggled no results are calculated and the display is set to 0.
The remaining twelve switches are split into two six bit binary inputs, where the left number is the operand.
