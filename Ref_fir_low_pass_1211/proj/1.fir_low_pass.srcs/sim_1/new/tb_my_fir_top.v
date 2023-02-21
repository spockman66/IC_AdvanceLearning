`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/11 21:26:54
// Design Name: 
// Module Name: tb_my_fir_top
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


module tb_my_fir_top();


reg			sys_clk		;
reg			sys_rst_n	;			


wire	signed	[12:0]	fir_out		;
wire					fir_out_en	;

always #5 sys_clk = ~sys_clk;

initial begin	// fpga ��ʼ�ϵ�
	sys_rst_n 	<= 1'b0;
	sys_clk 	<= 1'b0;
	
	#200;
	sys_rst_n 	<= 1'b1;

end



fir_low_pass_top fir_low_pass_top_inst(
    .sys_clk     ( sys_clk 		),       // ϵͳʱ�ӣ�200Mhz
    .sys_rst_n   ( sys_rst_n 	),       // ϵͳ��λ���͵�ƽ��Ч����������ʱ����λ��ƽʱ�Ǹߵ�ƽ
    .fir_out     ( fir_out		),        // fir low pass ���
    .fir_out_en  ( fir_out_en	)
);












endmodule
