
module clk_divider_half_50
   (
    input    wire  rst ,
    input    wire  clk,
    output   wire  clk_div
    );

//*************code***********//

/* 占空比为50%的半数分频器 */

wire clk_odd_p;
wire clk_odd_n;
reg [2:0] clk_cnt_p, clk_cnt_n;

always@(posedge clk or negedge rst) begin
    if(~rst || &clk_cnt_p[2:1] && ~clk_cnt_p[0])
        clk_cnt_p <= 3'd0;
    else
        clk_cnt_p <= clk_cnt_p + 1'b1;
end

always@(negedge clk or negedge rst) begin
    if(~rst||&clk_cnt_n[2:1] && ~clk_cnt_n[0])
        clk_cnt_n <= 3'd0;
    else
        clk_cnt_n <= clk_cnt_n + 1'b1;
end

assign clk_odd_n = (clk_cnt_n==3)?1'b1:1'b0;
assign clk_odd_p = (clk_cnt_p<3)?1'b1:1'b0;

assign clk_div = clk_odd_p | clk_odd_n;

//*************code***********//
endmodule