//************************************************
// Author       : Jack
// Creat Date   : 2022/12/24
// Revision     : v1.0
// Target Device: Altera EP4CE10F17C8N
// Function     : 实现rgb565和灰度显示，以及中值滤波和sobel边缘检测
//************************************************

module Image_Processing_Test
(
    input   wire            sys_clk     ,  // 系统时钟
    input   wire            sys_rst_n   ,  // 系统复位，低电平有效
    // 摄像头接口
    input   wire            cam_pclk    ,  // cmos 数据像素时钟
    input   wire            cam_vsync   ,  // cmos 场同步信号
    input   wire            cam_href    ,  // cmos 行同步信号
    input   wire    [ 7:0]  cam_data    ,  // cmos 数据
    output  wire            cam_rst_n   ,  // cmos 复位信号，低电平有效
    output  wire            cam_pwdn    ,  // cmos 电源休眠模式选择信号
    output  wire            cam_scl     ,  // cmos SCCB_SCL线
    inout   wire            cam_sda     ,  // cmos SCCB_SDA线
    // SDRAM接口
    output  wire            sdram_clk   ,  // SDRAM 时钟
    output  wire            sdram_cke   ,  // SDRAM 时钟有效
    output  wire            sdram_cs_n  ,  // SDRAM 片选
    output  wire            sdram_ras_n ,  // SDRAM 行有效
    output  wire            sdram_cas_n ,  // SDRAM 列有效
    output  wire            sdram_we_n  ,  // SDRAM 写有效
    output  wire    [ 1:0]  sdram_ba    ,  // SDRAM Bank地址
    output  wire    [ 1:0]  sdram_dqm   ,  // SDRAM 数据掩码
    output  wire    [12:0]  sdram_addr  ,  // SDRAM 地址
    inout   wire    [15:0]  sdram_data  ,  // SDRAM 数据
    // VGA接口
    output  wire            vga_hs      ,  // 行同步信号
    output  wire            vga_vs      ,  // 场同步信号
    output  wire    [15:0]  vga_data    ,  // 红绿蓝三原色输出
    // 按键接口
    input   wire    [ 2:0]  key         
);

//parameter define
parameter SLAVE_ADDR    = 7'h3c         ;  // OV5640的器件地址7'h3c
parameter BIT_CTRL      = 1'b1          ;  // OV5640的字节地址为16位（0:8位|1:16位）
parameter CLK_FREQ      = 26'd25_000_000;  // sccb_dri模块的驱动时钟频率
parameter SCCB_FREQ     = 18'd250_000   ;  // sccb的SCL时钟频率，不超过400KHz
parameter CMOS_H_PIXEL  = 24'd640       ;  // CMOS水平方向像素个数，用于设置SDRAM缓存大小
parameter CMOS_V_PIXEL  = 24'd480       ;  // CMOS垂直方向像素个数，用于设置SDRAM缓存大小
parameter SOBEL_THRESHOLD = 20;

//wire define
wire                    clk_100m        ;  // 100MHz时钟，SDRAM操作时钟
wire                    clk_100m_shift  ;  // 100MHz时钟，SDRAM相位偏移时钟
wire                    clk_25m         ;  // 25MHz时钟，提供给IIC驱动时钟和vga驱动时钟
wire                    locked          ;  // pll稳定信号
wire                    rst_n           ;

wire                    sccb_exec       ;  //sccb触发执行信号
wire    [23:0]          sccb_data       ;  //sccb要配置的地址与数据（高8位地址,低8位数据)0
wire                    cam_init_done   ;  //摄像头初始化完成
wire                    sccb_done       ;  //sccb寄存器配置完成信号
wire                    sccb_dri_clk    ;  //sccb操作时钟

wire                    wr_en           ;  //sdram_ctrl模块写使能
wire    [15:0]          wr_data         ;  //sdram_ctrl模块写数据
wire                    rd_en           ;  //sdram_ctrl模块读使能
wire    [15:0]          rd_data         ;  //sdram_ctrl模块读数据
wire                    sdram_init_done ;  //SDRAM初始化完成
wire                    sys_init_done   ;  //系统初始化完成（sdram初始化+摄像头初始化）
// 采集到的摄像头数据
wire    [15:0]          cmos_frame_data ;
wire                    cmos_frame_vsync;
wire                    cmos_frame_hsync;
wire                    cmos_frame_valid;
// 按键值和有效信号
wire                    key_flag        ;
wire    [ 2:0]          key_value       ;
// 模式
wire    [ 6:0]          sobel_threshold ;
wire    [ 2:0]          image_disp      ;
wire    [ 2:0]          image_proc      ;
// 摄像头
wire    [10:0]          pix_x           ;
wire    [10:0]          pix_y           ;
wire    [15:0]          pix_data        ;


