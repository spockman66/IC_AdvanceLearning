module Matrix_Generate_3X3_8Bit
(
    input   wire            clk                 ,
    input   wire            rst_n               ,

    input   wire            pre_frame_vsync     ,
    input   wire            pre_frame_hsync     ,
    input   wire            pre_frame_valid     ,
    input   wire    [7:0]   pre_img_y           ,

    output  wire            matrix_frame_vsync  ,
    output  wire            matrix_frame_hsync   ,
    output  wire            matrix_frame_valid  ,
    output  reg     [7:0]   matrix_p11          ,
    output  reg     [7:0]   matrix_p12          ,
    output  reg     [7:0]   matrix_p13          ,
    output  reg     [7:0]   matrix_p21          ,
    output  reg     [7:0]   matrix_p22          ,
    output  reg     [7:0]   matrix_p23          ,
    output  reg     [7:0]   matrix_p31          ,
    output  reg     [7:0]   matrix_p32          ,
    output  reg     [7:0]   matrix_p33
);

//wire define
wire    [7:0]   row1_data;  
wire    [7:0]   row2_data;  
wire            read_frame_hsync;
wire            read_frame_valid;

//reg define
reg     [7:0]   row3_data;  
reg     [1:0]   pre_frame_vsync_r;
reg     [1:0]   pre_frame_hsync_r;
reg     [1:0]   pre_frame_valid_r;

//*****************************************************
//**                    main code
//*****************************************************

assign read_frame_hsync   = pre_frame_hsync_r[0];
assign read_frame_valid   = pre_frame_valid_r[0];
assign matrix_frame_vsync = pre_frame_vsync_r[1];
assign matrix_frame_hsync = pre_frame_hsync_r[1];
assign matrix_frame_valid = pre_frame_valid_r[1];

//当前数据放在第3行
always@(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        row3_data <= 0;
    else
        begin
        if(pre_frame_valid)
            row3_data <= pre_img_y;
        else
            row3_data <= row3_data;
        end
end

//用于存储列数据的RAM
line_shift_RAM_8bit  u_line_shift_RAM_8bit
(
    .clk                (clk                ),
    .clken              (pre_frame_valid    ),
    .pre_frame_hsync    (pre_frame_hsync   ),
    
    .shiftin            (pre_img_y          ),   
    .taps0x             (row2_data          ),   
    .taps1x             (row1_data          )    
);

//将同步信号延迟两拍，用于同步化处理
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        begin
        pre_frame_vsync_r <= 0;
        pre_frame_hsync_r <= 0;
        pre_frame_valid_r <= 0;
        end
    else
        begin
        pre_frame_vsync_r <= {pre_frame_vsync_r[0], pre_frame_vsync};
        pre_frame_hsync_r <= {pre_frame_hsync_r[0], pre_frame_hsync};
        pre_frame_valid_r <= {pre_frame_valid_r[0], pre_frame_valid};
        end
end

//在同步处理后的控制信号下，输出图像矩阵
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        begin
        {matrix_p11, matrix_p12, matrix_p13} <= 24'h0;
        {matrix_p21, matrix_p22, matrix_p23} <= 24'h0;
        {matrix_p31, matrix_p32, matrix_p33} <= 24'h0;
        end
    else if(read_frame_hsync)
        begin
        if(read_frame_valid)
            begin
            {matrix_p11, matrix_p12, matrix_p13} <= {matrix_p12, matrix_p13, row1_data};
            {matrix_p21, matrix_p22, matrix_p23} <= {matrix_p22, matrix_p23, row2_data};
            {matrix_p31, matrix_p32, matrix_p33} <= {matrix_p32, matrix_p33, row3_data};
            end
        else
            begin
            {matrix_p11, matrix_p12, matrix_p13} <= {matrix_p11, matrix_p12, matrix_p13};
            {matrix_p21, matrix_p22, matrix_p23} <= {matrix_p21, matrix_p22, matrix_p23};
            {matrix_p31, matrix_p32, matrix_p33} <= {matrix_p31, matrix_p32, matrix_p33};
            end
        end
    else
        begin
        {matrix_p11, matrix_p12, matrix_p13} <= 24'h0;
        {matrix_p21, matrix_p22, matrix_p23} <= 24'h0;
        {matrix_p31, matrix_p32, matrix_p33} <= 24'h0;
        end
end

endmodule 