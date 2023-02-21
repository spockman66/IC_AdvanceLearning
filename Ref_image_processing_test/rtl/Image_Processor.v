//************************************************
// Author       : Jack
// Creat Date   : 2022/12/24
// Revision     : v1.0
// Target Device: Altera EP4CE10F17C8N
// Function     : 
//************************************************

module Image_Processor
(
    input   wire            clk             ,
    input   wire            rst_n           ,
    input   wire    [ 6:0]  sobel_threshold ,
    input   wire    [ 2:0]  image_disp      ,
    input   wire    [ 2:0]  image_proc      ,

    // 预处理图像数据
    input   wire            pre_frame_vsync ,  // 预图像数据列有效信号
    input   wire            pre_frame_hsync ,  // 预图像数据行有效信号
    input   wire    [15:0]  pre_frame_data  ,  // 预处理图像数据
    input   wire            pre_frame_valid ,  // 预图像数据输入使能效信号

    // 处理后的图像数据
    output  reg             post_frame_vsync,  // 处理后的图像数据列有效信号
    output  reg             post_frame_hsync,  // 处理后的图像数据行有效信号
    output  reg     [15:0]  post_frame_data ,  // 处理后的图像数据
    output  reg             post_frame_valid   // 处理后的图像数据输出使能效信号
);

