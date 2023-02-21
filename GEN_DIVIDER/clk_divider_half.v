module clk_divider_half#(
	parameter real DIV_PARAM = 3.5
)
(
    input clk			,
    input rstn			,

	output clk_div
);

/*
    半分频原理：
    用上升沿和下降沿各产生一个7分频的时钟信号，这两个信号的距离是3.5个时钟周期，
    用逻辑或的形式，即可产生无抖动3.5分频信号
*/


reg [7:0] clk_cnt_p, clk_cnt_n;
wire clk_div_p, clk_div_n;

always @(posedge clk or negedge rstn) begin
    if(~rstn || clk_cnt_p == DIV_PARAM*2-1)
        clk_cnt_p <= 8'd0;
    else
        clk_cnt_p <= clk_cnt_p + 1'b1;
end

always @(negedge clk or negedge rstn) begin
    if(~rstn || clk_cnt_n == DIV_PARAM*2-1)
        clk_cnt_n <= 8'd0;
    else
        clk_cnt_n <= clk_cnt_n + 1'b1;
end

assign clk_div_p = clk_cnt_p==8'd0;
assign clk_div_n = clk_cnt_n==DIV_PARAM+0.5;
assign clk_div = clk_div_p | clk_div_n;


endmodule