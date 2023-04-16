`timescale 1ns/1ps


module serial_sort#(
    parameter WIDTH = 8,
    parameter NUMBER = 16
)(
    input  logic clk         ,
    input  logic rst_n       ,

    input  logic                valid_a     ,
    output logic                ready_a     ,
    input  logic [WIDTH-1:0]    data_i ,

    output  logic               valid_b     ,
    input   logic               ready_b     ,
    output  logic [WIDTH-1:0]   data_o      
);

    wire [WIDTH-1:0] din[NUMBER-1:0];
    wire [WIDTH-1:0] din[NUMBER-1:0];
    
    genvar i;
    generate for(i=0; i<NUMBER;i++)begin: sort_cell
        sort_cell u_sort(
            .clk    (clk)       ,
            .rst_n  (rst_n)     ,
            .din    (dout[i-1])       ,
            .dout   (dout[i])      ,
            .dmax   ()       ,
            .dmin   ()
        );
    begin
    endgenerate







endmodule


module sort_cell#(
    parameter WIDTH = 8
)(
    input  logic clk         ,
    input  logic rst_n       ,

    input   logic [WIDTH-1:0]  din      ,
    input   logic
);





endmodule