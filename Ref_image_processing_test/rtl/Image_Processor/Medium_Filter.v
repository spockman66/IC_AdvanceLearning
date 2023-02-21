//************************************************
// Author       : Jack
// Creat Date   : 2022/12/26
// Revision     : v1.0
// Target Device: Altera EP4CE10F17C8N
// Function     : 
//************************************************

module Medium_Filter
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
wire    [7:0]   row1_max, row1_mid, row1_min;
wire    [7:0]   row2_max, row2_mid, row2_min;
wire    [7:0]   row3_max, row3_mid, row3_min;
wire    [7:0]   max_min, mid_mid, min_max;
wire    [7:0]   mid;

// reg define
reg     [2:0]  pre_frame_vsync_r;
reg     [2:0]  pre_frame_hsync_r;
reg     [2:0]  pre_frame_valid_r;

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

// Step1: 计算每一行的最大值，中间值和最小值
sort3 u_sort3_row1
(
    .clk                (clk                ),
    .rst_n              (rst_n              ),
    .data1              (matrix_p11         ),
    .data2              (matrix_p12         ),
    .data3              (matrix_p13         ),
    .max                (row1_max           ),
    .mid                (row1_mid           ),
    .min                (row1_min           )
);
sort3 u_sort3_row2
(
    .clk                (clk                ),
    .rst_n              (rst_n              ),
    .data1              (matrix_p21         ),
    .data2              (matrix_p22         ),
    .data3              (matrix_p23         ),
    .max                (row2_max           ),
    .mid                (row2_mid           ),
    .min                (row2_min           )
);
sort3 u_sort3_row3
(
    .clk                (clk                ),
    .rst_n              (rst_n              ),
    .data1              (matrix_p31         ),
    .data2              (matrix_p32         ),
    .data3              (matrix_p33         ),
    .max                (row3_max           ),
    .mid                (row3_mid           ),
    .min                (row3_min           )
);

// Step2: 得出每一行最大值中的最小值，每一行中间值中的中间值，每一行最小值中的最大值
sort3 u_sort3_max
(
    .clk                (clk                ),
    .rst_n              (rst_n              ),
    .data1              (row1_max           ),
    .data2              (row2_max           ),
    .data3              (row3_max           ),
    .max                (                   ),
    .mid                (                   ),
    .min                (max_min            )
);
sort3 u_sort3_mid
(
    .clk                (clk                ),
    .rst_n              (rst_n              ),
    .data1              (row1_mid           ),
    .data2              (row2_mid           ),
    .data3              (row3_mid           ),
    .max                (                   ),
    .mid                (mid_mid            ),
    .min                (                   )
);
sort3 u_sort3_min
(
    .clk                (clk                ),
    .rst_n              (rst_n              ),
    .data1              (row1_min           ),
    .data2              (row2_min           ),
    .data3              (row3_min           ),
    .max                (min_max            ),
    .mid                (                   ),
    .min                (                   )
);

// Step3: 在上一步三个数中求中间值
sort3 u_sort3_medium
(
    .clk                (clk                ),
    .rst_n              (rst_n              ),
    .data1              (max_min            ),
    .data2              (mid_mid            ),
    .data3              (min_max            ),
    .max                (                   ),
    .mid                (mid                ),
    .min                (                   )
);

//延迟3个周期同步
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        pre_frame_vsync_r <= 0;
        pre_frame_hsync_r <= 0;
        pre_frame_valid_r <= 0;
    end
    else begin
        pre_frame_vsync_r <= {pre_frame_vsync_r[1:0], matrix_frame_vsync};
        pre_frame_hsync_r <= {pre_frame_hsync_r[1:0], matrix_frame_hsync};
        pre_frame_valid_r <= {pre_frame_valid_r[1:0], matrix_frame_valid};
    end
end

assign post_frame_vsync = pre_frame_vsync_r[2];
assign post_frame_hsync = pre_frame_hsync_r[2];
assign post_frame_valid = pre_frame_valid_r[2];
assign post_img_y       = post_frame_hsync ? mid : 8'd0;

endmodule