// parameter define
`include "mode_para.v"

// wire define 
wire    [7:0]   img_y;
wire            frame_vsync_y;
wire            frame_hsync_y;
wire            frame_valid_y;
wire            img_bit;
wire            frame_vsync_s;
wire            frame_hsync_s;
wire            frame_valid_s;
wire    [7:0]   img_y_mean;
wire            frame_vsync_mean;
wire            frame_hsync_mean;
wire            frame_valid_mean;
wire    [7:0]   img_y_gau;
wire            frame_vsync_gau;
wire            frame_hsync_gau;
wire            frame_valid_gau;
wire    [7:0]   img_y_mid;
wire            frame_vsync_mid;
wire            frame_hsync_mid;
wire            frame_valid_mid;
wire            img_bit_e;
wire            frame_vsync_e;
wire            frame_hsync_e;
wire            frame_valid_e;
wire            img_bit_d;
wire            frame_vsync_d;
wire            frame_hsync_d;
wire            frame_valid_d;

//*******************************************
//*****************main code*****************
//*******************************************

rgb2ycbcr u_rgb2ycbcr
(
    .clk                (clk                    ),
    .rst_n              (rst_n                  ),

    .pre_frame_vsync    (pre_frame_vsync        ),
    .pre_frame_hsync    (pre_frame_hsync        ),
    .pre_frame_valid    (pre_frame_valid        ),
    .img_red            (pre_frame_data[15:11]  ),
    .img_green          (pre_frame_data[10: 5]  ),
    .img_blue           (pre_frame_data[ 4: 0]  ),

    .post_frame_vsync   (frame_vsync_y           ),
    .post_frame_hsync   (frame_hsync_y           ),
    .post_frame_valid   (frame_valid_y           ),
    .img_y              (img_y                  ),
    .img_cb             (                       ),
    .img_cr             (                       )
);

Sobel_Edge_Detector u_Sobel_Edge_Detector
(
    .clk                (clk                ),
    .rst_n              (rst_n              ),
    .sobel_threshold    (sobel_threshold    ),

    //预处理数据
    .pre_frame_vsync    (frame_vsync_y      ),  // 预处理帧有效信号
    .pre_frame_hsync    (frame_hsync_y      ),  // 预处理行有效信号
    .pre_frame_valid    (frame_valid_y      ),  // 预处理图像使能信号
    .pre_img_y          (img_y              ),  // 输入灰度数据

    //处理后的数据
    .post_frame_vsync   (frame_vsync_s      ),  // 处理后帧有效信号
    .post_frame_hsync   (frame_hsync_s      ),  // 处理后行有效信号
    .post_frame_valid   (frame_valid_s      ),  // 输出使能信号
    .post_img_bit       (img_bit            )  // 输出像素有效标志（1：Value|0：inValid）
);

// 腐蚀
Erosion u_Erosion
(
    .clk                (clk                ),
    .rst_n              (rst_n              ),

    //预处理数据
    .pre_frame_vsync    (frame_vsync_s      ),  // 预处理帧有效信号
    .pre_frame_hsync    (frame_hsync_s      ),  // 预处理行有效信号
    .pre_frame_valid    (frame_valid_s      ),  // 预处理图像使能信号
    .pre_img_bit        (img_bit            ),  // 输入二值数据

    //处理后的数据
    .post_frame_vsync   (frame_vsync_e      ),  // 处理后帧有效信号
    .post_frame_hsync   (frame_hsync_e      ),  // 处理后行有效信号
    .post_frame_valid   (frame_valid_e      ),  // 输出使能信号
    .post_img_bit       (img_bit_e          )  // 输出像素有效标志（1：Value|0：inValid）
);

// 碰撞
Dilation u_Dilation
(
    .clk                (clk                ),
    .rst_n              (rst_n              ),

    //预处理数据
    .pre_frame_vsync    (frame_vsync_e      ),  // 预处理帧有效信号
    .pre_frame_hsync    (frame_hsync_e      ),  // 预处理行有效信号
    .pre_frame_valid    (frame_valid_e      ),  // 预处理图像使能信号
    .pre_img_bit        (img_bit_e          ),  // 输入二值数据

    //处理后的数据
    .post_frame_vsync   (frame_vsync_d      ),  // 处理后帧有效信号
    .post_frame_hsync   (frame_hsync_d      ),  // 处理后行有效信号
    .post_frame_valid   (frame_valid_d      ),  // 输出使能信号
    .post_img_bit       (img_bit_d          )  // 输出像素有效标志（1：Value|0：inValid）
);

// 均值滤波
Mean_Filter u_Mean_Filter
(
    .clk                (clk                ),
    .rst_n              (rst_n              ),

    //预处理数据
    .pre_frame_vsync    (frame_vsync_y      ),
    .pre_frame_hsync    (frame_hsync_y      ),
    .pre_frame_valid    (frame_valid_y      ),
    .pre_img_y          (img_y              ),

    //处理后的数据
    .post_frame_vsync   (frame_vsync_mean   ),
    .post_frame_hsync   (frame_hsync_mean   ),
    .post_frame_valid   (frame_valid_mean   ),
    .post_img_y         (img_y_mean         )
);

// 高斯滤波
Gaussian_Filter u_Gaussian_Filter
(
    .clk                (clk                ),
    .rst_n              (rst_n              ),

    //预处理数据
    .pre_frame_vsync    (frame_vsync_y      ),
    .pre_frame_hsync    (frame_hsync_y      ),
    .pre_frame_valid    (frame_valid_y      ),
    .pre_img_y          (img_y              ),

    //处理后的数据
    .post_frame_vsync   (frame_vsync_gau    ),
    .post_frame_hsync   (frame_hsync_gau    ),
    .post_frame_valid   (frame_valid_gau    ),
    .post_img_y         (img_y_gau          )
);

// 中值滤波
Medium_Filter u_Medium_Filter
(
    .clk                (clk                ),
    .rst_n              (rst_n              ),

    //预处理数据
    .pre_frame_vsync    (frame_vsync_y      ),
    .pre_frame_hsync    (frame_hsync_y      ),
    .pre_frame_valid    (frame_valid_y      ),
    .pre_img_y          (img_y              ),

    //处理后的数据
    .post_frame_vsync   (frame_vsync_mid    ),
    .post_frame_hsync   (frame_hsync_mid    ),
    .post_frame_valid   (frame_valid_mid    ),
    .post_img_y         (img_y_mid          )
);

always@(posedge clk)
begin
    case(image_disp)
        `RGB:
            begin
            post_frame_vsync <= pre_frame_vsync;
            post_frame_hsync <= pre_frame_hsync;
            post_frame_valid <= pre_frame_valid;
            post_frame_data  <= pre_frame_data ;
            end
        `RGB_R:
            begin
            post_frame_vsync <= pre_frame_vsync;
            post_frame_hsync <= pre_frame_hsync;
            post_frame_valid <= pre_frame_valid;
            post_frame_data  <= {pre_frame_data[15:11], 11'h0};
            end
        `RGB_G:
            begin
            post_frame_vsync <= pre_frame_vsync;
            post_frame_hsync <= pre_frame_hsync;
            post_frame_valid <= pre_frame_valid;
            post_frame_data  <= {5'h0, pre_frame_data[10:5], 5'h0};
            end
        `RGB_B:
            begin
            post_frame_vsync <= pre_frame_vsync;
            post_frame_hsync <= pre_frame_hsync;
            post_frame_valid <= pre_frame_valid;
            post_frame_data  <= {11'h0, pre_frame_data[4:0]};
            end
        `YUV_Y:
            case(image_proc)
                `NOP:
                    begin
                    post_frame_vsync <= frame_vsync_y;
                    post_frame_hsync <= frame_hsync_y;
                    post_frame_valid <= frame_valid_y;
                    post_frame_data  <= {img_y[7:3], img_y[7:2], img_y[7:3]};
                    end
                `SOBEL:
                    begin
                    post_frame_vsync <= frame_vsync_s;
                    post_frame_hsync <= frame_hsync_s;
                    post_frame_valid <= frame_valid_s;
                    post_frame_data  <= {16{!img_bit}};
                    end
                `MEAN:
                    begin
                    post_frame_vsync <= frame_vsync_mean;
                    post_frame_hsync <= frame_hsync_mean;
                    post_frame_valid <= frame_valid_mean;
                    post_frame_data  <= {img_y_mean[7:3], img_y_mean[7:2], img_y_mean[7:3]};
                    end
                `MEDIUM:
                    begin
                    post_frame_vsync <= frame_vsync_mid;
                    post_frame_hsync <= frame_hsync_mid;
                    post_frame_valid <= frame_valid_mid;
                    post_frame_data  <= {img_y_mid[7:3], img_y_mid[7:2], img_y_mid[7:3]};
                    end
                `GAUSSIAN:
                    begin
                    post_frame_vsync <= frame_vsync_gau;
                    post_frame_hsync <= frame_hsync_gau;
                    post_frame_valid <= frame_valid_gau;
                    post_frame_data  <= {img_y_gau[7:3], img_y_gau[7:2], img_y_gau[7:3]};
                    end
                `EROSION:
                    begin
                    post_frame_vsync <= frame_vsync_e;
                    post_frame_hsync <= frame_hsync_e;
                    post_frame_valid <= frame_valid_e;
                    post_frame_data  <= {16{!img_bit_e}};
                    end
                `DILATION:
                    begin
                    post_frame_vsync <= frame_vsync_d;
                    post_frame_hsync <= frame_hsync_d;
                    post_frame_valid <= frame_valid_d;
                    post_frame_data  <= {16{!img_bit_d}};
                    end
                default:
                    begin
                    post_frame_vsync <= frame_vsync_y;
                    post_frame_hsync <= frame_hsync_y;
                    post_frame_valid <= frame_valid_y;
                    post_frame_data  <= {img_y[7:3], img_y[7:2], img_y[7:3]};
                    end
            endcase
        default:
            begin
            post_frame_vsync <= pre_frame_vsync;
            post_frame_hsync <= pre_frame_hsync;
            post_frame_valid <= pre_frame_valid;
            post_frame_data  <= pre_frame_data ;
            end
    endcase
end

endmodule 