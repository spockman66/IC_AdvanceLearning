`timescale 1ns/1ps

`define WIDTH  8

module imple_trade (

    input [15:0] ADDRESS,
    input [7:0] PTR1,
    input [7:0] PTR2,
    input control,
    output [15:0] COUNT

);

parameter [7:0] BASE = 8'b1000_0000;
wire [15:0] ADDR;
wire [7:0] PTR, OFFSET;

assign PTR = control ? PTR1 : PTR2;
assign OFFSET = BASE-PTR;
assign ADDR = ADDRESS-(8'h00-OFFSET);
assign COUNT = ADDR + 'd8;

endmodule