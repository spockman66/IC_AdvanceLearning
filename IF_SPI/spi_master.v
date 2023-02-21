module spi_master #(
    parameter CPOL = 0,
    parameter CPHA = 0
)
(
    input clk           ,
    input rstn          ,

    output SCLK         ,
    input MISO          ,
    output MOSI         ,
    output [1:0] CS     ,

    input [7:0] tx_data ,
    input tx_en         ,

    output  spi_busy

);

reg clk_en1, clk_en2            ;
reg [9:0] clk_cnt = 10'd0       ;

reg spi_clk;


parameter [9:0] CLK_DIV = 10'd500;//分频 假设（50Mhz/100K/ - 1'b1=499

always@(posedge clk or negedge rstn) begin
    if(~rstn)
        clk_en1 <= 1'b0;
    else if(clk_cnt == CLK_DIV-1)
        clk_en1 <= 1'b1;
    else
        clk_en1 <= 1'b0;
end

always@(posedge clk or negedge rstn) begin
    if(~rstn)
        clk_en2 <= 1'b0;
    else if(clk_cnt == CLK_DIV/2-1)
        clk_en2 <= 1'b1;
    else
        clk_en2 <= 1'b0;
end

always@(posedge clk or negedge rstn) begin
    if(~rstn || clk_cnt == CLK_DIV)
        clk_cnt <= 'd0;
    else
        clk_cnt <= clk_cnt + 1'b1;
end

always@(posedge clk or negedge rstn) begin
    if(~rstn || tx_en)
        spi_clk <= 1'b0;
    else if(clk_en2)            // clk_en2: n
        spi_clk <= 1'b0;
    else if(clk_en1)            // clk_en1: p
        spi_clk <= 1'b1;          
    else
        spi_clk <= spi_clk;
end

reg spi_clk_d;
wire spi_done, spi_load;
reg [7:0] spi_data_reg;
reg [3:0] tx_cnt;
reg [1:0] state, next_state;

parameter IDLE  = 2'b00     ;
parameter START = 2'b01     ;
parameter TRANS = 2'b11     ;
parameter DONE  = 2'b10     ;


assign SCLK = (state == TRANS)? (CPOL? ~spi_clk : spi_clk):1'b0;
assign MOSI = (state == TRANS)? spi_data_reg[7]:1'b0;

assign spi_load = CPHA ? clk_en1 : clk_en2;     // load time control

assign spi_busy = (state == TRANS) ? 1'b1 : 1'b0;
assign CS = 2'b00;
assign spi_done = (state == DONE) ? 1'b1 : 1'b0;

always @(posedge clk or negedge rstn) begin
    if(~rstn)
        spi_clk_d <= 1'b1;
    else
        spi_clk_d <= spi_clk;
end

always @(posedge clk or negedge rstn) begin
    if(~rstn)
        state <= IDLE;
    else
        state <= next_state;
end

always @(*) begin
    next_state = IDLE;
    case (state)
        IDLE: begin
            if(tx_en)
                if(~CPHA)
                    next_state = START;
                else
                    next_state = TRANS;
            else
                next_state = IDLE;
        end

        START: begin
            if(spi_load)
                next_state = TRANS;
            else
                next_state = START;
        end

        TRANS: begin
            if(tx_cnt == 'd8 && spi_load)
                next_state = DONE;
            else
                next_state = TRANS;
        end

        DONE: begin
            if(spi_load)
                next_state = IDLE;
            else
                next_state = DONE;
        end

        default: begin
            next_state = IDLE;
        end
            
    endcase
end



/* 待传输数据的寄存器 */
always @(posedge clk or negedge rstn) begin
    if(~rstn || spi_done)
        spi_data_reg <= 'd0;
    else if(tx_en)
        spi_data_reg <= tx_data;
    else if(state == TRANS && spi_load)
        spi_data_reg[7:0] <= {spi_data_reg[6:0],1'b0};
    else
        spi_data_reg <= spi_data_reg;
end


always @(posedge spi_clk or negedge rstn) begin
    if(~rstn || tx_cnt == 'd8)
        tx_cnt <= 'd0;
    else if(state == TRANS)
        tx_cnt <= tx_cnt + 1'b1;
    else
        tx_cnt <= tx_cnt;
end



endmodule