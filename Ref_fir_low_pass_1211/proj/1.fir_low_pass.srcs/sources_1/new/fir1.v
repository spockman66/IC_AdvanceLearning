`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/11 20:23:45
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
	input					sys_clk			,
	input					sys_rst_n		,
		
	input	signed	[12:0]	dds_din			,	// x(n)
	input					dds_valid		,	
		
	output	signed	[12:0]	fir_out			,
	output					fir_out_valid	
);

reg		signed 	[9:0]	h0	;
reg		signed 	[9:0]	h1	;
reg		signed 	[9:0]	h2	;
reg		signed 	[9:0]	h3	;
reg		signed 	[9:0]	h4	;
reg		signed 	[9:0]	h5	;
reg		signed 	[9:0]	h6	;
reg		signed 	[9:0]	h7	;
reg		signed 	[9:0]	h8	;
reg		signed 	[9:0]	h9	;
reg		signed 	[9:0]	h10	;
reg		signed 	[9:0]	h11	;
reg		signed 	[9:0]	h12	;
reg		signed 	[9:0]	h13	;
reg		signed 	[9:0]	h14	;
reg		signed 	[9:0]	h15	;
reg		signed 	[9:0]	h16	;
reg		signed 	[9:0]	h17	;
reg		signed 	[9:0]	h18	;
reg		signed 	[9:0]	h19	;
reg		signed 	[9:0]	h20	;
reg		signed 	[9:0]	h21	;
reg		signed 	[9:0]	h22	;
reg		signed 	[9:0]	h23	;
reg		signed 	[9:0]	h24	;
reg		signed 	[9:0]	h25	;
reg		signed 	[9:0]	h26	;
reg		signed 	[9:0]	h27	;
reg		signed 	[9:0]	h28	;
reg		signed 	[9:0]	h29	;
reg		signed 	[9:0]	h30	;
reg		signed 	[9:0]	h31	;
	
always @( posedge sys_clk or negedge sys_rst_n ) begin
	if ( !sys_rst_n ) begin
		h0	<= 10'd0;
        h1	<= 10'd0;
        h2	<= 10'd0;
        h3	<= 10'd0;
        h4	<= 10'd0;
        h5	<= 10'd0;
        h6	<= 10'd0;
        h7	<= 10'd0;
        h8	<= 10'd0;
        h9	<= 10'd0;
        h10	<= 10'd0;
        h11	<= 10'd0;
        h12	<= 10'd0;
        h13	<= 10'd0;
        h14	<= 10'd0;
        h15	<= 10'd0;
        h16	<= 10'd0;
        h17	<= 10'd0;
        h18	<= 10'd0;
        h19	<= 10'd0;
        h20	<= 10'd0;
        h21	<= 10'd0;
        h22	<= 10'd0;
        h23	<= 10'd0;
        h24	<= 10'd0;
        h25	<= 10'd0;
        h26	<= 10'd0;
        h27	<= 10'd0;
        h28	<= 10'd0;
        h29	<= 10'd0;
        h30	<= 10'd0;
        h31	<= 10'd0;	
	end
	else begin
		h0	<= -10'd14;
	    h1	<=  10'd12;
	    h2	<=  10'd12;
	    h3	<=  10'd14;
	    h4	<=  10'd18;
	    h5	<=  10'd22;
	    h6	<=  10'd27;
	    h7	<=  10'd32;
	    h8	<=  10'd37;
	    h9	<=  10'd42;
	    h10	<=  10'd47;
	    h11	<=  10'd51;
	    h12	<=  10'd54;
	    h13	<=  10'd57;
	    h14	<=  10'd59;
	    h15	<=  10'd60;
	    h16	<=  10'd60;
	    h17	<=  10'd59;
	    h18	<=  10'd57;
	    h19	<=  10'd54;
	    h20	<=  10'd51;
	    h21	<=  10'd47;
	    h22	<=  10'd42;
	    h23	<=  10'd37;
	    h24	<=  10'd32;
	    h25	<=  10'd27;
	    h26	<=  10'd22;
	    h27	<=  10'd18;
	    h28	<=  10'd14;
	    h29	<=  10'd12;
		h30	<=  10'd12;
		h31	<= -10'd14;
		
































	end
end


reg		signed		[12:0]	x0	;
reg		signed		[12:0]	x1	;
reg		signed		[12:0]	x2	;
reg		signed		[12:0]	x3	;
reg		signed		[12:0]	x4	;
reg		signed		[12:0]	x5	;
reg		signed		[12:0]	x6	;
reg		signed		[12:0]	x7	;
reg		signed		[12:0]	x8	;
reg		signed		[12:0]	x9	;
reg		signed		[12:0]	x10	;
reg		signed		[12:0]	x11	;
reg		signed		[12:0]	x12	;
reg		signed		[12:0]	x13	;
reg		signed		[12:0]	x14	;
reg		signed		[12:0]	x15	;
reg		signed		[12:0]	x16	;
reg		signed		[12:0]	x17	;
reg		signed		[12:0]	x18	;
reg		signed		[12:0]	x19	;
reg		signed		[12:0]	x20	;
reg		signed		[12:0]	x21	;
reg		signed		[12:0]	x22	;
reg		signed		[12:0]	x23	;
reg		signed		[12:0]	x24	;
reg		signed		[12:0]	x25	;
reg		signed		[12:0]	x26	;
reg		signed		[12:0]	x27	;
reg		signed		[12:0]	x28	;
reg		signed		[12:0]	x29	;
reg		signed		[12:0]	x30	;
reg		signed		[12:0]	x31	;

always @( posedge sys_clk or negedge sys_rst_n ) begin
	if ( !sys_rst_n ) begin
		x0	<= 13'd0;
	    x1	<= 13'd0;
	    x2	<= 13'd0;
	    x3	<= 13'd0;
	    x4	<= 13'd0;
	    x5	<= 13'd0;
	    x6	<= 13'd0;
	    x7	<= 13'd0;
	    x8	<= 13'd0;
	    x9	<= 13'd0;
	    x10	<= 13'd0;
	    x11	<= 13'd0;
	    x12	<= 13'd0;
	    x13	<= 13'd0;
	    x14	<= 13'd0;
	    x15	<= 13'd0;
	    x16	<= 13'd0;
	    x17	<= 13'd0;
	    x18	<= 13'd0;
	    x19	<= 13'd0;
	    x20	<= 13'd0;
	    x21	<= 13'd0;
	    x22	<= 13'd0;
	    x23	<= 13'd0;
	    x24	<= 13'd0;
	    x25	<= 13'd0;
	    x26	<= 13'd0;
	    x27	<= 13'd0;      
	    x28	<= 13'd0;
	    x29	<= 13'd0;
	    x30	<= 13'd0;
	    x31	<= 13'd0;
	end
	else if ( dds_valid == 1'b1 ) begin
		x0  <= dds_din	;
		x1 	<= x0		;
		x2	<= x1 		;
		x3	<= x2		;
		x4	<= x3		;
		x5	<= x4		;
		x6	<= x5		;
		x7	<= x6		;
		x8	<= x7		;
		x9	<= x8		;
		x10	<= x9		;
		x11	<= x10		;
		x12	<= x11		;
		x13	<= x12		;
		x14	<= x13		;
		x15	<= x14		;
		x16	<= x15		;
		x17	<= x16		;
		x18	<= x17		;
		x19	<= x18		;
		x20	<= x19		;
		x21	<= x20		;
		x22	<= x21		;
		x23	<= x22		;
		x24	<= x23		;
		x25	<= x24		;
		x26	<= x25		;
		x27	<= x26		;
		x28	<= x27		;
		x29	<= x28		;
        x30	<= x29		;
        x31	<= x30		;
	end 
end  

// 相乘 x0 * h0  13'b * 10'b
reg		signed		[22:0]	xh_mul0		;
reg		signed		[22:0]	xh_mul1		;
reg		signed		[22:0]	xh_mul2		;
reg		signed		[22:0]	xh_mul3		;
reg		signed		[22:0]	xh_mul4		;
reg		signed		[22:0]	xh_mul5		;
reg		signed		[22:0]	xh_mul6		;
reg		signed		[22:0]	xh_mul7		;
reg		signed		[22:0]	xh_mul8		;
reg		signed		[22:0]	xh_mul9		;
reg		signed		[22:0]	xh_mul10	;
reg		signed		[22:0]	xh_mul11	;
reg		signed		[22:0]	xh_mul12	;
reg		signed		[22:0]	xh_mul13	;
reg		signed		[22:0]	xh_mul14	;
reg		signed		[22:0]	xh_mul15	;
reg		signed		[22:0]	xh_mul16	;
reg		signed		[22:0]	xh_mul17	;
reg		signed		[22:0]	xh_mul18	;
reg		signed		[22:0]	xh_mul19	;
reg		signed		[22:0]	xh_mul20	;
reg		signed		[22:0]	xh_mul21	;
reg		signed		[22:0]	xh_mul22	;
reg		signed		[22:0]	xh_mul23	;
reg		signed		[22:0]	xh_mul24	;
reg		signed		[22:0]	xh_mul25	;
reg		signed		[22:0]	xh_mul26	;
reg		signed		[22:0]	xh_mul27	;
reg		signed		[22:0]	xh_mul28	;
reg		signed		[22:0]	xh_mul29	;
reg		signed		[22:0]	xh_mul30	;
reg		signed		[22:0]	xh_mul31	;
always @( posedge sys_clk or negedge sys_rst_n ) begin
	if ( !sys_rst_n ) begin
		xh_mul0		<= 23'd0;	
        xh_mul1		<= 23'd0;
        xh_mul2		<= 23'd0;
		xh_mul3		<= 23'd0;
        xh_mul4		<= 23'd0;
        xh_mul5		<= 23'd0;
        xh_mul6		<= 23'd0;
        xh_mul7		<= 23'd0;
        xh_mul8		<= 23'd0;
        xh_mul9		<= 23'd0;
        xh_mul10	<= 23'd0;
        xh_mul11	<= 23'd0;
        xh_mul12	<= 23'd0;
        xh_mul13	<= 23'd0;
        xh_mul14	<= 23'd0;
        xh_mul15	<= 23'd0;
        xh_mul16	<= 23'd0;
        xh_mul17	<= 23'd0;
        xh_mul18	<= 23'd0;
        xh_mul19	<= 23'd0;
        xh_mul20	<= 23'd0;
        xh_mul21	<= 23'd0;
        xh_mul22	<= 23'd0;
        xh_mul23	<= 23'd0;
        xh_mul24	<= 23'd0;
        xh_mul25	<= 23'd0;
        xh_mul26	<= 23'd0;
        xh_mul27	<= 23'd0;
        xh_mul28	<= 23'd0;
        xh_mul29	<= 23'd0;
		xh_mul30	<= 23'd0;
		xh_mul31	<= 23'd0;
	end
	else if ( dds_valid == 1'b1 )begin			// 数据必须是真的
		xh_mul0		<= 	x0 	*   h0	;			// 优化fir
	    xh_mul1		<=  x1 	*	h1	;
	    xh_mul2		<=  x2	*   h2	;
	    xh_mul3		<=  x3	*   h3	;
	    xh_mul4		<=  x4	*   h4	;
	    xh_mul5		<=  x5	*   h5	;
	    xh_mul6		<=  x6	*   h6	;
	    xh_mul7		<=  x7	*   h7	;
	    xh_mul8		<=  x8	*   h8	;
	    xh_mul9		<=  x9	*   h9	;
	    xh_mul10	<=  x10	*	h10 ;
	    xh_mul11	<=  x11	*	h11 ;
	    xh_mul12	<=  x12	*	h12 ;
	    xh_mul13	<=  x13	*	h13 ;
	    xh_mul14	<=  x14	*	h14 ;
	    xh_mul15	<=  x15	*	h15 ;
	    xh_mul16	<=  x16	*	h16 ;
	    xh_mul17	<=  x17	*	h17 ;
	    xh_mul18	<=  x18	*	h18 ;
	    xh_mul19	<=  x19	*	h19 ;
	    xh_mul20	<=  x20	*	h20 ;
	    xh_mul21	<=  x21	*	h21 ;
	    xh_mul22	<=  x22	*	h22 ;
	    xh_mul23	<=  x23	*	h23 ;
	    xh_mul24	<=  x24	*	h24 ;
	    xh_mul25	<=  x25	*	h25 ;
	    xh_mul26	<=  x26	*	h26 ;
	    xh_mul27	<=  x27	*	h27 ;
	    xh_mul28	<=  x28	*	h28 ;
	    xh_mul29	<=  x29	*	h29 ;
	    xh_mul30	<=  x30	*	h30 ;
	    xh_mul31	<=  x31	*	h31 ;
	end
end

reg		signed	[23:0]	xh_add;			// 位宽待确定？？？？
always @( posedge sys_clk or negedge sys_rst_n ) begin
	if ( !sys_rst_n )
		xh_add <= 24'd0;
	else if ( dds_valid == 1'b1 )
		xh_add <= 	xh_mul0  + xh_mul1  + xh_mul2  + xh_mul3  + xh_mul4  + xh_mul5  + 
					xh_mul6  + xh_mul7  + xh_mul8  + xh_mul9  + xh_mul10 + xh_mul11 + 
					xh_mul12 + xh_mul13 + xh_mul14 + xh_mul15 + xh_mul16 + xh_mul17 +
					xh_mul18 + xh_mul19 + xh_mul20 + xh_mul21 + xh_mul22 + xh_mul23 +
					xh_mul24 + xh_mul25 + xh_mul26 + xh_mul27 + xh_mul28 + xh_mul29 + 
					xh_mul30 + xh_mul31	;	  
end              	
                  
                  
reg		signed    [12:0] fir_out_r;              
always @( posedge sys_clk or negedge sys_rst_n ) begin
	if ( !sys_rst_n )
		fir_out_r <= 13'd0;
	else if ( dds_valid == 1'b1 )
		fir_out_r <= xh_add[22:10];
end                  
               
reg		out_valid_r1;			// 第一个延时
reg		out_valid_r2;			// 第二个延时
always @( posedge sys_clk or negedge sys_rst_n ) begin
	if ( !sys_rst_n ) begin
		out_valid_r1 <= 1'b0;
		out_valid_r2 <= 1'b0;
	end 
	else begin
		out_valid_r1 <= dds_valid		;
		out_valid_r2 <= out_valid_r1	;
	end
end

assign	fir_out = ( dds_valid == 1'b1 ) ? fir_out_r : fir_out;
assign  fir_out_valid = out_valid_r2;
                  
endmodule
