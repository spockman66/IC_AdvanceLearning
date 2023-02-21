`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/05 16:53:26
// Design Name: 
// Module Name: pulse_sync
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pulse_sync(
    clksrc, rstb_clksrc,
    clkdest, rstb_clkdest,
    pulse_clksrc, pulse_clkdest
);

    input       clksrc              ;
    input       rstb_clksrc         ;
    input       clkdest             ;
    input       rstb_clkdest        ;
    input       pulse_clksrc        ;
    output      pulse_clkdest       ;

    reg sig_stretched;
    wire sig_stretched_next;

    reg sig_stretched_dest_sync;
    reg sig_stretched_dest;
    reg sig_stretched_dest_d1;

    reg sig_stretched_ack;
    reg sig_stretched_ack_pre;
    reg sig_stretched_ack_d1;
    wire sig_stretched_edge;
    wire pulse_clkdest;


    assign sig_stretched_next = sig_stretched_edge ? 1'b0 : (pulse_clksrc ? 1'b1 : sig_stretched);

    always @(posedge clksrc or negedge rstb_clksrc) begin
        if(~rstb_clksrc) begin
            sig_stretched <= 1'b0;
        end
        else begin
            sig_stretched <= sig_stretched_next;
        end
    end

    /* First two flip flops for sync, third for pulse generation */
    always @(posedge clkdest or negedge rstb_clkdest) begin
        if(~rstb_clkdest)begin
            sig_stretched_dest_sync <= 1'b0;
            sig_stretched_dest <= 1'b0;

            sig_stretched_dest_d1 <= 1'b0;          // for pulse generation
        end
        else begin
            sig_stretched_dest_sync <= sig_stretched;
            sig_stretched_dest <= sig_stretched_dest_sync;                  // sig_stretch -->> sig_stretched_dest

            sig_stretched_dest_d1 <= sig_stretched_dest;
        end
    end
    
    assign pulse_clkdest = sig_stretched_dest & ~sig_stretched_dest_d1;


    // synchronize back to clksrc
    always @(posedge clksrc or negedge rstb_clksrc) begin
        if(~rstb_clksrc) begin
            sig_stretched_ack_pre <= 1'b0;
            sig_stretched_ack <= 1'b0;
            sig_stretched_ack_d1 <= 1'b0;
        end
        else begin
            sig_stretched_ack_pre <= sig_stretched_dest;
            sig_stretched_ack <= sig_stretched_ack_pre;
            sig_stretched_ack_d1 <= sig_stretched_ack;
        end
    end

    assign sig_stretched_edge = sig_stretched_ack & ~sig_stretched_ack_d1;



endmodule
