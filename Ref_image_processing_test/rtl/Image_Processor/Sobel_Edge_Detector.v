module Sobel_Edge_Detector
(
    input   wire            clk             ,  //cmos 像素时钟
    input   wire            rst_n           ,
    input   wire    [6:0]   sobel_threshold ,
    //预处理数据
    input   wire            pre_frame_vsync ,
    input   wire            pre_frame_hsync ,
    input   wire            pre_frame_valid ,
    input   wire    [7:0]   pre_img_y       ,
    //处理后的数据
    output  wire            post_frame_vsync,
    output  wire            post_frame_hsync,
    output  wire            post_frame_valid,
    output  wire            post_img_bit    
);
// reg define 
reg     [ 9:0]  Gx_temp2;  // 第三列值
reg     [ 9:0]  Gx_temp1;  // 第一列值
reg     [ 9:0]  Gx_data ;  // x方向的偏导数
reg     [ 9:0]  Gy_temp1;  // 第一行值
reg     [ 9:0]  Gy_temp2;  // 第三行值
reg     [ 9:0]  Gy_data ;  // y方向的偏导数
reg     [20:0]  Gxy_square;
reg     [ 4:0]  pre_frame_vsync_r;
reg     [ 4:0]  pre_frame_hsync_r;
reg     [ 4:0]  pre_frame_valid_r;
reg             post_img_bit_r;

// wire define 
wire           matrix_frame_vsync;
wire           matrix_frame_hsync;
wire           matrix_frame_valid;
wire    [10:0] Dim;
//输出3X3 矩阵
wire    [7:0]  matrix_p11;
wire    [7:0]  matrix_p12;
wire    [7:0]  matrix_p13;
wire    [7:0]  matrix_p21;
wire    [7:0]  matrix_p22;
wire    [7:0]  matrix_p23;
wire    [7:0]  matrix_p31;
wire    [7:0]  matrix_p32;
wire    [7:0]  matrix_p33;

assign post_frame_vsync = pre_frame_vsync_r[4];
assign post_frame_hsync = pre_frame_hsync_r[4];
assign post_frame_valid = pre_frame_valid_r[4];
assign post_img_bit     = post_frame_hsync ? post_img_bit_r : 1'b0;

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

//Sobel 算子
//      Gx               Gy                  像素点
// [ -1  0  +1 ]   [ +1  +2   +1 ]     [ P11  P12  P13 ]
// [ -2  0  +2 ]   [  0   0    0 ]     [ P21  P22  P23 ]
// [ -1  0  +1 ]   [ -1  -2   -1 ]     [ P31  P32  P33 ]

//Step 1 计算x方向的偏导数
always@(posedge clk or negedge rst_n)
begin
    if(!rst_n)begin
        Gy_temp1 <= 10'd0;
        Gy_temp2 <= 10'd0;
        Gy_data  <= 10'd0;
    end
    else begin
        Gy_temp1 <= matrix_p13 + (matrix_p23 << 1) + matrix_p33; 
        Gy_temp2 <= matrix_p11 + (matrix_p21 << 1) + matrix_p31; 
        Gy_data  <= (Gy_temp1 >= Gy_temp2) ? Gy_temp1 - Gy_temp2 : 
                    (Gy_temp2 - Gy_temp1);
    end
end

//Step 2 计算y方向的偏导数
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        Gx_temp1 <= 10'd0;
        Gx_temp2 <= 10'd0;
        Gx_data <=  10'd0;
    end
    else begin
        Gx_temp1 <= matrix_p11 + (matrix_p12 << 1) + matrix_p13; 
        Gx_temp2 <= matrix_p31 + (matrix_p32 << 1) + matrix_p33; 
        Gx_data <= (Gx_temp1 >= Gx_temp2) ? Gx_temp1 - Gx_temp2 : 
                   (Gx_temp2 - Gx_temp1);
    end
end

//Step 3 计算平方和
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        Gxy_square <= 21'd0;
    else
        Gxy_square <= Gx_data * Gx_data + Gy_data * Gy_data;
end

//Step 4 开平方（梯度向量的大小）
sqrt  u_sqrt
(
    .radical   (Gxy_square  ),
    .q         (Dim         ),
    .remainder (            )
);

//Step 5 将开平方后的数据与预设阈值比较
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        post_img_bit_r <= 1'b0; //初始值
    else if(Dim >= sobel_threshold)
        post_img_bit_r <= 1'b1; //检测到边缘1
    else
    post_img_bit_r <= 1'b0; //不是边缘 0
end

//延迟5个周期同步
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        pre_frame_vsync_r <= 0;
        pre_frame_hsync_r <= 0;
        pre_frame_valid_r <= 0;
    end
    else begin
        pre_frame_vsync_r  <=  {pre_frame_vsync_r[3:0], matrix_frame_vsync};
        pre_frame_hsync_r  <=  {pre_frame_hsync_r[3:0], matrix_frame_hsync};
        pre_frame_valid_r  <=  {pre_frame_valid_r[3:0], matrix_frame_valid};
    end
end

endmodule 