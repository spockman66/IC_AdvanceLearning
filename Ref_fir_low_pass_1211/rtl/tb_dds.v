`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/04 15:26:21
// Design Name: 
// Module Name: tb_dds
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

// ������100Mhzʱ�ӣ���λ�ź�
// ���dds 1Mhz+5Mhz ���ݣ����������Ч��ʹ���ź�
module tb_dds();

reg                     sys_clk         ;
reg                     sys_rst_n       ;

wire                    data_out_valid  ; 
wire    signed [16:0]   dds_out_data    ;

always #5 sys_clk = ~sys_clk    ;       // #��ʱ #5��ʱ5ns  ������10ns  1s = 1000ms = 1000_000us = 1000_000_000ns  f = 1/T = 1/(10^-8) = 1*10^8Hz

initial begin
    sys_rst_n  <= 1'b0;
    sys_clk    <= 1'b0;
     
    #200;     

    sys_rst_n   <= 1'b1;
    
    

end








// ����һ��dds��· ʵ��
dds dds_inst(
    .sys_clk         ( sys_clk          ),   // 100Mhz
    .sys_rst_n       ( sys_rst_n        ),   // ϵͳ��λ���͵�ƽ��Ч����������ʱ����λ��ƽʱ�Ǹߵ�ƽ
    .dds_out_data    ( dds_out_data     ),   // �ṩ1M + 5M ����
    .data_out_valid  ( data_out_valid   )            
);

endmodule
