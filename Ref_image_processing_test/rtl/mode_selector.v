//************************************************
// Author       : Jack
// Creat Date   : 2022/12/25
// Revision     : v1.0
// Target Device: Altera EP4CE10F17C8N
// Function     : 
//************************************************

module mode_selector
(
    input   wire            clk             ,
    input   wire            rst_n           ,
    input   wire            key_flag        ,
    input   wire    [2:0]   key_value       ,
    output  reg     [6:0]   sobel_threshold ,
    output  reg     [2:0]   image_disp      ,
    output  reg     [2:0]   image_proc      
);

// parameter define
`include "mode_para.v"

// wire define

// reg define
reg     [2:0]   sobel_grade;
reg     [2:0]   disp_cnt;
reg     [3:0]   proc_cnt;


//*******************************************
//*****************main code*****************
//*******************************************
always@(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        begin
        sobel_grade <= 3'd2;
        disp_cnt    <= 3'd0;
        proc_cnt    <= 4'd0;
        end
    else if(key_flag)
        case(key_value)
            3'b001:
                if(disp_cnt < 3'd4)
                    disp_cnt <= disp_cnt + 1'b1;
                else
                    disp_cnt <= 3'd0;
            3'b010:
                if(proc_cnt <= 4'd8)
                    proc_cnt <= proc_cnt + 1'b1;
                else
                    proc_cnt <= 4'd0;
            3'b100:
                sobel_grade <= sobel_grade + 1'b1;
            default:
                begin
                sobel_grade <= sobel_grade;
                disp_cnt    <= disp_cnt;
                proc_cnt    <= proc_cnt;
                end
        endcase
    else
        begin
        sobel_grade <= sobel_grade;
        disp_cnt    <= disp_cnt;
        proc_cnt    <= proc_cnt;
        end
end

always@(*)
begin
    case(sobel_grade)
        3'd0: sobel_threshold = 7'd20;
        3'd1: sobel_threshold = 7'd30;
        3'd2: sobel_threshold = 7'd40;
        3'd3: sobel_threshold = 7'd50;
        3'd4: sobel_threshold = 7'd60;
        3'd5: sobel_threshold = 7'd70;
        3'd6: sobel_threshold = 7'd80;
        3'd7: sobel_threshold = 7'd90;
        default: sobel_threshold = 7'd20;
    endcase
end

always@(*)
begin
    case(disp_cnt)
        3'd0: image_disp = `RGB;
        3'd1: image_disp = `RGB_R;
        3'd2: image_disp = `RGB_G;
        3'd3: image_disp = `RGB_B;
        3'd4: image_disp = `YUV_Y;
        default: image_disp = `RGB;
    endcase
end

always@(*)
begin
    case(proc_cnt)
        4'd0: image_proc = `NOP;
        4'd1: image_proc = `MEAN;
        4'd2: image_proc = `NOP;
        4'd3: image_proc = `GAUSSIAN;
        4'd4: image_proc = `NOP;
        4'd5: image_proc = `MEDIUM;
        4'd6: image_proc = `SOBEL;
        4'd7: image_proc = `EROSION;
        4'd8: image_proc = `DILATION;
        default: image_proc = `NOP;
    endcase
end

endmodule
