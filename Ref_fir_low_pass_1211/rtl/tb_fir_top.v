`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/11 11:14:02
// Design Name: 
// Module Name: tb_fir_top
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


module tb_fir_top();

reg     sys_clk     ;
reg     sys_rst_n   ;


wire    signed  [12:0]  fir_out		;
wire					fir_out_en	;

always #5 sys_clk <= ~sys_clk;

initial begin
	sys_rst_n 	<= 1'b0;
	sys_clk 	<= 1'b0;
	
	#200;
	
	sys_rst_n 	<= 1'b1;
	
	

end


fir_low_pass_top fir_low_pass_top_inst(
    .sys_clk     ( sys_clk		),       // 系统时钟�?200Mhz
    .sys_rst_n   ( sys_rst_n	),       // 系统复位，低电平有效，正常工作时，复位脚平时是高电平
    .fir_out     ( fir_out 		),       // fir low pass 输出
    .fir_out_en  ( fir_out_en	)
);






endmodule
