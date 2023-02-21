module clk_divider_even#(
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