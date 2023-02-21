`timescale 1ns/1ns

module mul_tb ;
    parameter    N = 8 ;
    parameter    M = 8 ;
    reg          clk, rstn;

    //clock
    always begin
        clk = 0 ;
        #5 ;
        clk = 1 ;
        #5 ;
    end

    //reset
    initial begin
        rstn      = 1'b0 ;
        #38 ;
        rstn      = 1'b1 ;
    end

    //no pipeline
    reg                  vld_low ;
    reg [M-1:0]          mult1_low ;
    reg [N-1:0]          mult2_low ;
    wire [M+N-1:0]       res_low ;
    wire                 res_vld_low ;

    //使用任务周期激励
    task mult_data_in ;
        input [M+N-1:0]   mult1_task, mult2_task ;
        begin
            wait(!mul_tb.u_mult_raw.res_vld) ;  //not output state
            @(negedge clk ) ;
            vld_low = 1'b1 ;
            mult1_low = mult1_task ;
            

            mult2_low = mult2_task ;
            @(negedge clk ) ;
            vld_low = 1'b0 ;
            wait(mul_tb.u_mult_raw.res_vld) ; //test the output state
        end
    endtask

    //driver
    initial begin
        vld_low = 0;
        mult1_low = 0;
        mult2_low = 0;
        #55 ;
        mult_data_in(25, 5 ) ;
        mult_data_in(16, 10 ) ;
        mult_data_in(10, 4 ) ;
        mult_data_in(15, 7) ;
        mult_data_in(215, 9) ;
    end

    mul_raw  #(.N(N), .M(M))
             u_mult_raw
             (
                 .clk              (clk),
                 .rstn             (rstn),
                 .vld              (vld_low),
                 .mult1            (mult1_low),
                 .mult2            (mult2_low),
                 .res_vld          (res_vld_low),
                 .res              (res_low));

    //simulation finish
    initial begin
        forever begin
            #100;
            if ($time >= 10000)
                $finish ;
        end
    end

endmodule // test
