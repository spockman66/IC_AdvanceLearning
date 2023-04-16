module gray_counter_tb();
    parameter period = 2;
    parameter WIDTH = 4;
    reg clk_i;
    reg rst_i;
    reg cnt_en;
    initial begin
        clk_i = 1'b1;
        rst_i = 1'b1;
        cnt_en = 1'b0;
        #(period);
        @(negedge clk_i) rst_i = 1'b0;
        #(period);
        @(negedge clk_i) cnt_en = 1'b1;
    end
    always #(period) clk_i <= ~clk_i;

    wire [WIDTH-1:0] gray_cnt_o;

    gray_counter #(.WIDTH(WIDTH)) u_gray_counter_tb(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .cnt_en_i(cnt_en),
        .gray_cnt_o(gray_cnt_o)
    );


endmodule
