
`timescale 1ns/1ps

`include "./defines.v"

module fir_impl (

    input clk,
    input rst_n,

    // data in
    input [`WIDTH-1:0] sig_in,
    input en_in,
    
    // data out
    output [`WIDTH-1:0] sig_out,
    output en_out
);

reg [`WIDTH-1:0] sig_out_d;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n)
        sig_out_d <= 'd0;
    else
        sig_out_d <= sig_in;
end

endmodule //fir_impl