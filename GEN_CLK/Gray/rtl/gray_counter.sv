/*  Date: 2023.04.15
    格雷码计数器：
        方法一：二进制转格雷码，bin>>1 ^ bin;
        方法二：分析格雷码各位的逻辑
    
    最低位规律：和上周期的数值不同，保持；和上周期的数值相同，取反
    最高位规律：和次高位数值不同，其他位全部为0，此时翻转
    其他位规律：和上周期数值相同，低一位是1，其他低位均为0（若无其他位不比较），此时翻转
*/
//when highest bit equals the second highest bit, and other bits are 0, flip it

module gray_counter #(parameter WIDTH = 4)(//WIDTH >= 3
    input logic clk_i,
    input logic rst_i,
    input logic cnt_en_i,
    output logic             carry_bit_o,
    output logic [WIDTH-1:0] gray_cnt_o
);

    logic [WIDTH-1:0] gray_cnt_r;
    always_ff @(posedge clk_i, negedge rst_i) begin
        if(rst_i) begin
            gray_cnt_r  <= {(WIDTH){1'b0}};
        end
        else begin
            gray_cnt_r  <= gray_cnt_o[WIDTH-1:0];
        end
    end

    // LSB
    always_ff @(posedge clk_i, negedge rst_i)begin
        if(rst_i)begin
            gray_cnt_o[0]          <= 1'b0;
            carry_bit_o            <= 1'b0;
        end
        else if(cnt_en_i)begin
            gray_cnt_o[0]          <= (gray_cnt_r[0]^gray_cnt_o[0]) ? gray_cnt_o[0]:~gray_cnt_o[0];
            carry_bit_o            <= (gray_cnt_o[WIDTH-1]&~(|gray_cnt_o[WIDTH-2:0]))? ~carry_bit_o:carry_bit_o;
        end
    end

    // Second LSB
    always_ff @(posedge clk_i, negedge rst_i)begin
        if(rst_i)
            gray_cnt_o[1]  <= 1'b0;
        else if(cnt_en_i)
            gray_cnt_o[1]  <= ~(gray_cnt_r[1]^gray_cnt_o[1]) & gray_cnt_o[0] ? ~gray_cnt_o[1] : gray_cnt_o[1];
    end

    // MSB
    always_ff @(posedge clk_i, negedge rst_i) begin
        if(rst_i)
            gray_cnt_o[WIDTH-1] <= 1'b0;
        else if((gray_cnt_o[WIDTH-1]^gray_cnt_o[WIDTH-2]) & ~(|gray_cnt_o[WIDTH-3:0]))
            gray_cnt_o[WIDTH-1] <= ~gray_cnt_o[WIDTH-1];
    end

    // between Second LSB and MSB
    genvar i;
    generate for(i=2;i<WIDTH-1;i=i+1)begin: MID
        always_ff @(posedge clk_i, negedge rst_i)begin
            if(rst_i)
                gray_cnt_o[i]    <= 1'b0;
            else if(cnt_en_i)
                if(~(gray_cnt_r[i]^gray_cnt_o[i]) & gray_cnt_o[i-1])    
                    gray_cnt_o[i] <= ~(|gray_cnt_o[i-2:0]) ? ~gray_cnt_o[i] : gray_cnt_o[i];
        end
    end
    endgenerate



endmodule
