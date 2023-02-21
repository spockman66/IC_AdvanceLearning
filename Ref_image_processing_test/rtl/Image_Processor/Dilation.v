//************************************************
// Author       : Jack
// Creat Date   : 2022/12/26
// Revision     : v1.0
// Target Device: Altera EP4CE10F17C8N
// Function     : 
//************************************************

module Dilation
(
    input   wire            clk             ,
    input   wire            rst_n           ,
    //预处理数据
    input   wire            pre_frame_vsync ,
    input   wire            pre_frame_hsync ,
    input   wire            pre_frame_valid ,
    input   wire            pre_img_bit     ,
    //处理后的数据
    output  wire            post_frame_vsync,
    output  wire            post_frame_hsync,
    output  wire            post_frame_valid,
    output  wire            post_img_bit    
);

// wire define
wire            matrix_p11;
wire            matrix_p12;
wire            matrix_p13;
wire            matrix_p21;
wire            matrix_p22;
wire            matrix_p23;
wire            matrix_p31;
wire            matrix_p32;
wire            matrix_p33;

// reg define
reg             row1, row2, row3;
reg             dilation;
reg     [1:0]   pre_frame_vsync_r;
reg     [1:0]   pre_frame_hsync_r;
reg     [1:0]   pre_frame_valid_r;

//*******************************************
//*****************main code*****************
//*******************************************
//3x3矩阵
Matrix_Generate_3X3_1Bit u_Matrix_Generate_3X3_1Bit
(
    .clk                (clk                ),
    .rst_n              (rst_n              ),
    //预处理数据
    .pre_frame_vsync    (pre_frame_vsync    ),
    .pre_frame_hsync    (pre_frame_hsync    ),
    .pre_frame_valid    (pre_frame_valid    ),
    .pre_img_bit        (pre_img_bit        ),
    
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

// Step1: 每一行的数据互相或
always@(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        begin
        row1 <= 1'b0;
        row2 <= 1'b0;
        row3 <= 1'b0;
        end
    else
        begin
        row1 <= matrix_p11 | matrix_p12 | matrix_p13;
        row2 <= matrix_p21 | matrix_p22 | matrix_p23;
        row3 <= matrix_p31 | matrix_p32 | matrix_p33;
        end
end

// Step2: 每一行的结果相与
always@(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        dilation <= 1'b0;
    else
        dilation <= row1 | row2 | row3;
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
assign post_img_bit     = post_frame_hsync ? dilation : 1'b0;

endmodule
