`timescale  1ns / 1ps

`include "../rtl/defines.v"

module tb;

// fir_impl Parameters
parameter PERIOD  = 10;

// fir_impl Inputs
reg   clk                                  = 0 ;
reg   rst_n                                = 0 ;
reg   [`WIDTH-1:0]  sig_in                 = 0 ;

// fir_impl Outputs
wire  [`WIDTH-1:0]  sig_out                ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

fir_impl  u_fir_impl (
    .clk                     ( clk                   ),
    .rst_n                   ( rst_n                 ),
    .sig_in                  ( sig_in   [`WIDTH-1:0] ),

    .sig_out                 ( sig_out  [`WIDTH-1:0] )
);

initial
begin

    $finish;
end

endmodule