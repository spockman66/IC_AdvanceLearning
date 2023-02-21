module master_spi_tb;
    reg clk_i;
    reg rstn_i;
    wire spi_clk_o;
    wire spi_miso_i;
    wire spi_mosi_o;
    wire [7:0]spi_rx;
    assign spi_miso_i = spi_mosi_o;
    master_spi master_spi_inst(
                   .clk_i(clk_i),
                   .rstn_i(rstn_i),
                   .spi_clk_o(spi_clk_o),
                   .spi_miso_i(spi_miso_i),
                   .spi_mosi_o(spi_mosi_o),
                   .spi_rx(spi_rx)//rtl simulation
               );
    initial begin
        clk_i = 1'b0;
        rstn_i = 1'b0;
        #100;
        rstn_i = 1'b1;
    end
    always begin
        #10 clk_i = ~clk_i;
    end
endmodule
