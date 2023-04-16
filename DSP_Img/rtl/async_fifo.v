`timescale 1ns/1ps


module async_fifo#(
    parameter DSIZE = 8,
    parameter ASIZE = 4
)(
    input               wr_clk          ,
    input               wr_rst_n        ,
    input               wr_en           ,
    input [DSIZE-1:0]   wr_data         ,
    
    input               rd_clk          ,
    input               rd_rst_n        ,
    input               rd_en           ,
    output [DSIZE-1:0]  rd_data         ,

    output              full            ,
    output              empty
);

wire [ASIZE-1:0] wr_addr, rd_addr;
wire [ASIZE:0] wr_ptr, rd_ptr;


fifo_mem #(DSIZE, ASIZE) u_fifo_mem
(
    .
)




endmodule



module fifo_mem #(
    parameter DSIZE = 8,
    parameter ASIZE = 4
)(
    
);


endmodule



module sync_r2w #(
    parameter ADDR_SIZE = 4
)(
    input wr_clk, wr_rst_n,
    output reg [ADDR_SIZE:0] wr_rptr,
)