module master_spi_tx#
    (
        parameter CPOL = 1'b0,
        parameter CPHA = 1'b0
    ) (
        input clk_i,
        output spi_tx_o,//mosi
        output spi_clk_o,//SPI 时钟输出 SCK
        input spi_tx_en_i,//发送发送使能信号
        input [7:0] spi_tx_data_i,//待发送数据
        output spi_en_o,//SPI 传输使能
        output spi_busy_o//SPI 正在传输
    );

    //SPI 时钟分频单元
    parameter [9:0] SPI_DIV = 10'd499;//分频 假设（50Mhz/100K/ - 1'b1=499
    parameter [9:0] SPI_DIV1 = SPI_DIV/2;
    parameter PSET = CPHA ? 1'b1 : 1'b0;
    reg [9:0] clk_div = 10'd0;
    reg spi_en = 1'b0;
    always@(posedge clk_i) begin
        if((clk_div < SPI_DIV) && spi_en)
            clk_div <= clk_div + 1'b1;
        else
            clk_div <= 10'd0;
    end
    wire clk_end;
    //产生 SPI 时钟
    wire clk_en1 = (clk_div == SPI_DIV1)&&(!clk_end);//n
    wire clk_en2 = (clk_div == SPI_DIV);//p
    reg spi_clk = 1'b0;

    always@(posedge clk_i) begin
        if(spi_tx_en_i)
            spi_clk <= 1'b0;
        else if(clk_en2)
            spi_clk <= 1'b0;
        else if(clk_en1)
            spi_clk <= 1'b1;
    end
    wire spi_strobe = CPHA ? clk_en1 : clk_en2 ;

    //SPI 发送数据
    reg [3:0] tx_cnt = 4'd0;
    reg [7:0] spi_tx_data_r=8'd0;
    assign spi_tx_o = spi_tx_data_r[7];
    assign clk_end = (clk_div == SPI_DIV1)&&(tx_cnt==4'd8);
    reg pcnt = 1'b0;
    always@(posedge clk_i) begin
        //首先当发送使能有效， 寄存数据
        if(spi_tx_en_i) begin
            spi_en <= 1'b1;
            spi_tx_data_r <= spi_tx_data_i;
        end
        else if(!spi_en) begin//当 bps_start_en 为 0 让状态机处于停止状态
            spi_tx_data_r <= 8'b1111_1111;
            tx_cnt <= 4'd0;
            pcnt <= 1'd0;
        end
        // 通过移位发送数据
        if(clk_end) begin
            tx_cnt <= 4'd0;
            spi_en <= 1'b0;
        end
        else begin
            if(clk_en1&&spi_en)
                tx_cnt <= tx_cnt + 1'b1;
            if(spi_strobe) begin
                if(pcnt < PSET )
                    pcnt <= 1'b1;
                else
                    spi_tx_data_r[7:0] <= {spi_tx_data_r[6:0],spi_tx_data_r[7]};
            end
        end
    end
    assign spi_busy_o = spi_en;
    assign spi_en_o = spi_en;
    assign spi_clk_o = (CPOL == 1'b1) ? ~spi_clk : spi_clk;

endmodule
