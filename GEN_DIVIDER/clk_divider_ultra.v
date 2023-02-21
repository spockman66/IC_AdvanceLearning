module clk_divider_ultra#(
	parameter integer DIV_PARAM = 10
)
(
    input clk			,
    input rstn			,

	output clk_div
);

reg clk_reg_1;
reg clk_reg_2;
reg clk_reg_3;


reg [7:0] clk_cnt;


generate
	if (DIV_PARAM % 2==0) begin:div_even		
	/* 偶数分频 */
		reg clk_even;
		always @(posedge clk or negedge rstn) begin
			if(~rstn || clk_cnt == DIV_PARAM/2-1)
				clk_cnt <= 8'd0;
			else
				clk_cnt <= clk_cnt + 1'b1;
		end
		
		always @(posedge clk or negedge rstn) begin
			if(~rstn)
				clk_even <= 1'b0;
			else if (clk_cnt == DIV_PARAM/2-1)		// 直接翻转即可
				clk_even <= ~clk_even;
			else
				clk_even <= clk_even;
		end

		assign clk_div = clk_even;
	end
	else begin:div_odd	
	/* 奇数分频 */	
		reg clk_odd_p;
		reg clk_odd_n;

		always @(posedge clk or negedge rstn) begin
			if(~rstn || clk_cnt == DIV_PARAM-1)
				clk_cnt <= 8'd0;
			else
				clk_cnt <= clk_cnt + 1'b1;
		end
		
		always @(posedge clk or negedge rstn) begin
			if(~rstn)
				clk_odd_p <= 1'b0;
			else if (clk_cnt == (DIV_PARAM-1)/2 || clk_cnt == DIV_PARAM-1)			// 奇数分频，在一半的位置做翻转
				clk_odd_p <= ~clk_odd_p;
			else
				clk_odd_p <= clk_odd_p;
		end

		always @(negedge clk or negedge rstn) begin
			if(~rstn)
				clk_odd_n <= 1'b0;
			else if (clk_cnt == (DIV_PARAM-1)/2 || clk_cnt == DIV_PARAM-1)
				clk_odd_n <= ~clk_odd_n;
			else
				clk_odd_n <= clk_odd_n;
		end
		assign clk_div = clk_odd_p|clk_odd_n;			// 两个40%占空比的时钟取或
	end
endgenerate




/* 级联寄存器分频 */
always @(posedge clk or negedge rstn) begin
	if(~rstn)
		clk_reg_1 <= 1'b0;
	else
		clk_reg_1 <= ~clk_reg_1;
end

always @(posedge clk_reg_1 or negedge rstn) begin
	if(~rstn)
		clk_reg_2 <= 1'b0;
	else
		clk_reg_2 <= ~clk_reg_2;
end

always @(posedge clk_reg_2 or negedge rstn) begin
	if(~rstn)
		clk_reg_3 <= ~1'b0;
	else
		clk_reg_3 <= ~clk_reg_3;
end


endmodule