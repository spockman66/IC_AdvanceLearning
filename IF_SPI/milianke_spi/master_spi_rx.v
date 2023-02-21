module master_spi_rx#
    (
        parameter CPOL = 1'b0,
        parameter CPHA = 1'b0
    ) ( 
        input clk_i,
        input spi_rx_i,//SPI 接收 MISO
        input spi_clk_i,
        input spi_en_i,
        output reg [7:0] spi_rx_o,
        output reg spi_rx_done
      );
    
    //当 spi_en_i 位 1 SPI 开始传输数据， 当 spi_en_i 从 1 变 0， 代表数据传输完毕
    // reg [7:0] spi_rx = 8'd0;
    // reg spi_rx_done = 1'b0;
    reg spi_en_r = 1'b0;
    reg [7:0] rx = 7'd0;

    wire spi_rx_end = (spi_en_r && spi_en_i == 1'b0);

    always @(posedge clk_i) begin
        spi_en_r <= spi_en_i;
        spi_rx_done <= spi_rx_end;
    end
    reg spi_clk_r = 1'b0;
    wire spi_clkp = spi_clk_i&&(spi_clk_r==1'b0);
    wire spi_clkn = spi_clk_r&&(spi_clk_i==1'b0);
    always @(posedge clk_i) begin
        spi_clk_r <= spi_clk_i;
    end
    //SPI 模式控制
    reg spi_cap = 1'b0;
    always @(*) begin
        if(CPHA) begin //第一个时钟采样
            if(CPOL)
                spi_cap = spi_clkp;
            else
                spi_cap = spi_clkn;
        end
        else begin //第二个时钟采样
            if(CPOL)
                spi_cap = spi_clkn;
            else
                spi_cap = spi_clkp;
        end
    end
    //当 spi_en 变为 0 代表一次传输完毕， 也代表数据接收完毕
    always @(posedge clk_i) begin
        if(spi_cap)//没事时钟下降沿接收数据
            rx <= {rx[6:0],spi_rx_i};//移位
        else if(spi_rx_end)//数据接收完毕， 寄存
            spi_rx_o <= rx;
        else if(!spi_en_i)//传输结束清零寄存器
            rx <= 8'd0;
    end
endmodule
