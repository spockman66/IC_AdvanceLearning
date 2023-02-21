`timescale 1ns/1ps

`include "clk_divider_even.v"
`include "clk_divider_odd.v"
`include "clk_divider_half.v"
`include "clk_divider_float.v"

module clk_divider_tb;

reg clk;
reg rstn;

wire clk_div;

initial begin
    clk = 1'b0;
    rstn = 1'b0;

    #200
    rstn = 1'b1;
end

always #5 clk = ~clk;               // 100M, T=10ns

// clk_divider_even #(
//     .DIV_PARAM      (4)
// ) u_ultra_div
// (
//     .clk        (clk)   ,
//     .rstn       (rstn)  ,

//     .clk_div    (clk_div)
// );

clk_divider_odd #(
    .DIV_PARAM      (5)
) u_ultra_div
(
    .clk        (clk)   ,
    .rstn       (rstn)  ,

    .clk_div    (clk_div)
);

// clk_divider_half #(
//     .DIV_PARAM      (3.5)
// ) u_half_div
// (
//     .clk        (clk)   ,
//     .rstn       (rstn)  ,

//     .clk_div    (clk_div)
// );


// clk_divider_float #(
//     .DIV_PARAM      (8.6)
// ) u_float
// (
//     .clk        (clk)   ,
//     .rstn       (rstn)  ,

//     .clk_div    (clk_div)
// );

// clk_divider_half_50 u_half_div
// (
//     .clk        (clk)   ,
//     .rst        (rstn)  ,
//     .clk_div    (clk_div)
// );

endmodule