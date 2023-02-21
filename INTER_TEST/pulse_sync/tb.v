`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/05 17:20:46
// Design Name: 
// Module Name: tb
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


module tb();


reg clk_src;
reg clk_dest;
reg rst_src;
reg rst_dest;
reg pulse_src;

wire pulse_dest;



initial begin
    clk_src = 0;
    clk_dest = 0;
    rst_src = 1;
    rst_dest = 1;
    pulse_src = 0;

    pulse_src = 0;

end

initial begin
    #(140) 
    rst_dest = 0;
    rst_src = 0;
    #(40)
    rst_dest = 1;
    rst_src = 1;

    #10 pulse_src =  1'b1;
    #10 pulse_src =  1'b0;
end


localparam       clk_per_1 = 10;   
always begin
    clk_src = #(clk_per_1/2) ~clk_src;
end

localparam       clk_per_2 = 15;  
always begin
    clk_dest = #(clk_per_2/2) ~clk_dest;
end


pulse_sync sync_module (
    .clksrc(clk_src),
    .rstb_clksrc(rst_src),
    .clkdest(clk_dest),
    .rstb_clkdest(rst_dest),
    .pulse_clksrc(pulse_src),
    .pulse_clkdest(pulse_dest)
    );


endmodule
