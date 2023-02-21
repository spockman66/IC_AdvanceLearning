//************************************************
// Author       : Jack
// Creat Date   : 2022/12/26
// Revision     : v1.0
// Target Device: Altera EP4CE10F17C8N
// Function     : 
//************************************************

module Gaussian_Filter
(
    input   wire            clk             ,
    input   wire            rst_n           ,
    //预处理数据
    input   wire            pre_frame_vsync ,
    input   wire            pre_frame_hsync ,
    input   wire            pre_frame_valid ,
    input   wire    [7:0]   pre_img_y       ,
    //处理后的数据
    output  wire            post_frame_vsync,
    output  wire            post_frame_hsync,
    output  wire            post_frame_valid,
    output  wire    [7:0]   post_img_y      
);

// wire define
wire            matrix_frame_vsync;
wire            matrix_frame_hsync;
wire            matrix_frame_valid;
//输出3X3 矩阵
wire    [7:0]   matrix_p11; 
wire    [7:0]   matrix_p12; 
wire    [7:0]   matrix_p13; 
wire    [7:0]   matrix_p21; 
wire    [7:0]   matrix_p22; 
wire    [7:0]   matrix_p23;
wire    [7:0]   matrix_p31; 
wire    [7:0]   matrix_p32; 
wire    [7:0]   matrix_p33;

// reg define
reg     [10:0]  row1, row2, row3;
reg     [11:0]  sum;
reg     [1:0]   pre_frame_vsync_r;
reg     [1:0]   pre_frame_hsync_r;
reg     [1:0]   pre_frame_valid_r;

//*******************************************
//*****************main code*****************
//*******************************************
//3x3矩阵
Matrix_Generate_3X3_8Bit u_Matrix_Generate_3X3_8Bit
(
    .clk                (clk                ),
    .rst_n              (rst_n              ),
    //预处理数据
    .pre_frame_vsync    (pre_frame_vsync    ),
    .pre_frame_hsync    (pre_frame_hsync    ),
    .pre_frame_valid    (pre_frame_valid    ),
    .pre_img_y          (pre_img_y          ),
    
    //处理后的数据
    .matrix_frame_vsync (matrix_frame_vsync ),
    .matrix_frame_hsync (matrix_frame_hsync ),
    .matrix_frame_valid (matrix_frame_valid ),
    .matrix_p11         (matrix_p11         ),
    .matrix_p12         (matrix_p12         ),
    .matrix_p13         (matrix_p13         ), //输出 3X3 矩阵
    .matrix_p21         (matrix_p21         ),
    .matrix_p22         (matrix_p22         ),
    .matrix_p23         (matrix_p23         ),
    .matrix_p31         (matrix_p31         ),
    .matrix_p32         (matrix_p32         ),
    .matrix_p33         (matrix_p33         )
);

// Step1: 计算每一行的和
always@(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        begin
        row1 <= 9'd0;
        row2 <= 9'd0;
        row3 <= 9'd0;
        end
    else
        begin
        row1 <= matrix_p11 * 1 + matrix_p12 * 2 + matrix_p13 * 1;
        row2 <= matrix_p21 * 2 + matrix_p22 * 4 + matrix_p23 * 2;
        row3 <= matrix_p31 * 1 + matrix_p32 * 2 + matrix_p33 * 1;
        end
end

// Step2: 将每一行的和相加
always@(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        sum <= 11'd0;
    else
        sum <= row1 + row2 + row3;
end

//延迟2个周期同步
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        pre_frame_vsync_r <= 0;
        pre_frame_hsync_r <= 0;
        pre_frame_valid_r <= 0;
    end
    else begin
        pre_frame_vsync_r <= {pre_frame_vsync_r[0], matrix_frame_vsync};
        pre_frame_hsync_r <= {pre_frame_hsync_r[0], matrix_frame_hsync};
        pre_frame_valid_r <= {pre_frame_valid_r[0], matrix_frame_valid};
    end
end

assign post_frame_vsync = pre_frame_vsync_r[1];
assign post_frame_hsync = pre_frame_hsync_r[1];
assign post_frame_valid = pre_frame_valid_r[1];
assign post_img_y       = post_frame_hsync ? sum[11:4] : 8'd0;

endmodule
