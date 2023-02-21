

module mul_raw  
    #(  
        parameter N=4,
        parameter M=4
    )
    (
        input                     clk       ,
        input                     rstn      ,

        input                     vld       ,
        input [M-1:0]             mult1     ,
        input [N-1:0]             mult2     ,

        output  [N+M-1:0]      res       ,   
        output                 res_vld
    );

`define WIDTH  N+M-1

reg [`WIDTH:0]   mult1_reg   ;
reg [N-1:0]     mult2_reg   ;
reg [`WIDTH:0]   mult_acc    ;

wire done_flag;
assign done_flag = rstn?(|mult2_reg):1'b1;

reg [1:0] state, next_state;
localparam IDLE = 2'b00;
localparam LOAD = 2'b01;
localparam SHIFT = 2'b10;
localparam DONE = 2'b11;

always @(posedge clk or negedge rstn) begin
    if(~rstn) begin
        mult1_reg <= {{N{1'b0}}, {M{1'b0}}};
        mult2_reg <= 'd0;
    end
    else begin 
        if(vld) begin
            mult1_reg <= mult1;
            mult2_reg <= mult2;
        end
        else if(next_state == SHIFT) begin
            mult1_reg <= mult1_reg << 1;
            mult2_reg <= (mult2_reg >> 1);
        end
        else if(next_state == DONE) begin
            mult1_reg <= 0;
            mult2_reg <= 0;
        end
        else begin
            mult1_reg <= mult1_reg;
            mult2_reg <= mult2_reg;
        end
    end
end

always @(posedge clk or negedge rstn) begin
    if(~rstn || next_state == IDLE)
        mult_acc <= 'd0;
    else if(vld)
        mult_acc <= mult1_reg;
    else if(next_state == SHIFT)
        mult_acc <= mult2_reg[0] ? mult_acc + mult1_reg : mult_acc; 
    else
        mult_acc <= mult_acc;
end


always @(posedge clk or negedge rstn) begin
    if(~rstn)
        state <= IDLE;
    else
        state <= next_state;
end

always @(*) begin
    case(state)
    IDLE: begin
        if(vld)
            next_state = LOAD;
        else
            next_state = IDLE;
    end
    LOAD: begin
        next_state = SHIFT;
    end
    SHIFT:begin
        if(done_flag)
            next_state = SHIFT;
        else
            next_state = DONE;
    end
    DONE: begin
        next_state = IDLE;
    end
    endcase 
end

assign res = rstn & (state==DONE) ? mult_acc : 'd0;
assign res_vld = rstn & (state==DONE) ? 1'b1 : 1'b0;



endmodule //mul_raw
