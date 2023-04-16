`timescale 1ns/1ps


module img_proc_top #(
    parameter  = 
)

(
    input clk       ,
    input rst_n     ,

    input [7:0] CFG_REG ,
    input CFG_VALID     ,
    
    input [7:0] data_i  ,
    input hsync_i       ,
    input vsync_i       ,
    input en_i          ,

    output [7:0] data_o ,
    output hsync_o      ,
    output vsync_o      ,
    output en_o
);
    




endmodule