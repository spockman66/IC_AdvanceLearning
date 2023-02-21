module vga_dri
(
    input   wire            clk     ,
    input   wire            rst_n   ,
    
    // VGA接口
    output  wire            vga_hs  ,
    output  wire            vga_vs  ,
    output  wire    [15:0]  vga_data,
    
    // 像素点
    input   wire    [15:0]  pix_data,
    output  wire            data_req,
    output  wire    [10:0]  pix_x   ,
    output  wire    [10:0]  pix_y   
);

// 640*480@60_25MHz
parameter H_SYNC    = 10'd96    ;
parameter H_BACK    = 10'd48    ;
parameter H_DISP    = 10'd640   ;
parameter H_FRONT   = 10'd16    ;
parameter H_TOTAL   = 10'd800   ;
parameter V_SYNC    = 10'd2     ;
parameter V_BACK    = 10'd23    ;
parameter V_DISP    = 10'd480   ;
parameter V_FRONT   = 10'd10    ;
parameter V_TOTAL   = 10'd525   ;

// // 1024*768@65_65MHz
// parameter H_SYNC	= 11'd136	;
// parameter H_BACK	= 11'd160	;
// parameter H_DISP	= 11'd1024	;
// parameter H_FRONT	= 11'd24	;
// parameter H_TOTAL	= 11'd1344	;
// parameter V_SYNC	= 11'd6		;
// parameter V_BACK	= 11'd29	;
// parameter V_DISP	= 11'd768	;
// parameter V_FRONT	= 11'd3		;
// parameter V_TOTAL	= 11'd806	;

reg     [10:0]  cnt_h   ;
reg     [10:0]  cnt_v   ;
wire            data_en ;

// 行时序计数器
always@(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        cnt_h <= 11'd0;
    else if(cnt_h < H_TOTAL - 1'b1)
        cnt_h <= cnt_h + 1'b1;
    else
        cnt_h <= 11'd0;
end
// 场时序计数器
always@(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        cnt_v <= 11'd0;
    else if(cnt_h == H_TOTAL - 1'b1)
        if(cnt_v < V_TOTAL - 1'b1)
            cnt_v <= cnt_v + 1'b1;
        else
            cnt_v <= 11'd0;
    else
        cnt_v <= cnt_v;
end


// VGA行同步信号
assign vga_hs = (cnt_h < H_SYNC) ? 1'b0 : 1'b1;
// VGA行同步信号
assign vga_vs = (cnt_v < V_SYNC) ? 1'b0 : 1'b1;
// VGA数据信号
assign vga_data = data_en ? pix_data : 16'd0;
// 像素坐标
assign pix_x = data_req ? (cnt_h - (H_SYNC + H_BACK - 1'b1)) : 11'd0;
assign pix_y = data_req ? (cnt_v - (V_SYNC + V_BACK)) : 11'd0;

assign data_en = ((cnt_h >= H_SYNC + H_BACK) && (cnt_h < H_SYNC + H_BACK + H_DISP))
                && ((cnt_v >= V_SYNC + V_BACK) && (cnt_v < V_SYNC + V_BACK + V_DISP))
                ? 1'b1 : 1'b0;
assign data_req = ((cnt_h >= H_SYNC + H_BACK - 1'b1) && (cnt_h < H_SYNC + H_BACK + H_DISP - 1'b1))
                && ((cnt_v >= V_SYNC + V_BACK) && (cnt_v < V_SYNC + V_BACK + V_DISP))
                ? 1'b1 : 1'b0;

endmodule
