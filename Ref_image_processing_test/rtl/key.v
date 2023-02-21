module key
#(
    parameter KEY_WIDTH = 3
)
(
    //global clock
    input   wire                    clk     ,
    input   wire                    rst_n   ,
    
    //key interface
    input   wire    [KEY_WIDTH-1:0] key_data,
    
    //user interface
    output  reg                     key_flag,
    output  reg     [KEY_WIDTH-1:0] key_value   //H Valid
);

wire                    key_trigger;
reg     [KEY_WIDTH-1:0] key_data_r;
reg     [19:0]          delay_cnt;
//-----------------------------------
//Register key_data for compare

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        key_data_r <= {KEY_WIDTH{1'b1}};
    else
        key_data_r <= key_data;
end


//-----------------------------------
//Delay for 20ms
localparam DELAY_TOP = 20'd1000_000;
//localparam DELAY_TOP = 20'd1000;  //Just for test

//-----------------------------------
//Key scan via counter detect.
always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        delay_cnt <= 0;
    else
        if((key_data == key_data_r) && (key_data != {KEY_WIDTH{1'b1}}))  //20ms counter jitter
            if(delay_cnt < DELAY_TOP)
                delay_cnt <= delay_cnt + 1'b1;
            else
                delay_cnt <= DELAY_TOP;
        else
            delay_cnt <= 0;
end


//-----------------------------------
//the complete of key_data capture
assign key_trigger = (delay_cnt == DELAY_TOP - 1'b1) ? 1'b1 : 1'b0;

//-----------------------------------
//output the valid key_value via key_trigger
always@(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        key_value <= {KEY_WIDTH{1'b0}};
    else if(key_trigger)
        key_value <= ~key_data_r;
    else
        key_value <= key_value;
end

//---------------------------------
//Lag 1 clock for valid read enable 
always@(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        key_flag <= 0;
    else
        key_flag <= key_trigger;
end

endmodule