//*******************************************
//*****************main code*****************
//*******************************************

assign rst_n = sys_rst_n & locked;
//系统初始化完成：SDRAM和摄像头都初始化完成
//避免了在SDRAM初始化过程中向里面写入数据
assign sys_init_done = sdram_init_done & cam_init_done;
//不对摄像头硬件复位,固定高电平
assign cam_rst_n = 1'b1;
//电源休眠模式选择 0：正常模式 1：电源休眠模式
assign cam_pwdn = 1'b0;

key u_key
(
    .clk                (sys_clk        ),
    .rst_n              (sys_rst_n      ),
    .key_data           (key            ),
    .key_flag           (key_flag       ),
    .key_value          (key_value      )
);


//锁相环
pll_clk u_pll_clk
(
    .areset             (~sys_rst_n     ),
    .inclk0             (sys_clk        ),
    .c0                 (clk_100m       ),
    .c1                 (clk_100m_shift ),
    .c2                 (clk_25m        ),
    .locked             (locked         )
);

//sccb配置模块
sccb_ov5640_rgb565_cfg 
#(
    .CMOS_H_PIXEL       (CMOS_H_PIXEL   ),
    .CMOS_V_PIXEL       (CMOS_V_PIXEL   )
)   
u_sccb_cfg
(   
    .clk                (sccb_dri_clk   ),
    .rst_n              (rst_n          ),
    .sccb_done          (sccb_done      ),
    .sccb_exec          (sccb_exec      ),
    .sccb_data          (sccb_data      ),
    .init_done          (cam_init_done  )
);    

sccb_dri 
#(
    .SLAVE_ADDR         (SLAVE_ADDR     ),  // 从器件的地址
    .CLK_FREQ           (CLK_FREQ       ),  // SCCB模块的时钟频率
    .SCCB_FREQ          (SCCB_FREQ      )   // SCCB的驱动时钟频率
)   
u_sccb_dri
(   
    .clk                (clk_25m        ),  // 输入时钟
    .rst_n              (rst_n          ),  // 复位信号   

    .sccb_exec          (sccb_exec      ),  // 开始执行SCCB传输信号
    .bit_ctrl           (BIT_CTRL       ),  // 地址长度选择（0：8bit|1：16bit）
    .sccb_addr          (sccb_data[23:8]),  // 读写地址   
    .sccb_data_w        (sccb_data[7:0] ),  // 写入数据  
    .sccb_done          (sccb_done      ),  // SCCB一次操作完成信号   
    .scl                (cam_scl        ),  // SCCB的SCL时钟信号   
    .sda                (cam_sda        ),  // SCCB的SDA数据信号   

    .dri_clk            (sccb_dri_clk   )   // 驱动SCCB操作的驱动时钟
);

//CMOS图像数据采集模块
cmos_capture_data u_cmos_capture_data
(
    .rst_n              (rst_n & sys_init_done),  // 系统初始化完成之后再开始采集数据 
        
    .cam_pclk           (cam_pclk           ),
    .cam_vsync          (cam_vsync          ),
    .cam_href           (cam_href           ),
    .cam_data           (cam_data           ),
        
        
    .cmos_frame_vsync   (cmos_frame_vsync   ),
    .cmos_frame_href    (cmos_frame_hsync   ),
    .cmos_frame_valid   (cmos_frame_valid   ),  // 数据有效使能信号
    .cmos_frame_data    (cmos_frame_data    )   // 有效数据 
);

mode_selector u_mode_selector
(
    .clk                (sys_clk            ),
    .rst_n              (sys_rst_n          ),
    .key_flag           (key_flag           ),
    .key_value          (key_value          ),
    .sobel_threshold    (sobel_threshold    ),
    .image_disp         (image_disp         ),
    .image_proc         (image_proc         )
);

