`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/11 10:29:20
// Design Name: 
// Module Name: fir1
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


module fir1(
	input					sys_clk		,		// 100Mhz 输入
	input					sys_rst_n	,		// 系统复位，低电平有效
	
	input	signed	[12:0]	data_in		,		// dds产生的1M+5M
	input					data_in_en	,		// 高电平，代表输入的数据是有效的
	
	output	signed 	[12:0]	fir_out		,		// 滤波器输出后的数据
	output					fir_out_en			// 高电平，代表输出的数据是有效的
);

// 1.创建滤波器系数的reg
reg		signed	[9:0]	fir_coe_h0	;
reg		signed	[9:0]	fir_coe_h1	;
reg		signed	[9:0]	fir_coe_h2	;
reg		signed	[9:0]	fir_coe_h3	;
reg		signed	[9:0]	fir_coe_h4	;
reg		signed	[9:0]	fir_coe_h5	;
reg		signed	[9:0]	fir_coe_h6	;
reg		signed	[9:0]	fir_coe_h7	;
reg		signed	[9:0]	fir_coe_h8	;
reg		signed	[9:0]	fir_coe_h9	;
reg		signed	[9:0]	fir_coe_h10	;
reg		signed	[9:0]	fir_coe_h11	;
reg		signed	[9:0]	fir_coe_h12	;
reg		signed	[9:0]	fir_coe_h13	;
reg		signed	[9:0]	fir_coe_h14	;
reg		signed	[9:0]	fir_coe_h15	;
reg		signed	[9:0]	fir_coe_h16	;
reg		signed	[9:0]	fir_coe_h17	;
reg		signed	[9:0]	fir_coe_h18	;
reg		signed	[9:0]	fir_coe_h19	;
reg		signed	[9:0]	fir_coe_h20	;
reg		signed	[9:0]	fir_coe_h21	;
reg		signed	[9:0]	fir_coe_h22	;
reg		signed	[9:0]	fir_coe_h23	;
reg		signed	[9:0]	fir_coe_h24	;
reg		signed	[9:0]	fir_coe_h25	;
reg		signed	[9:0]	fir_coe_h26	;
reg		signed	[9:0]	fir_coe_h27	;
reg		signed	[9:0]	fir_coe_h28	;
reg		signed	[9:0]	fir_coe_h29	;
reg		signed	[9:0]	fir_coe_h30	;
reg		signed	[9:0]	fir_coe_h31	;
reg		signed	[9:0]	fir_coe_h32	;
reg		signed	[9:0]	fir_coe_h33	;
reg		signed	[9:0]	fir_coe_h34	;
reg		signed	[9:0]	fir_coe_h35	;
reg		signed	[9:0]	fir_coe_h36	;
reg		signed	[9:0]	fir_coe_h37	;
reg		signed	[9:0]	fir_coe_h38	;
reg		signed	[9:0]	fir_coe_h39	;
reg		signed	[9:0]	fir_coe_h40	;
reg		signed	[9:0]	fir_coe_h41	;

always @( posedge sys_clk or negedge sys_rst_n ) begin
	if ( !sys_rst_n ) begin
		fir_coe_h0	<= 10'd0;	
		fir_coe_h1	<= 10'd0;
		fir_coe_h2	<= 10'd0;
		fir_coe_h3	<= 10'd0;
		fir_coe_h4	<= 10'd0;
		fir_coe_h5	<= 10'd0;
		fir_coe_h6	<= 10'd0;
		fir_coe_h7	<= 10'd0;
		fir_coe_h8	<= 10'd0;
		fir_coe_h9	<= 10'd0;
		fir_coe_h10	<= 10'd0;
		fir_coe_h11	<= 10'd0;
		fir_coe_h12	<= 10'd0;
		fir_coe_h13	<= 10'd0;
		fir_coe_h14	<= 10'd0;
		fir_coe_h15	<= 10'd0;
		fir_coe_h16	<= 10'd0;
		fir_coe_h17	<= 10'd0;
		fir_coe_h18	<= 10'd0;
		fir_coe_h19	<= 10'd0;
		fir_coe_h20	<= 10'd0;
		fir_coe_h21	<= 10'd0;
		fir_coe_h22 <= 10'd0;
		fir_coe_h23 <= 10'd0;
		fir_coe_h24 <= 10'd0;
		fir_coe_h25 <= 10'd0;
		fir_coe_h26 <= 10'd0;
		fir_coe_h27 <= 10'd0;
		fir_coe_h28 <= 10'd0;
		fir_coe_h29 <= 10'd0;
		fir_coe_h30 <= 10'd0;
		fir_coe_h31 <= 10'd0;
		fir_coe_h32 <= 10'd0;
		fir_coe_h33 <= 10'd0;
		fir_coe_h34 <= 10'd0;
		fir_coe_h35 <= 10'd0;
		fir_coe_h36 <= 10'd0;
		fir_coe_h37 <= 10'd0;
		fir_coe_h38 <= 10'd0;
		fir_coe_h39 <= 10'd0;
		fir_coe_h40 <= 10'd0;
		fir_coe_h41 <= 10'd0;
	end
	else begin
		// fir_coe_h0	<=   -10'd1 	;			// 10'd43;	
		// fir_coe_h1	<=   -10'd1 	;			// 10'd44;
		// fir_coe_h2	<=   -10'd1 	;			// 10'd45;
		// fir_coe_h3	<=    10'd0  	;			// 10'd46;
		// fir_coe_h4	<=    10'd2  	;			// 10'd46;
		// fir_coe_h5	<=    10'd5  	;			// 10'd47;
		// fir_coe_h6	<=    10'd10 	;			// 10'd48;
		// fir_coe_h7	<=    10'd16 	;			// 10'd48;
		// fir_coe_h8	<=    10'd25 	;			// 10'd48;
		// fir_coe_h9	<=    10'd35 	;			// 10'd49;
		// fir_coe_h10	<=    10'd46 	;			// 10'd49;
		// fir_coe_h11	<=    10'd58 	;			// 10'd49;
		// fir_coe_h12	<=    10'd69 	;			// 10'd49;
		// fir_coe_h13	<=    10'd78 	;			// 10'd48;
		// fir_coe_h14	<=    10'd84 	;			// 10'd48;
		// fir_coe_h15	<=    10'd88 	;			// 10'd48;
		// fir_coe_h16	<=    10'd88 	;			// 10'd47;
		// fir_coe_h17	<=    10'd84 	;			// 10'd46;
		// fir_coe_h18	<=    10'd78 	;			// 10'd46;
		// fir_coe_h19	<=    10'd69 	;			// 10'd45;
		// fir_coe_h20	<=    10'd58 	;			// 10'd44;
		// fir_coe_h21	<=    10'd46 	;			// 10'd43;
		// fir_coe_h22 <=    10'd35 	;
		// fir_coe_h23 <=    10'd25 	;
		// fir_coe_h24 <=    10'd16 	;
		// fir_coe_h25 <=    10'd10 	;
		// fir_coe_h26 <=    10'd5  	;
		// fir_coe_h27 <=    10'd2  	;
		// fir_coe_h28 <=    10'd0  	;
		// fir_coe_h29 <=   -10'd1 	;
		// fir_coe_h30 <=   -10'd1 	;
		// fir_coe_h31 <=   -10'd1 	;
		
		fir_coe_h0	<=   -10'd26  ;
		fir_coe_h1	<=   -10'd7   ;
		fir_coe_h2	<=   -10'd7   ;
		fir_coe_h3	<=   -10'd7   ;
		fir_coe_h4	<=   -10'd5   ;
		fir_coe_h5	<=   -10'd3   ;
		fir_coe_h6	<=   10'd0    ;
		fir_coe_h7	<=   10'd4    ;
		fir_coe_h8	<=   10'd8    ;
		fir_coe_h9	<=   10'd14   ;
		fir_coe_h10	<=   10'd20   ;
		fir_coe_h11	<=   10'd27   ;
		fir_coe_h12	<=   10'd34   ;
		fir_coe_h13	<=   10'd41   ;
		fir_coe_h14	<=   10'd48   ;
		fir_coe_h15	<=   10'd54   ;
		fir_coe_h16	<=   10'd60   ;
		fir_coe_h17	<=   10'd65   ;
		fir_coe_h18	<=   10'd69   ;
		fir_coe_h19	<=   10'd72   ;
		fir_coe_h20	<=   10'd73   ;
		fir_coe_h21	<=   10'd73   ;
		fir_coe_h22 <=   10'd72   ;
		fir_coe_h23 <=   10'd69   ;
		fir_coe_h24 <=   10'd65   ;
		fir_coe_h25 <=   10'd60   ;
		fir_coe_h26 <=   10'd54   ;
		fir_coe_h27 <=   10'd48   ;
		fir_coe_h28 <=   10'd41   ;
		fir_coe_h29 <=   10'd34   ;
		fir_coe_h30 <=   10'd27   ;
		fir_coe_h31 <=   10'd20   ;
		fir_coe_h32 <=   10'd14   ;
		fir_coe_h33 <=   10'd8    ;
		fir_coe_h34 <=   10'd4    ;
		fir_coe_h35 <=   10'd0    ;
		fir_coe_h36 <=   -10'd3   ;
		fir_coe_h37 <=   -10'd5   ;
		fir_coe_h38 <=   -10'd7   ;
		fir_coe_h39 <=   -10'd7   ;
		fir_coe_h40 <=   -10'd7   ;
		fir_coe_h41 <=   -10'd26  ;

	end
end

reg		signed	[12:0]	din_in_0	;
reg		signed	[12:0]	din_in_1	;
reg		signed	[12:0]	din_in_2	;
reg		signed	[12:0]	din_in_3	;
reg		signed	[12:0]	din_in_4	;
reg		signed	[12:0]	din_in_5	;
reg		signed	[12:0]	din_in_6	;
reg		signed	[12:0]	din_in_7	;
reg		signed	[12:0]	din_in_8	;
reg		signed	[12:0]	din_in_9	;
reg		signed	[12:0]	din_in_10	;
reg		signed	[12:0]	din_in_11	;
reg		signed	[12:0]	din_in_12	;
reg		signed	[12:0]	din_in_13	;
reg		signed	[12:0]	din_in_14	;
reg		signed	[12:0]	din_in_15	;
reg		signed	[12:0]	din_in_16	;
reg		signed	[12:0]	din_in_17	;
reg		signed	[12:0]	din_in_18	;
reg		signed	[12:0]	din_in_19	;
reg		signed	[12:0]	din_in_20	;
reg		signed	[12:0]	din_in_21	;
reg		signed	[12:0]	din_in_22	;
reg		signed	[12:0]	din_in_23	;
reg		signed	[12:0]	din_in_24	;
reg		signed	[12:0]	din_in_25	;
reg		signed	[12:0]	din_in_26	;
reg		signed	[12:0]	din_in_27	;
reg		signed	[12:0]	din_in_28	;
reg		signed	[12:0]	din_in_29	;
reg		signed	[12:0]	din_in_30	;
reg		signed	[12:0]	din_in_31	;
reg		signed	[12:0]	din_in_32	;
reg		signed	[12:0]	din_in_33	;
reg		signed	[12:0]	din_in_34	;
reg		signed	[12:0]	din_in_35	;
reg		signed	[12:0]	din_in_36	;
reg		signed	[12:0]	din_in_37	;
reg		signed	[12:0]	din_in_38	;
reg		signed	[12:0]	din_in_39	;
reg		signed	[12:0]	din_in_40	;
reg		signed	[12:0]	din_in_41	;
always @( posedge sys_clk or negedge sys_rst_n ) begin
	if ( !sys_rst_n ) begin
		din_in_0	<= 13'd0;	
		din_in_1	<= 13'd0;
		din_in_2	<= 13'd0;
		din_in_3	<= 13'd0;
		din_in_4	<= 13'd0;
		din_in_5	<= 13'd0;
		din_in_6	<= 13'd0;
		din_in_7	<= 13'd0;
		din_in_8	<= 13'd0;
		din_in_9	<= 13'd0;
		din_in_10	<= 13'd0;
		din_in_11	<= 13'd0;
		din_in_12	<= 13'd0;
		din_in_13	<= 13'd0;
		din_in_14	<= 13'd0;
		din_in_15	<= 13'd0;
		din_in_16	<= 13'd0;
		din_in_17	<= 13'd0;
		din_in_18	<= 13'd0;
		din_in_19	<= 13'd0;
		din_in_20	<= 13'd0;
		din_in_21	<= 13'd0;
		din_in_22   <= 13'd0;
		din_in_23   <= 13'd0;
		din_in_24   <= 13'd0;
		din_in_25   <= 13'd0;
		din_in_26   <= 13'd0;
		din_in_27   <= 13'd0;
		din_in_28   <= 13'd0;
		din_in_29   <= 13'd0;
		din_in_30   <= 13'd0;
		din_in_31   <= 13'd0;
		din_in_32   <= 13'd0;
		din_in_33   <= 13'd0;
		din_in_34   <= 13'd0;
		din_in_35   <= 13'd0;
		din_in_36   <= 13'd0;
		din_in_37   <= 13'd0;
		din_in_38   <= 13'd0;
		din_in_39   <= 13'd0;
		din_in_40   <= 13'd0;
		din_in_41   <= 13'd0;
	end
	else if ( data_in_en == 1'b1 ) begin
		din_in_0	<= data_in		;		// 阻塞和非阻塞
		din_in_1	<= din_in_0		;
		din_in_2	<= din_in_1		;
		din_in_3	<= din_in_2		;
		din_in_4	<= din_in_3		;
		din_in_5	<= din_in_4		;
		din_in_6	<= din_in_5		;
		din_in_7	<= din_in_6		;
		din_in_8	<= din_in_7		;
		din_in_9	<= din_in_8		;
		din_in_10	<= din_in_9		;
		din_in_11	<= din_in_10	;
		din_in_12	<= din_in_11	;
		din_in_13	<= din_in_12	;
		din_in_14	<= din_in_13	;
		din_in_15	<= din_in_14	;
		din_in_16	<= din_in_15	;
		din_in_17	<= din_in_16	;
		din_in_18	<= din_in_17	;
		din_in_19	<= din_in_18	;
		din_in_20	<= din_in_19	;
		din_in_21	<= din_in_20	;
		din_in_22   <= din_in_21	;
		din_in_23   <= din_in_22    ;
		din_in_24   <= din_in_23    ;
		din_in_25   <= din_in_24    ;
		din_in_26   <= din_in_25    ;
		din_in_27   <= din_in_26    ;
		din_in_28   <= din_in_27    ;
		din_in_29   <= din_in_28    ;
		din_in_30   <= din_in_29    ;
		din_in_31   <= din_in_30    ;
		din_in_32   <= din_in_31	;
		din_in_33   <= din_in_32    ;
		din_in_34   <= din_in_33    ;
		din_in_35   <= din_in_34    ;
		din_in_36   <= din_in_35    ;
		din_in_37   <= din_in_36    ;
		din_in_38   <= din_in_37    ;
		din_in_39   <= din_in_38    ;
		din_in_40   <= din_in_39    ;
		din_in_41   <= din_in_40    ;
	end
end
				  
reg		signed	[22:0]	dh0		;	// din0 * h0
reg		signed	[22:0]	dh1		;
reg		signed	[22:0]	dh2		;
reg		signed	[22:0]	dh3		;
reg		signed	[22:0]	dh4		;
reg		signed	[22:0]	dh5		;
reg		signed	[22:0]	dh6		;
reg		signed	[22:0]	dh7		;
reg		signed	[22:0]	dh8		;
reg		signed	[22:0]	dh9		;
reg		signed	[22:0]	dh10	;
reg		signed	[22:0]	dh11	;
reg		signed	[22:0]	dh12	;
reg		signed	[22:0]	dh13	;
reg		signed	[22:0]	dh14	;
reg		signed	[22:0]	dh15	;
reg		signed	[22:0]	dh16	;
reg		signed	[22:0]	dh17	;
reg		signed	[22:0]	dh18	;
reg		signed	[22:0]	dh19	;
reg		signed	[22:0]	dh20	;
reg		signed	[22:0]	dh21	;
reg		signed	[22:0]	dh22	;
reg		signed	[22:0]	dh23	;
reg		signed	[22:0]	dh24	;
reg		signed	[22:0]	dh25	;
reg		signed	[22:0]	dh26	;
reg		signed	[22:0]	dh27	;
reg		signed	[22:0]	dh28	;
reg		signed	[22:0]	dh29	;
reg		signed	[22:0]	dh30	;
reg		signed	[22:0]	dh31	;
reg		signed	[22:0]	dh32	;
reg		signed	[22:0]	dh33	;
reg		signed	[22:0]	dh34	;
reg		signed	[22:0]	dh35	;
reg		signed	[22:0]	dh36	;
reg		signed	[22:0]	dh37	;
reg		signed	[22:0]	dh38	;
reg		signed	[22:0]	dh39	;
reg		signed	[22:0]	dh40	;
reg		signed	[22:0]	dh41	;
always @( posedge sys_clk or negedge sys_rst_n ) begin
	if ( !sys_rst_n ) begin
		dh0		<= 23'd0;	
		dh1		<= 23'd0;
		dh2		<= 23'd0;
		dh3		<= 23'd0;
		dh4		<= 23'd0;
		dh5		<= 23'd0;
		dh6		<= 23'd0;
		dh7		<= 23'd0;
		dh8		<= 23'd0;
		dh9		<= 23'd0;
		dh10	<= 23'd0;
		dh11	<= 23'd0;
		dh12	<= 23'd0;
		dh13	<= 23'd0;
		dh14	<= 23'd0;
		dh15	<= 23'd0;
		dh16	<= 23'd0;
		dh17	<= 23'd0;
		dh18	<= 23'd0;
		dh19	<= 23'd0;
		dh20	<= 23'd0;
		dh21	<= 23'd0;
		dh22	<= 23'd0;
		dh23	<= 23'd0;
		dh24	<= 23'd0;
		dh25	<= 23'd0;
		dh26	<= 23'd0;
		dh27	<= 23'd0;
		dh28	<= 23'd0;
		dh29	<= 23'd0;
		dh30	<= 23'd0;
		dh31	<= 23'd0;
		dh32    <= 23'd0;
		dh33    <= 23'd0;
		dh34    <= 23'd0;
		dh35    <= 23'd0;
		dh36    <= 23'd0;
		dh37    <= 23'd0;
		dh38    <= 23'd0;
		dh39    <= 23'd0;
		dh40    <= 23'd0;
		dh41    <= 23'd0;
	end         
	else if ( data_in_en == 1'b1 )begin
		dh0		<= din_in_0  * fir_coe_h0	;
		dh1		<= din_in_1  * fir_coe_h1	;
		dh2		<= din_in_2  * fir_coe_h2	;
		dh3		<= din_in_3  * fir_coe_h3	;
		dh4		<= din_in_4  * fir_coe_h4	;
		dh5		<= din_in_5  * fir_coe_h5	;
		dh6		<= din_in_6  * fir_coe_h6	;
		dh7		<= din_in_7  * fir_coe_h7	;
		dh8		<= din_in_8  * fir_coe_h8	;
		dh9		<= din_in_9  * fir_coe_h9	;
		dh10	<= din_in_10 * fir_coe_h10	;
		dh11	<= din_in_11 * fir_coe_h11	;
		dh12	<= din_in_12 * fir_coe_h12	;
		dh13	<= din_in_13 * fir_coe_h13	;
		dh14	<= din_in_14 * fir_coe_h14	;
		dh15	<= din_in_15 * fir_coe_h15	;
		dh16	<= din_in_16 * fir_coe_h16	;
		dh17	<= din_in_17 * fir_coe_h17	;
		dh18	<= din_in_18 * fir_coe_h18	;
		dh19	<= din_in_19 * fir_coe_h19	;
	    dh20	<= din_in_20 * fir_coe_h20	;
	    dh21	<= din_in_21 * fir_coe_h21	;
		dh22	<= din_in_22 * fir_coe_h22	;
		dh23	<= din_in_23 * fir_coe_h23	;
		dh24	<= din_in_24 * fir_coe_h24	;
		dh25	<= din_in_25 * fir_coe_h25	;
		dh26	<= din_in_26 * fir_coe_h26	;
		dh27	<= din_in_27 * fir_coe_h27	;
		dh28	<= din_in_28 * fir_coe_h28	;
		dh29	<= din_in_29 * fir_coe_h29	;
	    dh30	<= din_in_30 * fir_coe_h30	;
	    dh31	<= din_in_31 * fir_coe_h31	;
		dh32	<= din_in_32 * fir_coe_h32	;
		dh33	<= din_in_33 * fir_coe_h33	;
		dh34	<= din_in_34 * fir_coe_h34	;
		dh35	<= din_in_35 * fir_coe_h35	;
		dh36	<= din_in_36 * fir_coe_h36	;
		dh37	<= din_in_37 * fir_coe_h37	;
		dh38	<= din_in_38 * fir_coe_h38	;
		dh39	<= din_in_39 * fir_coe_h39	;
		dh40	<= din_in_40 * fir_coe_h40	;
		dh41	<= din_in_41 * fir_coe_h41	;
	end             
end      

// addr

reg		signed	[23:0]	fir_addr;		// 26 + 5
always @( posedge sys_clk or negedge sys_rst_n ) begin
	if ( !sys_rst_n ) begin
		fir_addr <= 24'd0;
	end
	else if ( data_in_en == 1'b1 ) begin
		fir_addr <= 
					dh0  + 	dh1  +   dh2  +   dh3  + 
                    dh4  +  dh5  +   dh6  +   dh7  + 
                    dh8  +  dh9  +   dh10 +   dh11 + 
                    dh12 + 	dh13 +   dh14 +   dh15 + 
                    dh16 + 	dh17 +   dh18 +   dh19 + 
                    dh20 + 	dh21 +   dh22 +   dh23 +
					dh24 + 	dh25 +   dh26 +   dh27 +
					dh28 + 	dh29 +   dh30 +   dh31 +
					dh32 + 	dh33 +   dh34 +   dh35 + 
                    dh36 + 	dh37 +   dh38 +   dh39 + 
                    dh40 + 	dh41;
		
					// {{3{dh0[26]}} , dh0[25:0] } + {{3{dh1[26] }}, dh1[25:0] } + {{3{dh2[26] }}, dh2[25:0] } + {{3{dh3[26] }}, dh3[25:0] } + 
                    // {{3{dh4[26]}} , dh4[25:0] } + {{3{dh5[26] }}, dh5[25:0] } + {{3{dh6[26] }}, dh6[25:0] } + {{3{dh7[26] }}, dh7[25:0] } + 
                    // {{3{dh8[26]}} , dh8[25:0] } + {{3{dh9[26] }}, dh9[25:0] } + {{3{dh10[26]}}, dh10[25:0]} + {{3{dh11[26]}}, dh11[25:0]} + 
                    // {{3{dh12[26]}}, dh12[25:0]} + {{3{dh13[26]}}, dh13[25:0]} + {{3{dh14[26]}}, dh14[25:0]} + {{3{dh15[26]}}, dh15[25:0]} + 
                    // {{3{dh16[26]}}, dh16[25:0]} + {{3{dh17[26]}}, dh17[25:0]} + {{3{dh18[26]}}, dh18[25:0]} + {{3{dh19[26]}}, dh19[25:0]} + 
                    // {{3{dh20[26]}}, dh20[25:0]} + {{3{dh21[26]}}, dh21[25:0]} + {{3{dh22[26]}}, dh22[25:0]} + {{3{dh23[26]}}, dh23[25:0]} +
					// {{3{dh24[26]}}, dh24[25:0]} + {{3{dh25[26]}}, dh25[25:0]} + {{3{dh26[26]}}, dh26[25:0]} + {{3{dh27[26]}}, dh27[25:0]} +
					// {{3{dh28[26]}}, dh28[25:0]} + {{3{dh29[26]}}, dh29[25:0]} + {{3{dh30[26]}}, dh30[25:0]} + {{3{dh31[26]}}, dh31[25:0]} + 
					// {{3{dh22[26]}}, dh22[25:0]} + {{3{dh23[26]}}, dh23[25:0]} + {{3{dh24[26]}}, dh24[25:0]} + {{3{dh25[26]}}, dh25[25:0]} + 
					// {{3{dh26[26]}}, dh26[25:0]} + {{3{dh27[26]}}, dh27[25:0]} + {{3{dh28[26]}}, dh28[25:0]} + {{3{dh29[26]}}, dh29[25:0]} + 
					// {{3{dh30[26]}}, dh30[25:0]} + {{3{dh31[26]}}, dh31[25:0]} ;
	end     
end         
            
reg		fir_out_en_r1;
reg		fir_out_en_r2;
always @( posedge sys_clk or negedge sys_rst_n ) begin
	if ( !sys_rst_n ) begin
		fir_out_en_r1 <= 1'b0;
		fir_out_en_r2 <= 1'b0;
    end
	else begin 
		fir_out_en_r1 <= data_in_en ;
		fir_out_en_r2 <= fir_out_en_r1 ;
	end
end           

assign fir_out  = ( data_in_en == 1'b1 ) ? fir_addr[22:10] : fir_out;
 //{{{fir_addr[27]}}, fir_addr[26:10]};
assign fir_out_en = fir_out_en_r2;


endmodule































