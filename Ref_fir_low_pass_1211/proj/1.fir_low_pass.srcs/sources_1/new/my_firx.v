`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/11 09:31:36
// Design Name: 
// Module Name: my_fir
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


module my_fir(
    intput                      sys_clk     ,       // 100Mhz系统主时钟
    intput                      sys_rst_n   ,       // 异步复位，低有效
 
    intput      signed  [15:0]  data_in     ,       // 输入的数据
    intput                      data_in_en  ,       // 代表输入的数据有效

    output      signed  [15:0]  fir_out     ,       // fir滤波器的输出
    output                      fir_out_en          // fir滤波器输出数据有效
);


reg     signed  [6:0]   fir_coe_h0   ;
reg     signed  [6:0]   fir_coe_h1   ;
reg     signed  [6:0]   fir_coe_h2   ;
reg     signed  [6:0]   fir_coe_h3   ;
reg     signed  [6:0]   fir_coe_h4   ;
reg     signed  [6:0]   fir_coe_h5   ;
reg     signed  [6:0]   fir_coe_h6   ;
reg     signed  [6:0]   fir_coe_h7   ;
reg     signed  [6:0]   fir_coe_h8   ;
reg     signed  [6:0]   fir_coe_h9   ;
reg     signed  [6:0]   fir_coe_h10  ;
reg     signed  [6:0]   fir_coe_h11  ;
reg     signed  [6:0]   fir_coe_h12  ;
reg     signed  [6:0]   fir_coe_h13  ;
reg     signed  [6:0]   fir_coe_h14  ;
reg     signed  [6:0]   fir_coe_h15  ;
reg     signed  [6:0]   fir_coe_h16  ;
reg     signed  [6:0]   fir_coe_h17  ;
reg     signed  [6:0]   fir_coe_h18  ;
reg     signed  [6:0]   fir_coe_h19  ;
reg     signed  [6:0]   fir_coe_h20  ;
reg     signed  [6:0]   fir_coe_h21  ;

always @( posedge sys_clk or negedge sys_rst_n ) begin
    if ( !sys_rst_n ) begin
        fir_coe_h0  <= 7'd0;
        fir_coe_h1  <= 7'd0;
        fir_coe_h2  <= 7'd0;
        fir_coe_h3  <= 7'd0;
        fir_coe_h4  <= 7'd0;
        fir_coe_h5  <= 7'd0;
        fir_coe_h6  <= 7'd0;
        fir_coe_h7  <= 7'd0;
        fir_coe_h8  <= 7'd0; 
        fir_coe_h9  <= 7'd0;
        fir_coe_h10 <= 7'd0;
        fir_coe_h11 <= 7'd0;
        fir_coe_h12 <= 7'd0;
        fir_coe_h13 <= 7'd0;
        fir_coe_h14 <= 7'd0;
        fir_coe_h15 <= 7'd0;
        fir_coe_h16 <= 7'd0;
        fir_coe_h17 <= 7'd0;
        fir_coe_h18 <= 7'd0;
        fir_coe_h19 <= 7'd0;
        fir_coe_h20 <= 7'd0;
        fir_coe_h21 <= 7'd0;
    end
    else begin
        fir_coe_h0  <= 7'd43;
        fir_coe_h1  <= 7'd44;
        fir_coe_h2  <= 7'd45;
        fir_coe_h3  <= 7'd46;
        fir_coe_h4  <= 7'd46;
        fir_coe_h5  <= 7'd47;
        fir_coe_h6  <= 7'd48;
        fir_coe_h7  <= 7'd48;
        fir_coe_h8  <= 7'd48; 
        fir_coe_h9  <= 7'd49;
        fir_coe_h10 <= 7'd49;
        fir_coe_h11 <= 7'd49;
        fir_coe_h12 <= 7'd49;
        fir_coe_h13 <= 7'd48;
        fir_coe_h14 <= 7'd48;
        fir_coe_h15 <= 7'd48;
        fir_coe_h16 <= 7'd47;
        fir_coe_h17 <= 7'd46;
        fir_coe_h18 <= 7'd46;
        fir_coe_h19 <= 7'd45;
        fir_coe_h20 <= 7'd44;
        fir_coe_h21 <= 7'd43; 
    end
end

reg     signed  [15:0]   din_in_0   ;
reg     signed  [15:0]   din_in_1   ;
reg     signed  [15:0]   din_in_2   ;
reg     signed  [15:0]   din_in_3   ;
reg     signed  [15:0]   din_in_4   ;
reg     signed  [15:0]   din_in_5   ;
reg     signed  [15:0]   din_in_6   ;
reg     signed  [15:0]   din_in_7   ;
reg     signed  [15:0]   din_in_8   ;
reg     signed  [15:0]   din_in_9   ;
reg     signed  [15:0]   din_in_10  ;
reg     signed  [15:0]   din_in_11  ;
reg     signed  [15:0]   din_in_12  ;
reg     signed  [15:0]   din_in_13  ;
reg     signed  [15:0]   din_in_14  ;
reg     signed  [15:0]   din_in_15  ;
reg     signed  [15:0]   din_in_16  ;
reg     signed  [15:0]   din_in_17  ;
reg     signed  [15:0]   din_in_18  ;
reg     signed  [15:0]   din_in_19  ;
reg     signed  [15:0]   din_in_20  ;
reg     signed  [15:0]   din_in_21  ;

always @( posedge sys_clk or negedge sys_rst_n ) begin
    if ( !sys_rst_n ) begin
        din_in_0  <= 16'd0;
        din_in_1  <= 16'd0;
        din_in_2  <= 16'd0;
        din_in_3  <= 16'd0;
        din_in_4  <= 16'd0;
        din_in_5  <= 16'd0;
        din_in_6  <= 16'd0;
        din_in_7  <= 16'd0;
        din_in_8  <= 16'd0; 
        din_in_9  <= 16'd0;
        din_in_10 <= 16'd0;
        din_in_11 <= 16'd0;
        din_in_12 <= 16'd0;
        din_in_13 <= 16'd0;
        din_in_14 <= 16'd0;
        din_in_15 <= 16'd0;
        din_in_16 <= 16'd0;
        din_in_17 <= 16'd0;
        din_in_18 <= 16'd0;
        din_in_19 <= 16'd0;
        din_in_20 <= 16'd0;
        din_in_21 <= 16'd0;        
    end
    else begin
        din_in_0  <= din_in     ;
        din_in_1  <= din_in_0   ;
        din_in_2  <= din_in_1   ;
        din_in_3  <= din_in_2   ;
        din_in_4  <= din_in_3   ;
        din_in_5  <= din_in_4   ;
        din_in_6  <= din_in_5   ;
        din_in_7  <= din_in_6   ;
        din_in_8  <= din_in_7   ; 
        din_in_9  <= din_in_8   ;
        din_in_10 <= din_in_9   ;
        din_in_11 <= din_in_10  ;
        din_in_12 <= din_in_11  ;
        din_in_13 <= din_in_12  ;
        din_in_14 <= din_in_13  ;
        din_in_15 <= din_in_14  ;
        din_in_16 <= din_in_15  ;
        din_in_17 <= din_in_16  ;
        din_in_18 <= din_in_17  ;
        din_in_19 <= din_in_18  ;
        din_in_20 <= din_in_19  ;
        din_in_21 <= din_in_20  ;  
    end
end


reg     signed  [11]
always @( posedge sys_clk or negedge sys_rst_n ) begin
     
    


end











endmodule
