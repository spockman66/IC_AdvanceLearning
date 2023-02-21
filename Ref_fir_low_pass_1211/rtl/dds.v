`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/03 20:45:16
// Design Name: 
// Module Name: dds
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

// �ṩ1M + 5M ����
module dds(
    input                               sys_clk         ,   // 100Mhz
    input                               sys_rst_n       ,   // ϵͳ��λ���͵�ƽ��Ч����������ʱ����λ��ƽʱ�Ǹߵ�ƽ
    output      signed      [12:0]      dds_out_data    ,   // �ṩ1M + 5M ����
    output                              data_out_valid              
);

wire     signed      [11:0]    dds_1Mhz_data            ;
wire     signed      [11:0]    dds_5Mhz_data            ;
reg      signed      [12:0]    dds_sum_1M_5M_data       ;


wire                           dds_1Mhz_data_tvalid     ;    // wire ����
wire                           dds_5Mhz_data_tvalid     ;            
   
dds_1MHz dds_1MHz_cuihua(
    .aclk                   ( sys_clk               ),         // : IN STD_LOGIC;
    .m_axis_data_tvalid     ( dds_1Mhz_data_tvalid  ),         // : OUT STD_LOGIC;
    .m_axis_data_tdata      ( dds_1Mhz_data         ),         // : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    .m_axis_phase_tvalid    (                       ),         // : OUT STD_LOGIC;
    .m_axis_phase_tdata     (                       )          // : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
);
  
dds_5M dds_5M_shuancai(
    .aclk                   ( sys_clk               ),         // : IN STD_LOGIC;
    .m_axis_data_tvalid     ( dds_5Mhz_data_tvalid  ),         // : OUT STD_LOGIC;
    .m_axis_data_tdata      ( dds_5Mhz_data         ),         // : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    .m_axis_phase_tvalid    (                       ),         // : OUT STD_LOGIC;
    .m_axis_phase_tdata     (                       )          // : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
);
   

always @( posedge sys_clk or negedge sys_rst_n ) begin
    if ( !sys_rst_n ) 
        dds_sum_1M_5M_data <= 13'd10;
    else if ( dds_1Mhz_data_tvalid && dds_5Mhz_data_tvalid )        
        dds_sum_1M_5M_data <= dds_1Mhz_data + dds_5Mhz_data;    // ��1M+5M ���ݵĺ� �ӷ���
end

assign data_out_valid = dds_1Mhz_data_tvalid && dds_5Mhz_data_tvalid;
assign dds_out_data   = dds_sum_1M_5M_data  ;

    
    
endmodule
