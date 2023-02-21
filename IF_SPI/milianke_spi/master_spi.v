module master_spi(
        input clk_i,
        input rstn_i,
        output spi_clk_o,
        input spi_miso_i,
        output spi_mosi_o,
        output [7:0] spi_rx//rtl simulation
    );
    wire spi_en;
    wire spi_rx_done;

    master_spi_rx#
        ( .CPOL(1'b0),
          .CPHA(1'b0)
        ) master_spi_rx_inst
        ( .clk_i(clk_i),
          .spi_rx_i(spi_miso_i),
          .spi_clk_i(spi_clk_o),
          .spi_en_i(spi_en),
          .spi_rx_o(spi_rx),
          .spi_rx_done(spi_rx_done)
        );
    wire spi_busy;
    reg [7:0]spi_tx_data;
    reg [1:0]M_S;
    reg spi_tx_en;
    master_spi_tx#
        ( .CPOL(1'b0),
          .CPHA(1'b1)
        ) master_spi_tx_inst(
            .clk_i(clk_i),
            .spi_tx_o(spi_mosi_o),
            .spi_tx_en_i(spi_tx_en),//发送发送使能信号
            .spi_tx_data_i(spi_tx_data),//待发送数据
            
            .spi_clk_o(spi_clk_o),//SPI 时钟输出
            .spi_en_o(spi_en),//SPI 传输使能
            .spi_busy_o(spi_busy)//SPI 正在传输
        );
    always @(posedge clk_i) begin
        if(!rstn_i) begin
            M_S <= 2'd0;
            spi_tx_en <= 2'd0;
            spi_tx_data <= 8'd0;
        end
        else begin
            case(M_S)
                0: begin
                    if(!spi_busy) begin
                        spi_tx_en <= 1'b1;
                        spi_tx_data <= spi_tx_data + 1'b1;
                        M_S <= 2'd1;
                    end
                end
                1: begin
                    spi_tx_en <= 1'b0;
                    if(spi_busy)
                        M_S <= 2'd2;
                end
                2: begin
                    if(!spi_busy)
                        M_S <= 2'd3;
                end
                3: begin
                    M_S <= 2'd0;
                end
            endcase
        end
    end
endmodule
