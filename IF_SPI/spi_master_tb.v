module spi_master_tb;


    reg clk = 1'b0;
    reg rstn = 1'b1;

    reg [7:0] tx_data = 'd0;
    reg tx_en;
    
    wire spi_mosi;
    wire spi_miso;
    wire spi_clk;
    wire spi_cs;
    wire spi_busy;

    initial begin
        clk = 1'b0;
        rstn = 1'b0;
        #100;
        rstn = 1'b1;
    end
    always begin
        #10 clk = ~clk;
    end

    initial
        tx_en = 1'b0;

    initial begin
        #10000;
        spi_trans(1);
        #200_000;
        spi_trans('b1000_0001);

    end


    spi_master #(
                   .CPOL(0),
                   .CPHA(1)
               ) u_spi
               (
                   .clk            (clk            ),
                   .rstn           (rstn           ),
                   .SCLK           (spi_clk        ),
                   .MISO           (spi_miso       ),
                   .MOSI           (spi_mosi       ),
                   .CS             (spi_cs         ),
                   .tx_data        (tx_data        ),
                   .tx_en          (tx_en          ),
                   .spi_busy       (spi_busy       )

               );


task spi_trans;
    input [7:0] data;
    begin
        tx_en = 1'b1;
        tx_data = data;
        # 20
        tx_en = 1'b0;
    end
endtask //automatic



endmodule
