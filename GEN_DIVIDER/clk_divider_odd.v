// 奇数分频

module clk_divider_odd#(
	parameter integer DIV_PARAM = 5
)
(
    input clk			,
    input rstn			,

	output clk_div
);

	/* 奇数分频 */	
		reg clk_odd_p;
		reg clk_odd_n;
        reg [4:0] clk_cnt;

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

endmodule