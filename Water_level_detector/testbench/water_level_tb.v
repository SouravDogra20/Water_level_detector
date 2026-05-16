`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.05.2026 22:54:09
// Design Name: 
// Module Name: water_level_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module water_level_tb(
    input rst, clk,
    input [1:0] sensor,
    output reg G, B, R,
    output reg [1:0] NS, PS
);

parameter empty = 2'b00,
          green = 2'b01;

parameter blue = 2'b10,
          filled = 2'b11;
always @(posedge clk) begin
    if (rst)
        PS <= empty;
    else
        PS <= NS;
end
always @(PS) begin
    {G, B, R} = 3'b000;
    case (PS)
        empty:  {G, B, R} = 3'b000;
        green:  G = 1'b1;
        blue:   B = 1'b1;
        filled: R = 1'b1;
        default:{G, B, R} = 3'b000;
    endcase
end
always @(*) begin
    case (PS)
        empty:
            if (sensor == 2'b01) NS = green;
            else NS = empty;
        green: begin
            if (sensor == 2'b00) NS = empty;
            else if (sensor == 2'b10) NS = blue;
            else NS = green;
        end
        blue: begin
            if (sensor == 2'b01) NS = green;
            else if (sensor == 2'b11) NS = filled;
            else NS = blue;
        end

        filled:
            if (sensor == 2'b10) NS = blue;
            else NS = filled;

        default: NS = empty;
    endcase
end

endmodule
