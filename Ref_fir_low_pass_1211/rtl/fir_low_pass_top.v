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
    input                   sys_clk     ,       // ϵͳʱ�ӣ�200Mhz
    input                   sys_rst_n   ,       // ϵͳ��λ���͵�ƽ��Ч����������ʱ����λ��ƽʱ�Ǹߵ�ƽ
    output  signed  [12:0]  fir_out     ,        // fir low pass ���
    output                  fir_out_en  
);


wire	signed	[12:0]	dds_out_data	;
wire					data_out_valid 	;

dds dds_inst(
    .sys_clk         ( sys_clk 			),   // 100Mhz
    .sys_rst_n       ( sys_rst_n		),   // ϵͳ��λ���͵�ƽ��Ч����������ʱ����λ��ƽʱ�Ǹߵ�ƽ
    .dds_out_data    ( dds_out_data		),   // �ṩ1M + 5M ����
    .data_out_valid  ( data_out_valid	)            
);



fir1 fir1_inst(
	.sys_clk		( sys_clk 			 ),		// 100Mhz ����
	.sys_rst_n		( sys_rst_n			 ),		// ϵͳ��λ���͵�ƽ��Ч

	.dds_din		( dds_out_data       ),		// dds������1M+5M
	.dds_valid		( data_out_valid	 ),		// �ߵ�ƽ�������������������Ч��

	.fir_out		( fir_out		     ),		// �˲�������������
	.fir_out_valid	( fir_out_en         )		// �ߵ�ƽ�������������������Ч��
);













endmodule