Image_Processor u_Image_Processor
(
    .clk                (cam_pclk           ),
    .rst_n              (rst_n              ),
    .sobel_threshold    (sobel_threshold    ),
    .image_disp         (image_disp         ),
    .image_proc         (image_proc         ),

    .pre_frame_vsync    (cmos_frame_vsync   ),
    .pre_frame_hsync    (cmos_frame_hsync   ),
    .pre_frame_valid    (cmos_frame_valid   ),
    .pre_frame_data     (cmos_frame_data    ),
    
    .post_frame_vsync   (                   ),
    .post_frame_hsync   (                   ),
    .post_frame_valid   (wr_en              ),
    .post_frame_data    (wr_data            )
);

//SDRAM 控制器顶层模块,封装成FIFO接口
//SDRAM 控制器地址组成: {bank_addr[1:0],row_addr[12:0],col_addr[8:0]}
SDRAM_Top u_SDRAM_Top
(
    .ref_clk            (clk_100m       ),  // SDRAM控制器参考时钟
    .out_clk            (clk_100m_shift ),  // 用于输出的相位偏移时钟
    .rst_n              (rst_n          ),  // 系统复位

    //用户写端口
    .wr_clk             (cam_pclk       ),  // 写端口FIFO：写时钟
    .wr_en              (wr_en          ),  // 写端口FIFO：写使能
    .wr_data            (wr_data        ),  // 写端口FIFO：写数据
    .wr_min_addr        (24'd0          ),  // 写SDRAM的起始地址
    .wr_max_addr        (CMOS_H_PIXEL*CMOS_V_PIXEL),  // 写SDRAM的结束地址
    .wr_len             (10'd512        ),  // 写SDRAM时的数据突发长度
    .wr_load            (~rst_n         ),  // 写端口复位: 复位写地址,清空写FIFO

    //用户读端口
    .rd_clk             (clk_25m        ),  // 读端口FIFO：读时钟
    .rd_en              (rd_en          ),  // 读端口FIFO：读使能
    .rd_data            (rd_data        ),  // 读端口FIFO：读数据
    .rd_min_addr        (24'd0          ),  // 读SDRAM的起始地址
    .rd_max_addr        (CMOS_H_PIXEL*CMOS_V_PIXEL),  // 读SDRAM的结束地址
    .rd_len             (10'd512        ),  // 从SDRAM中读数据时的突发长度
    .rd_load            (~rst_n         ),  // 读端口复位：复位读地址,清空读FIFO

    //用户控制端口
    .sdram_read_valid   (1'b1           ),  // SDRAM 读使能
    .sdram_pingpang_en  (1'b1           ),  // SDRAM 乒乓操作使能
    .sdram_init_done    (sdram_init_done),  // SDRAM 初始化完成标志

    //SDRAM 芯片接口
    .sdram_clk          (sdram_clk      ),  // SDRAM 芯片时钟
    .sdram_cke          (sdram_cke      ),  // SDRAM 时钟有效
    .sdram_cs_n         (sdram_cs_n     ),  // SDRAM 片选
    .sdram_ras_n        (sdram_ras_n    ),  // SDRAM 行有效
    .sdram_cas_n        (sdram_cas_n    ),  // SDRAM 列有效
    .sdram_we_n         (sdram_we_n     ),  // SDRAM 写有效
    .sdram_ba           (sdram_ba       ),  // SDRAM Bank地址
    .sdram_addr         (sdram_addr     ),  // SDRAM 行/列地址
    .sdram_data         (sdram_data     ),  // SDRAM 数据
    .sdram_dqm          (sdram_dqm      )   // SDRAM 数据掩码
);  

// VGA驱动模块
vga_dri u_vga_dri
(
    .clk                (clk_25m        ),
    .rst_n              (rst_n          ),

    .vga_hs             (vga_hs         ),
    .vga_vs             (vga_vs         ),
    .vga_data           (vga_data       ),

    .pix_data           (pix_data       ),
    .data_req           (rd_en          ),  // 请求像素点颜色数据输入
    .pix_x              (pix_x          ),
    .pix_y              (pix_y          )
);

// VGA显示模块
vga_disp
(
    .clk                (clk_25m        ),
    .rst_n              (rst_n          ),
    
    .pix_x              (pix_x          ),
    .pix_y              (pix_y          ),
    .pix_data           (pix_data       ),
    
    .fram_data          (rd_data        ),
    .image_disp         (image_disp     ),
    .image_proc         (image_proc     ),
    .sobel_th           (sobel_threshold)
);


endmodule 