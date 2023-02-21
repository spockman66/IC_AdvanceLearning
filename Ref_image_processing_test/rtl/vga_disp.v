//************************************************
// Author       : Jack
// Creat Date   : 2022/12/26
// Revision     : v1.0
// Target Device: Altera EP4CE10F17C8N
// Function     : 
//************************************************

module vga_disp
#(
    parameter H_DISP = 10'd640,
    parameter V_DISP = 10'd480
)
(
    input   wire            clk         ,
    input   wire            rst_n       ,
    // VGA数据
    input   wire    [10:0]  pix_x       ,
    input   wire    [10:0]  pix_y       ,
    output  reg     [15:0]  pix_data    ,
    // 图像处理数据
    input   wire    [15:0]  fram_data   ,
    input   wire    [ 2:0]  image_disp  ,
    input   wire    [ 2:0]  image_proc  ,
    input   wire    [ 6:0]  sobel_th    
);

// parameter define
`include "mode_para.v"
localparam DISP_X      = 10'd560;
localparam DISP_Y      = 10'd30;
localparam DISP_WIDTH  = 10'd32;
localparam DISP_HEIGHT = 10'd16;
localparam PROC_X      = 10'd560;
localparam PROC_Y      = 10'd50;
localparam PROC_WIDTH  = 10'd64;
localparam PROC_HEIGHT = 10'd16;
localparam NUM_X       = 10'd560;
localparam NUM_Y       = 10'd70;
localparam NUM_WIDTH   = 10'd16;
localparam NUM_HEIGHT  = 10'd16;
localparam BLACK       = 16'b00000_000000_00000;

// wire define
wire    [9:0]   x_disp_cnt;
wire    [9:0]   y_disp_cnt;
wire    [9:0]   x_proc_cnt;
wire    [9:0]   y_proc_cnt;
wire    [9:0]   x_num_cnt;
wire    [9:0]   y_num_cnt;

// reg define
reg     [31:0]  char_RGB  [15:0];
reg     [31:0]  char_RGB_R[15:0];
reg     [31:0]  char_RGB_G[15:0];
reg     [31:0]  char_RGB_B[15:0];
reg     [31:0]  char_YUV_Y[15:0];
reg     [63:0]  char_MEAN [15:0];
reg     [63:0]  char_GAU  [15:0];
reg     [63:0]  char_MID  [15:0];
reg     [63:0]  char_SOBEL[15:0];
reg     [15:0]  char_NUM20[15:0];
reg     [15:0]  char_NUM30[15:0];
reg     [15:0]  char_NUM40[15:0];
reg     [15:0]  char_NUM50[15:0];
reg     [15:0]  char_NUM60[15:0];
reg     [15:0]  char_NUM70[15:0];
reg     [15:0]  char_NUM80[15:0];
reg     [15:0]  char_NUM90[15:0];

//*******************************************
//*****************main code*****************
//*******************************************
assign x_disp_cnt = pix_x - DISP_X;
assign y_disp_cnt = pix_y - DISP_Y;
assign x_proc_cnt = pix_x - PROC_X;
assign y_proc_cnt = pix_y - PROC_Y;
assign x_num_cnt  = pix_x - NUM_X;
assign y_num_cnt  = pix_y - NUM_Y;

always@(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        pix_data <= BLACK;
    else case(image_disp)
        `RGB:
            if((pix_x >= DISP_X) && (pix_x < DISP_X + DISP_WIDTH) && (pix_y >= DISP_Y) && (pix_y < DISP_Y + DISP_HEIGHT))
                if(char_RGB[y_disp_cnt][DISP_WIDTH - x_disp_cnt - 1'b1])
                    pix_data <= BLACK;
                else
                    pix_data <= fram_data;
            else
                pix_data <= fram_data;
        `RGB_R:
            if((pix_x >= DISP_X) && (pix_x < DISP_X + DISP_WIDTH) && (pix_y >= DISP_Y) && (pix_y < DISP_Y + DISP_HEIGHT))
                if(char_RGB_R[y_disp_cnt][DISP_WIDTH - x_disp_cnt - 1'b1])
                    pix_data <= BLACK;
                else
                    pix_data <= fram_data;
            else
                pix_data <= fram_data;
        `RGB_G:
            if((pix_x >= DISP_X) && (pix_x < DISP_X + DISP_WIDTH) && (pix_y >= DISP_Y) && (pix_y < DISP_Y + DISP_HEIGHT))
                if(char_RGB_G[y_disp_cnt][DISP_WIDTH - x_disp_cnt - 1'b1])
                    pix_data <= BLACK;
                else
                    pix_data <= fram_data;
            else
                pix_data <= fram_data;
        `RGB_B:
            if((pix_x >= DISP_X) && (pix_x < DISP_X + DISP_WIDTH) && (pix_y >= DISP_Y) && (pix_y < DISP_Y + DISP_HEIGHT))
                if(char_RGB_B[y_disp_cnt][DISP_WIDTH - x_disp_cnt - 1'b1])
                    pix_data <= BLACK;
                else
                    pix_data <= fram_data;
            else
                pix_data <= fram_data;
        `YUV_Y:
            if((pix_x >= DISP_X) && (pix_x < DISP_X + DISP_WIDTH) && (pix_y >= DISP_Y) && (pix_y < DISP_Y + DISP_HEIGHT))
                if(char_YUV_Y[y_disp_cnt][DISP_WIDTH - x_disp_cnt - 1'b1])
                    pix_data <= BLACK;
                else
                    pix_data <= fram_data;
            else case(image_proc)
                `NOP:
                    pix_data <= fram_data;
                `MEAN:
                    if((pix_x >= PROC_X) && (pix_x < PROC_X + PROC_WIDTH) && (pix_y >= PROC_Y) && (pix_y < PROC_Y + PROC_HEIGHT))
                        if(char_MEAN[y_proc_cnt][PROC_WIDTH - x_proc_cnt - 1'b1])
                            pix_data <= BLACK;
                        else
                            pix_data <= fram_data;
                    else
                        pix_data <= fram_data;
                `GAUSSIAN:
                    if((pix_x >= PROC_X) && (pix_x < PROC_X + PROC_WIDTH) && (pix_y >= PROC_Y) && (pix_y < PROC_Y + PROC_HEIGHT))
                        if(char_GAU[y_proc_cnt][PROC_WIDTH - x_proc_cnt - 1'b1])
                            pix_data <= BLACK;
                        else
                            pix_data <= fram_data;
                    else
                        pix_data <= fram_data;
                `MEDIUM:
                    if((pix_x >= PROC_X) && (pix_x < PROC_X + PROC_WIDTH) && (pix_y >= PROC_Y) && (pix_y < PROC_Y + PROC_HEIGHT))
                        if(char_MID[y_proc_cnt][PROC_WIDTH - x_proc_cnt - 1'b1])
                            pix_data <= BLACK;
                        else
                            pix_data <= fram_data;
                    else
                        pix_data <= fram_data;
                `SOBEL, `EROSION, `DILATION:
                    if((pix_x >= PROC_X) && (pix_x < PROC_X + PROC_WIDTH) && (pix_y >= PROC_Y) && (pix_y < PROC_Y + PROC_HEIGHT))
                        if(char_SOBEL[y_proc_cnt][PROC_WIDTH - x_proc_cnt - 1'b1])
                            pix_data <= BLACK;
                        else
                            pix_data <= fram_data;
                    else case(sobel_th)
                        7'd20:
                            if((pix_x >= NUM_X) && (pix_x < NUM_X + NUM_WIDTH) && (pix_y >= NUM_Y) && (pix_y < NUM_Y + NUM_HEIGHT) && char_NUM20[y_num_cnt][NUM_WIDTH - x_num_cnt - 1'b1])
                                pix_data <= BLACK;
                            else
                                pix_data <= fram_data;
                        7'd30:
                            if((pix_x >= NUM_X) && (pix_x < NUM_X + NUM_WIDTH) && (pix_y >= NUM_Y) && (pix_y < NUM_Y + NUM_HEIGHT) && char_NUM30[y_num_cnt][NUM_WIDTH - x_num_cnt - 1'b1])
                                pix_data <= BLACK;
                            else
                                pix_data <= fram_data;
                        7'd40:
                            if((pix_x >= NUM_X) && (pix_x < NUM_X + NUM_WIDTH) && (pix_y >= NUM_Y) && (pix_y < NUM_Y + NUM_HEIGHT) && char_NUM40[y_num_cnt][NUM_WIDTH - x_num_cnt - 1'b1])
                                pix_data <= BLACK;
                            else
                                pix_data <= fram_data;
                        7'd50:
                            if((pix_x >= NUM_X) && (pix_x < NUM_X + NUM_WIDTH) && (pix_y >= NUM_Y) && (pix_y < NUM_Y + NUM_HEIGHT) && char_NUM50[y_num_cnt][NUM_WIDTH - x_num_cnt - 1'b1])
                                pix_data <= BLACK;
                            else
                                pix_data <= fram_data;
                        7'd60:
                            if((pix_x >= NUM_X) && (pix_x < NUM_X + NUM_WIDTH) && (pix_y >= NUM_Y) && (pix_y < NUM_Y + NUM_HEIGHT) && char_NUM60[y_num_cnt][NUM_WIDTH - x_num_cnt - 1'b1])
                                pix_data <= BLACK;
                            else
                                pix_data <= fram_data;
                        7'd70:
                            if((pix_x >= NUM_X) && (pix_x < NUM_X + NUM_WIDTH) && (pix_y >= NUM_Y) && (pix_y < NUM_Y + NUM_HEIGHT) && char_NUM70[y_num_cnt][NUM_WIDTH - x_num_cnt - 1'b1])
                                pix_data <= BLACK;
                            else
                                pix_data <= fram_data;
                        7'd80:
                            if((pix_x >= NUM_X) && (pix_x < NUM_X + NUM_WIDTH) && (pix_y >= NUM_Y) && (pix_y < NUM_Y + NUM_HEIGHT) && char_NUM80[y_num_cnt][NUM_WIDTH - x_num_cnt - 1'b1])
                                pix_data <= BLACK;
                            else
                                pix_data <= fram_data;
                        7'd90:
                            if((pix_x >= NUM_X) && (pix_x < NUM_X + NUM_WIDTH) && (pix_y >= NUM_Y) && (pix_y < NUM_Y + NUM_HEIGHT) && char_NUM90[y_num_cnt][NUM_WIDTH - x_num_cnt - 1'b1])
                                pix_data <= BLACK;
                            else
                                pix_data <= fram_data;
                        default:
                            pix_data <= fram_data;
                    endcase
                default:
                    pix_data <= fram_data;
            endcase
        default:
            pix_data <= fram_data;
    endcase
end

always@(posedge clk)
begin
    char_RGB[ 0] <= 32'h00000100;
    char_RGB[ 1] <= 32'h7FFC1110;
    char_RGB[ 2] <= 32'h01000920;
    char_RGB[ 3] <= 32'h01007FFE;
    char_RGB[ 4] <= 32'h01004002;
    char_RGB[ 5] <= 32'h01009FF4;
    char_RGB[ 6] <= 32'h11001010;
    char_RGB[ 7] <= 32'h11F81FF0;
    char_RGB[ 8] <= 32'h11000100;
    char_RGB[ 9] <= 32'h11003FF8;
    char_RGB[10] <= 32'h11002108;
    char_RGB[11] <= 32'h11002108;
    char_RGB[12] <= 32'h11002128;
    char_RGB[13] <= 32'h11002110;
    char_RGB[14] <= 32'hFFFE0100;
    char_RGB[15] <= 32'h00000100;
end
always@(posedge clk)
begin
    char_RGB_R[ 0] <= 32'h10000800;
    char_RGB_R[ 1] <= 32'h10000800;
    char_RGB_R[ 2] <= 32'h21FC1FE0;
    char_RGB_R[ 3] <= 32'h24202020;
    char_RGB_R[ 4] <= 32'h44204040;
    char_RGB_R[ 5] <= 32'hF820BFF8;
    char_RGB_R[ 6] <= 32'h10202108;
    char_RGB_R[ 7] <= 32'h20202108;
    char_RGB_R[ 8] <= 32'h40202108;
    char_RGB_R[ 9] <= 32'hFC203FF8;
    char_RGB_R[10] <= 32'h40202000;
    char_RGB_R[11] <= 32'h00202002;
    char_RGB_R[12] <= 32'h1C202002;
    char_RGB_R[13] <= 32'hE0202002;
    char_RGB_R[14] <= 32'h43FE1FFE;
    char_RGB_R[15] <= 32'h00000000;
end
always@(posedge clk)
begin
    char_RGB_G[ 0] <= 32'h10000800;
    char_RGB_G[ 1] <= 32'h11F80800;
    char_RGB_G[ 2] <= 32'h20081FE0;
    char_RGB_G[ 3] <= 32'h20082020;
    char_RGB_G[ 4] <= 32'h49F84040;
    char_RGB_G[ 5] <= 32'hF808BFF8;
    char_RGB_G[ 6] <= 32'h10082108;
    char_RGB_G[ 7] <= 32'h23FE2108;
    char_RGB_G[ 8] <= 32'h40202108;
    char_RGB_G[ 9] <= 32'hFA223FF8;
    char_RGB_G[10] <= 32'h41742000;
    char_RGB_G[11] <= 32'h00A82002;
    char_RGB_G[12] <= 32'h19242002;
    char_RGB_G[13] <= 32'hE2222002;
    char_RGB_G[14] <= 32'h40A01FFE;
    char_RGB_G[15] <= 32'h00400000;
end
always@(posedge clk)
begin
    char_RGB_B[ 0] <= 32'h08200800;
    char_RGB_B[ 1] <= 32'h08200800;
    char_RGB_B[ 2] <= 32'hFFFE1FE0;
    char_RGB_B[ 3] <= 32'h08202020;
    char_RGB_B[ 4] <= 32'h04804040;
    char_RGB_B[ 5] <= 32'h2480BFF8;
    char_RGB_B[ 6] <= 32'h24FC2108;
    char_RGB_B[ 7] <= 32'h24A02108;
    char_RGB_B[ 8] <= 32'h25102108;
    char_RGB_B[ 9] <= 32'h00003FF8;
    char_RGB_B[10] <= 32'h3FF82000;
    char_RGB_B[11] <= 32'h24482002;
    char_RGB_B[12] <= 32'h24482002;
    char_RGB_B[13] <= 32'h24482002;
    char_RGB_B[14] <= 32'hFFFE1FFE;
    char_RGB_B[15] <= 32'h00000000;
end
always@(posedge clk)
begin
    char_YUV_Y[ 0] <= 32'h04000800;
    char_YUV_Y[ 1] <= 32'h04000800;
    char_YUV_Y[ 2] <= 32'h04001FE0;
    char_YUV_Y[ 3] <= 32'hFFFE2020;
    char_YUV_Y[ 4] <= 32'h08004040;
    char_YUV_Y[ 5] <= 32'h0880BFF8;
    char_YUV_Y[ 6] <= 32'h08842108;
    char_YUV_Y[ 7] <= 32'h12842108;
    char_YUV_Y[ 8] <= 32'h12882108;
    char_YUV_Y[ 9] <= 32'h24903FF8;
    char_YUV_Y[10] <= 32'h29402000;
    char_YUV_Y[11] <= 32'h41402002;
    char_YUV_Y[12] <= 32'h82202002;
    char_YUV_Y[13] <= 32'h04102002;
    char_YUV_Y[14] <= 32'h18081FFE;
    char_YUV_Y[15] <= 32'h60060000;
end
always@(posedge clk)
begin
    char_MEAN[ 0] <= 64'h1040084000400020;
    char_MEAN[ 1] <= 64'h10400840207C2020;
    char_MEAN[ 2] <= 64'h10800FFC10401020;
    char_MEAN[ 3] <= 64'h10FC104017FE13FE;
    char_MEAN[ 4] <= 64'h1104104084428222;
    char_MEAN[ 5] <= 64'hFE0433F844704224;
    char_MEAN[ 6] <= 64'h1084320847C44A20;
    char_MEAN[ 7] <= 64'h104453F814440BFC;
    char_MEAN[ 8] <= 64'h10449208143C1284;
    char_MEAN[ 9] <= 64'h101413F824201288;
    char_MEAN[10] <= 64'h10241208E410E248;
    char_MEAN[11] <= 64'h1C4413F824542250;
    char_MEAN[12] <= 64'hE184120825422220;
    char_MEAN[13] <= 64'h4004120829422450;
    char_MEAN[14] <= 64'h00281FFE294A2488;
    char_MEAN[15] <= 64'h0010100012380906;
end
always@(posedge clk)
begin
    char_GAU[ 0] <= 64'h0200220000400020;
    char_GAU[ 1] <= 64'h01002204207C2020;
    char_GAU[ 2] <= 64'hFFFE7F7810401020;
    char_GAU[ 3] <= 64'h0000224017FE13FE;
    char_GAU[ 4] <= 64'h0FE0224084428222;
    char_GAU[ 5] <= 64'h08203E4044704224;
    char_GAU[ 6] <= 64'h0820227E47C44A20;
    char_GAU[ 7] <= 64'h0FE0224814440BFC;
    char_GAU[ 8] <= 64'h00003E48143C1284;
    char_GAU[ 9] <= 64'h7FFC224824201288;
    char_GAU[10] <= 64'h40042248E410E248;
    char_GAU[11] <= 64'h4FE4FF4824542250;
    char_GAU[12] <= 64'h4824044825422220;
    char_GAU[13] <= 64'h4824228829422450;
    char_GAU[14] <= 64'h4FE44188294A2488;
    char_GAU[15] <= 64'h400C810812380906;
end
always@(posedge clk)
begin
    char_MID[ 0] <= 64'h0100084000400020;
    char_MID[ 1] <= 64'h01000840207C2020;
    char_MID[ 2] <= 64'h01000FFC10401020;
    char_MID[ 3] <= 64'h0100104017FE13FE;
    char_MID[ 4] <= 64'h3FF8104084428222;
    char_MID[ 5] <= 64'h210833F844704224;
    char_MID[ 6] <= 64'h2108320847C44A20;
    char_MID[ 7] <= 64'h210853F814440BFC;
    char_MID[ 8] <= 64'h21089208143C1284;
    char_MID[ 9] <= 64'h210813F824201288;
    char_MID[10] <= 64'h3FF81208E410E248;
    char_MID[11] <= 64'h210813F824542250;
    char_MID[12] <= 64'h0100120825422220;
    char_MID[13] <= 64'h0100120829422450;
    char_MID[14] <= 64'h01001FFE294A2488;
    char_MID[15] <= 64'h0100100012380906;
end
always@(posedge clk)
begin
    char_SOBEL[ 0] <= 64'h0000000000000000;
    char_SOBEL[ 1] <= 64'h0000000000000000;
    char_SOBEL[ 2] <= 64'h0000000000000000;
    char_SOBEL[ 3] <= 64'h3E38F8FCE0000000;
    char_SOBEL[ 4] <= 64'h4244444240000000;
    char_SOBEL[ 5] <= 64'h4282444840000000;
    char_SOBEL[ 6] <= 64'h4082444840000000;
    char_SOBEL[ 7] <= 64'h2082787840000000;
    char_SOBEL[ 8] <= 64'h1882444840000000;
    char_SOBEL[ 9] <= 64'h0482424840000000;
    char_SOBEL[10] <= 64'h0282424040000000;
    char_SOBEL[11] <= 64'h4282424240000000;
    char_SOBEL[12] <= 64'h4244444242000000;
    char_SOBEL[13] <= 64'h7C38F8FCFE000000;
    char_SOBEL[14] <= 64'h0000000000000000;
    char_SOBEL[15] <= 64'h0000000000000000;
end
always@(posedge clk)
begin
    char_NUM20[ 0] <= 16'h0000;
    char_NUM20[ 1] <= 16'h0000;
    char_NUM20[ 2] <= 16'h0000;
    char_NUM20[ 3] <= 16'h3C18;
    char_NUM20[ 4] <= 16'h4224;
    char_NUM20[ 5] <= 16'h4242;
    char_NUM20[ 6] <= 16'h4242;
    char_NUM20[ 7] <= 16'h0242;
    char_NUM20[ 8] <= 16'h0442;
    char_NUM20[ 9] <= 16'h0842;
    char_NUM20[10] <= 16'h1042;
    char_NUM20[11] <= 16'h2042;
    char_NUM20[12] <= 16'h4224;
    char_NUM20[13] <= 16'h7E18;
    char_NUM20[14] <= 16'h0000;
    char_NUM20[15] <= 16'h0000;
end
always@(posedge clk)
begin
    char_NUM30[ 0] <= 16'h0000;
    char_NUM30[ 1] <= 16'h0000;
    char_NUM30[ 2] <= 16'h0000;
    char_NUM30[ 3] <= 16'h3C18;
    char_NUM30[ 4] <= 16'h4224;
    char_NUM30[ 5] <= 16'h4242;
    char_NUM30[ 6] <= 16'h0242;
    char_NUM30[ 7] <= 16'h0442;
    char_NUM30[ 8] <= 16'h1842;
    char_NUM30[ 9] <= 16'h0442;
    char_NUM30[10] <= 16'h0242;
    char_NUM30[11] <= 16'h4242;
    char_NUM30[12] <= 16'h4224;
    char_NUM30[13] <= 16'h3C18;
    char_NUM30[14] <= 16'h0000;
    char_NUM30[15] <= 16'h0000;
end
always@(posedge clk)
begin
    char_NUM40[ 0] <= 16'h0000;
    char_NUM40[ 1] <= 16'h0000;
    char_NUM40[ 2] <= 16'h0000;
    char_NUM40[ 3] <= 16'h0418;
    char_NUM40[ 4] <= 16'h0C24;
    char_NUM40[ 5] <= 16'h0C42;
    char_NUM40[ 6] <= 16'h1442;
    char_NUM40[ 7] <= 16'h2442;
    char_NUM40[ 8] <= 16'h2442;
    char_NUM40[ 9] <= 16'h4442;
    char_NUM40[10] <= 16'h7F42;
    char_NUM40[11] <= 16'h0442;
    char_NUM40[12] <= 16'h0424;
    char_NUM40[13] <= 16'h1F18;
    char_NUM40[14] <= 16'h0000;
    char_NUM40[15] <= 16'h0000;
end
always@(posedge clk)
begin
    char_NUM50[ 0] <= 16'h0000;
    char_NUM50[ 1] <= 16'h0000;
    char_NUM50[ 2] <= 16'h0000;
    char_NUM50[ 3] <= 16'h7E18;
    char_NUM50[ 4] <= 16'h4024;
    char_NUM50[ 5] <= 16'h4042;
    char_NUM50[ 6] <= 16'h4042;
    char_NUM50[ 7] <= 16'h7842;
    char_NUM50[ 8] <= 16'h4442;
    char_NUM50[ 9] <= 16'h0242;
    char_NUM50[10] <= 16'h0242;
    char_NUM50[11] <= 16'h4242;
    char_NUM50[12] <= 16'h4424;
    char_NUM50[13] <= 16'h3818;
    char_NUM50[14] <= 16'h0000;
    char_NUM50[15] <= 16'h0000;
end
always@(posedge clk)
begin
    char_NUM60[ 0] <= 16'h0000;
    char_NUM60[ 1] <= 16'h0000;
    char_NUM60[ 2] <= 16'h0000;
    char_NUM60[ 3] <= 16'h1818;
    char_NUM60[ 4] <= 16'h2424;
    char_NUM60[ 5] <= 16'h4042;
    char_NUM60[ 6] <= 16'h4042;
    char_NUM60[ 7] <= 16'h5C42;
    char_NUM60[ 8] <= 16'h6242;
    char_NUM60[ 9] <= 16'h4242;
    char_NUM60[10] <= 16'h4242;
    char_NUM60[11] <= 16'h4242;
    char_NUM60[12] <= 16'h2224;
    char_NUM60[13] <= 16'h1C18;
    char_NUM60[14] <= 16'h0000;
    char_NUM60[15] <= 16'h0000;
end
always@(posedge clk)
begin
    char_NUM70[ 0] <= 16'h0000;
    char_NUM70[ 1] <= 16'h0000;
    char_NUM70[ 2] <= 16'h0000;
    char_NUM70[ 3] <= 16'h7E18;
    char_NUM70[ 4] <= 16'h4224;
    char_NUM70[ 5] <= 16'h0442;
    char_NUM70[ 6] <= 16'h0442;
    char_NUM70[ 7] <= 16'h0842;
    char_NUM70[ 8] <= 16'h0842;
    char_NUM70[ 9] <= 16'h1042;
    char_NUM70[10] <= 16'h1042;
    char_NUM70[11] <= 16'h1042;
    char_NUM70[12] <= 16'h1024;
    char_NUM70[13] <= 16'h1018;
    char_NUM70[14] <= 16'h0000;
    char_NUM70[15] <= 16'h0000;
end
always@(posedge clk)
begin
    char_NUM80[ 0] <= 16'h0000;
    char_NUM80[ 1] <= 16'h0000;
    char_NUM80[ 2] <= 16'h0000;
    char_NUM80[ 3] <= 16'h3C18;
    char_NUM80[ 4] <= 16'h4224;
    char_NUM80[ 5] <= 16'h4242;
    char_NUM80[ 6] <= 16'h4242;
    char_NUM80[ 7] <= 16'h2442;
    char_NUM80[ 8] <= 16'h1842;
    char_NUM80[ 9] <= 16'h2442;
    char_NUM80[10] <= 16'h4242;
    char_NUM80[11] <= 16'h4242;
    char_NUM80[12] <= 16'h4224;
    char_NUM80[13] <= 16'h3C18;
    char_NUM80[14] <= 16'h0000;
    char_NUM80[15] <= 16'h0000;
end
always@(posedge clk)
begin
    char_NUM90[ 0] <= 16'h0000;
    char_NUM90[ 1] <= 16'h0000;
    char_NUM90[ 2] <= 16'h0000;
    char_NUM90[ 3] <= 16'h3818;
    char_NUM90[ 4] <= 16'h4424;
    char_NUM90[ 5] <= 16'h4242;
    char_NUM90[ 6] <= 16'h4242;
    char_NUM90[ 7] <= 16'h4242;
    char_NUM90[ 8] <= 16'h4642;
    char_NUM90[ 9] <= 16'h3A42;
    char_NUM90[10] <= 16'h0242;
    char_NUM90[11] <= 16'h0242;
    char_NUM90[12] <= 16'h2424;
    char_NUM90[13] <= 16'h1818;
    char_NUM90[14] <= 16'h0000;
    char_NUM90[15] <= 16'h0000;
end

endmodule
