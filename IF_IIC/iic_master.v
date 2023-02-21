// Language: Verilog 2001

`timescale 1ns / 1ps

/*
Signal description:
1) _i input
2) _o output
3) _n activ lowpai
4) _dg debug signal
5) _r delay or register
6) _s state mechine
*/


/*
 * I2C master
 */
module i2c_master#(
	parameter CLK_DIV_PARAM = 10
)
(
		clk				
	,	rstn			

	// I2C interface
	,	iic_scl
	,	iic_sda

	// local interface
	,	wr_dev_addr
	,	wr_dev_reg
	,	wr_data_cnt
	,	wr_data
	,	wr_en	
	,	rd_data
	,	rd_cnt

	,	iic_busy
	,	iic_en

);



// ----------------port------------------ 
input 				clk     			;
input 				rstn   				;
inout 				iic_scl 			;
inout 				iic_sda 			;

input 	[7:0]		wr_dev_addr			;
input 	[7:0]		wr_dev_reg			;
input 	[7:0]		wr_data_cnt			;
input  	[7:0]		wr_data				;
input 				wr_en				;

output 	[7:0]		rd_data				;
input  				rd_cnt				;	

output 				iic_busy			;
output 				iic_en				;

// ----------------reg------------------ 
reg [7:0] 	wr_data_reg		;
reg 		scl_r			;


// ----------------wire------------------ 



// ----------------FSM PARAM REG------------------
localparam IDLE = 4'd0;
localparam START = 4'd1;
localparam W_WAIT = 4'd2;
localparam W_ACK = 4'd3;
localparam R_WAIT = 4'd4;
localparam R_ACK = 4'd5;
localparam STOP1 = 4'd6;
localparam STOP2 = 4'd7;

reg [3:0]	state, next_state;


// ----------------always------------------ 

reg [31:0]		clk_cnt;
reg 			clk_div;
always @(posedge clk or negedge rstn) begin
	if (~rstn)
		clk_div <= 1'b0;
	else if(clk_cnt == CLK_DIV_PARAM/2-1)
		clk_div <= ~clk_div;
	else 
		clk_div <= clk_div;
end

always @(posedge clk or negedge rstn) begin
	if (~rstn || clk_cnt == CLK_DIV_PARAM/2-1)
		clk_cnt <= 'd0;
	else
		clk_cnt <= clk_cnt + 1'b1;
end

always @(*) begin
	if(state == IDLE || state == STOP1 || state == STOP2)
		scl_r <= 1'b1;
	else
		scl_r <= ~clk_div;
	end


// ------------ state machine ----------------- 

always @(posedge clk or negedge rstn) begin
	if (~rstn)
		state <= IDLE;
	else
		state <= next_state;
end

always @(*) begin

	next_state = IDLE;
	case(state)
	IDLE: begin
		if(wr_en)
			next_state <= START;
		else
			next_state <= IDLE;
	end

	START: begin
		
	end

	W_WAIT: begin
		
	end

	default: begin

	end

	endcase

end






endmodule

