module line_shift_RAM_1bit
(
    input   wire            clk             ,

    input   wire            clken           ,
    input   wire            pre_frame_hsync ,

    input   wire            shiftin         ,
    output  wire            taps0x          ,
    output  wire            taps1x    
);

//reg define
reg  [2:0]  clken_dly;
reg  [9:0]  ram_rd_addr;
reg  [9:0]  ram_rd_addr_d0;
reg  [9:0]  ram_rd_addr_d1;
reg  [9:0]  ram_rd_addr_d2;
reg  [9:0]  ram_rd_addr_d3;
reg         shiftin_d0;
reg         shiftin_d1;
reg         shiftin_d2;
reg         taps0x_d0;



//*****************************************************
//**                    main code
//*****************************************************

//在数据来到时，ram地址累加
always@(posedge clk)
begin
    if(pre_frame_hsync)
        if(clken)
            ram_rd_addr <= ram_rd_addr + 1 ;
        else
            ram_rd_addr <= ram_rd_addr ;
    else
        ram_rd_addr <= 0 ;
end

//时钟使能信号延迟三拍
always@(posedge clk) begin
    clken_dly <= { clken_dly[1:0] , clken };
end


//将ram地址延迟2拍
always@(posedge clk) begin
    ram_rd_addr_d0 <= ram_rd_addr;
    ram_rd_addr_d1 <= ram_rd_addr_d0;
end

//输入数据延迟三拍
always@(posedge clk)begin
    shiftin_d0 <= shiftin;
    shiftin_d1 <= shiftin_d0;
    shiftin_d2 <= shiftin_d1;
end

//用于存储前一行图像的RAM
d_s_ram_1024x1  u_d_s_ram_1024x1_1(
    .data      (shiftin_d2),     //在延迟的第三个时钟周期，当前行的数据写入RAM0
    .clock     (clk),
    .rdaddress (ram_rd_addr),
    .wraddress (ram_rd_addr_d1),
    .wren      (clken_dly[2]),
    .q         (taps0x)          //延迟一个时钟周期，输出RAM0中前一行图像的数据
);  

//寄存一次前一行图像的数据
always@(posedge clk)
begin
    taps0x_d0 <= taps0x;
end

//用于存储前前一行图像的RAM
d_s_ram_1024x1  u_d_s_ram_1024x1_2(
    .data      (taps0x_d0),     //在延迟的第二个时钟周期，将前一行图像的数据写入RAM1
    .clock     (clk     ),
    .wraddress (ram_rd_addr_d0),
    .wren      (clken_dly[1]),    
    
    .rdaddress (ram_rd_addr),
    .q         (taps1x)           //延迟一个时钟周期，输出RAM1中前前一行图像的数据
);

endmodule 