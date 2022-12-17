`timescale 1ns/1ps

module tb_narrow_trans();
    //===================parameter
    parameter PERIOD = 20;
    //===================defination
    reg clk, rst_n;
    reg [31 : 0] i_data;
    reg [3 : 0] i_data_strobe;
    wire [63 : 0] o_data;
    wire o_vld;
    //===================logic
    initial begin
        clk = 0;
        rst_n = 0;
        #200 rst_n = 1;
	#500 $finish;
    end
    always #(PERIOD / 2) clk = ~clk;
    initial begin
        @(rst_n);
        data_in(32'habcd_1234, 4'b1010);
        data_in(32'hef67_3482, 4'b1111);
        data_in(32'h6789_3322, 4'b0110);
        data_in(32'hef67_3482, 4'b1100);
        data_in(32'habcd_1234, 4'b1010);
        data_in(32'hef67_3482, 4'b1111);
        data_in(32'h6789_3322, 4'b0110);
        data_in(32'hef67_3482, 4'b1100);
    end

    task data_in(input [31 : 0] data, input [3 : 0] strobe); begin
        @(posedge clk);
        #1;
        i_data = data;
        i_data_strobe = strobe;
        end
    endtask
    narrow_trans u_inst(
        .clk(clk),
        .rst_n(rst_n),

        .i_data(i_data),
        .i_data_strobe(i_data_strobe),
        .o_data(o_data),
        .o_vld(o_vld)
    );

// `ifdef FSDB
// initial begin
// 	$fsdbDumpfile("narrow_trans.fsdb");
// 	$fsdbDumpvars;
//     	$fsdbDumpMDA();
// end
// `endif


endmodule 
