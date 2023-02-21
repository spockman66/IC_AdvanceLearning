module clk_divider_float #(
	parameter real DIV_PARAM = 3.3
)
(
    input clk			,
    input rstn			,

	output clk_div
);

/*
    任意小数分频原理：43/5实际上是5个时钟周期内持续的时间信号为430ns
        双模前置小数分频
        对于8.6分频，整数部分为8，因此选用8分频和9分频来进行合成，列出二元方程组如下
            8a+9b=43
            a+b=5
        得出来a和b的解为2和3
        即需要做2个8分频，3个9分频
            (1) 先进行 2 次 8 分频，再进行 3 次 9 分频；
            (2) 先进行 3 次 9 分频，再进行 2 次 8 分频；
            (3) 将 2 次 8 分频平均的插入到 3 次 9 分频中；
        实现：
            实际上很多种抽象方法，即用一个大的计数器count（从0计到4，即代表了5个周期）
            当count=0，2，4的时候，执行9分频，当count=1，3的时候，执行8分频
*/

parameter integer M = $floor(DIV_PARAM);
parameter integer N = M+1;



// assign clk_div_p = clk_cnt_p==8'd0;
// assign clk_div_n = clk_cnt_n==DIV_PARAM+0.5;
// assign clk_div = clk_div_p | clk_div_n;


reg [7:0] clk_cnt_maj;
reg [7:0] clk_cnt_min;

always@(posedge clk or negedge rstn) begin
    if(~rstn || clk_cnt_maj == 8'd4 && clk_cnt_min == 8'd0) 
        clk_cnt_maj <= 8'd0;
    else if (clk_cnt_min == 8'd0)
        clk_cnt_maj <= clk_cnt_maj + 1'b1;
    else
        clk_cnt_maj <= clk_cnt_maj;
end

always@(posedge clk or negedge rstn) begin
    if(~rstn)
        clk_cnt_min <= 8'd8;
    else if(clk_cnt_min==8'b0) begin
        case (clk_cnt_maj)
            0,2,4: begin:div_nine
                clk_cnt_min <= 'd8;
            end
            1,3: begin:div_eight
                clk_cnt_min <= 'd7;
            end
        endcase
    end
    else begin
        clk_cnt_min <= clk_cnt_min - 1'b1;
    end
end


assign clk_div = (clk_cnt_maj==4'd4 && clk_cnt_min==8'd0) ? 1:0;

endmodule