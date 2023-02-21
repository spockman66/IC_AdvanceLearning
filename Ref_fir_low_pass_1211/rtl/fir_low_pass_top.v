`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/03 20:35:29
// Design Name: 
// Module Name: fir_low_pass_top
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


module fir_low_pass_top (
    input                   sys_clk     ,       // 系统时钟，200Mhz
    input                   sys_rst_n   ,       // 系统复位，低电平有效，正常工作时，复位脚平时是高电平
    output  signed  [12:0]  fir_out     ,        // fir low pass 输出
    output                  fir_out_en  
);


wire	signed	[12:0]	dds_out_data	;
wire					data_out_valid 	;

dds dds_inst(
    .sys_clk         ( sys_clk 			),   // 100Mhz
    .sys_rst_n       ( sys_rst_n		),   // 系统复位，低电平有效，正常工作时，复位脚平时是高电平
    .dds_out_data    ( dds_out_data		),   // 提供1M + 5M 数据
    .data_out_valid  ( data_out_valid	)            
);



fir1 fir1_inst(
	.sys_clk		( sys_clk 			 ),		// 100Mhz 输入
	.sys_rst_n		( sys_rst_n			 ),		// 系统复位，低电平有效

	.dds_din		( dds_out_data       ),		// dds产生的1M+5M
	.dds_valid		( data_out_valid	 ),		// 高电平，代表输入的数据是有效的

	.fir_out		( fir_out		     ),		// 滤波器输出后的数据
	.fir_out_valid	( fir_out_en         )		// 高电平，代表输出的数据是有效的
);













endmodule
