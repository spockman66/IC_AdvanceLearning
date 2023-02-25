/*
 
Copyright (c) 2018 Alex Forencich
 
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
 
The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.
 
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
 
*/


`resetall
`timescale 1ns / 1ps

`include "../rtl/para.v"

/*
 * AXI4 RAM
 */
module axi_ram #
	(
		// Width of data bus in bits
		parameter DATA_WIDTH = 32,
		// Width of address bus in bits
		parameter ADDR_WIDTH = 16,
		// Width of ID signal
		parameter ID_WIDTH = 8,

		parameter STRB_WIDTH = (DATA_WIDTH/8)
	)
	(
		input  wire                   s_axi_aclk,
		input  wire                   s_axi_aresetn,

		// write address channel
		input  wire  [ID_WIDTH-1:0]                  s_axi_awid,
		input  wire  [ADDR_WIDTH-1:0]                s_axi_awaddr,
		input  wire  [`AXI_BURST_LEN_WIDTH-1:0]      s_axi_awlen,
		input  wire  [`AXI_BURST_SIZE_WIDTH-1:0]     s_axi_awsize,
		input  wire  [`AXI_BURST_TYPE_WIDTH-1:0]     s_axi_awburst,
		input  wire  [`AXI_PROT_WIDTH-1:0]           s_axi_awprot,
		input  wire  [`AXI_CACHE_WIDTH-1:0]          s_axi_awcache,
		input  wire       s_axi_awlock,
		input  wire       s_axi_awvalid,
		output wire       s_axi_awready,

		input wire [`AXI_QOS_WIDTH-1 : 0]            s_axi_awqos,
		input wire [`AXI_REGION_WIDTH-1 : 0]         s_axi_awregion,


		// write response channel
		output  wire [ID_WIDTH-1:0]    s_axi_bid,
		output  wire [1:0]             s_axi_bresp,
		output  wire                   s_axi_bvalid,
		input   wire                   s_axi_bready,

		// write data channel
		input  wire  [DATA_WIDTH-1:0]  s_axi_wdata,
		input  wire  [STRB_WIDTH-1:0]  s_axi_wstrb,
		input  wire                    s_axi_wlast,
		input  wire                    s_axi_wvalid,
		output wire                    s_axi_wready,

		// read address channel
		input  wire  [ID_WIDTH-1:0]                  s_axi_arid,
		input  wire  [ADDR_WIDTH-1:0]                s_axi_araddr,
		input  wire  [`AXI_BURST_LEN_WIDTH-1:0]      s_axi_arlen,
		input  wire  [`AXI_BURST_SIZE_WIDTH-1:0]     s_axi_arsize,
		input  wire  [`AXI_BURST_TYPE_WIDTH-1:0]     s_axi_arburst,
		input  wire  [`AXI_PROT_WIDTH-1:0]           s_axi_arprot,
		input  wire  [`AXI_CACHE_WIDTH-1:0]          s_axi_arcache,
		input  wire       s_axi_arlock,
		input  wire       s_axi_arvalid,
		output wire       s_axi_arready,

		input wire [`AXI_QOS_WIDTH-1 : 0]            s_axi_arqos,
		input wire [`AXI_REGION_WIDTH-1 : 0]         s_axi_arregion,

		// read data channel
		output  wire [ID_WIDTH-1:0]    s_axi_rid,
		output  wire [DATA_WIDTH-1:0]  s_axi_rdata,
		output  wire [1:0]             s_axi_rresp,
		output  wire                   s_axi_rlast,
		output  wire                   s_axi_rvalid,
		input   wire                   s_axi_rready
	);

	parameter VALID_ADDR_WIDTH = ADDR_WIDTH - $clog2(STRB_WIDTH);           //
	parameter WORD_WIDTH = STRB_WIDTH;
	parameter WORD_SIZE = DATA_WIDTH/WORD_WIDTH;

	localparam integer ADDR_LSB       = (DATA_WIDTH/32)+ 1;
	localparam integer MEM_ADDR_WIDTH = 5;
	localparam integer MEM_NUM        = 1;
	localparam integer MEM_BYTE_NUM   = 64; // Maximum number of bytes that can be written

	// bus width assertions
	initial begin
		if (WORD_SIZE * STRB_WIDTH != DATA_WIDTH) begin
			$error("Error: AXI data width not evenly divisble (instance %m)");
			$finish;
		end

		if (2**$clog2(WORD_WIDTH) != WORD_WIDTH) begin
			$error("Error: AXI word width must be even power of two (instance %m)");
			$finish;
		end
	end

	reg mem_wr_en;
	reg mem_rd_en;

	reg  [ADDR_WIDTH-1 : 0] 	     axi_awaddr;
	reg                              axi_awready;
	reg                              axi_wready;
	reg  [`AXI_RESP_WIDTH-1 : 0] 	 axi_bresp;
	reg                              axi_bvalid;
	reg  [ADDR_WIDTH-1 : 0] 	     axi_araddr;
	reg                              axi_arready;
	reg  [DATA_WIDTH-1 : 0] 	     axi_rdata;
	reg  [`AXI_RESP_WIDTH-1 : 0] 	 axi_rresp;
	reg                              axi_rlast;
	reg                              axi_rvalid;
	wire                             aw_wrap_en;
	wire                             ar_wrap_en;
	wire [31:0]                      aw_wrap_size ;
	wire [31:0]                      ar_wrap_size ;

	reg                              burst_write_active;
	reg                              burst_read_active;
	reg  [7:0]                       write_index;
	reg  [7:0]                       read_index;
	reg  [`AXI_BURST_TYPE_WIDTH-1:0] axi_arburst;
	reg  [`AXI_BURST_TYPE_WIDTH-1:0] axi_awburst;
	reg  [`AXI_BURST_LEN_WIDTH-1:0]  axi_arlen;
	reg  [`AXI_BURST_LEN_WIDTH-1:0]  axi_awlen;


	assign s_axi_awready = axi_awready;
	assign s_axi_wready  = axi_wready;
	assign s_axi_bresp   = axi_bresp;
	assign s_axi_bvalid  = axi_bvalid;
	assign s_axi_arready = axi_arready;
	assign s_axi_rdata   = axi_rdata;
	assign s_axi_rresp   = axi_rresp;
	assign s_axi_rlast   = axi_rlast;
	assign s_axi_rvalid  = axi_rvalid;

	assign s_axi_bid     = s_axi_awid;
	assign s_axi_rid     = s_axi_arid;

	assign  aw_wrap_size = (DATA_WIDTH/8 * (axi_awlen));
	assign  ar_wrap_size = (DATA_WIDTH/8 * (axi_arlen));
	assign  aw_wrap_en = ((axi_awaddr & aw_wrap_size) == aw_wrap_size)? 1'b1: 1'b0;
	assign  ar_wrap_en = ((axi_araddr & ar_wrap_size) == ar_wrap_size)? 1'b1: 1'b0;
	

//--------------------
//Write Address Channel (handshake)
//--------------------
always @(posedge s_axi_aclk) begin
	if(~s_axi_aresetn) begin
		axi_awready <= 1'b0;
		burst_write_active <= 1'b0;
	end
	else begin
		if(~axi_awready && s_axi_awvalid && ~burst_write_active) begin
			axi_awready <= 1'b1;
			burst_write_active <= 1'b1;
		end
		else if(s_axi_wlast && axi_wready) begin
			burst_write_active <= 1'b0;
		end
		else begin
			axi_awready <= 1'b0;
		end
	end
end


//--------------------
//Write Addr Channel
//--------------------
always @(posedge s_axi_aclk) begin
	if(~s_axi_aresetn) begin
		axi_awaddr <= 1'b0;
        write_index <= 1'b0;
        axi_awburst <= 1'b0;
        axi_awlen   <= 1'b0;
	end
	else begin
        if (~axi_awready && s_axi_awvalid && ~burst_write_active) begin
            axi_awaddr  <= s_axi_awaddr;
            axi_awburst <= s_axi_awburst;
            axi_awlen   <= s_axi_awlen;
            write_index <= 1'b0;
		end
		else if((write_index <= axi_awlen) && axi_wready && s_axi_wvalid)begin
			write_index <= write_index + 1'b1;
			case (axi_awburst)
				2'b00: begin
					axi_awaddr <= axi_awaddr;
				end
				2'b01: begin
					axi_awaddr[ADDR_WIDTH - 1:ADDR_LSB] <= axi_awaddr[ADDR_WIDTH - 1:ADDR_LSB] + 1;
					axi_awaddr[ADDR_LSB-1:0]                  <= {ADDR_LSB{1'b0}};
				end
				2'b10: begin
					if(aw_wrap_en) begin
						axi_awaddr <= axi_awaddr - aw_wrap_size; 
					end
					else begin
						axi_awaddr[ADDR_WIDTH - 1:ADDR_LSB] <= axi_awaddr[ADDR_WIDTH - 1:ADDR_LSB] + 1;
						axi_awaddr[ADDR_LSB-1:0]                  <= {ADDR_LSB{1'b0}};
					end
				end
				default: begin
					axi_awaddr[ADDR_WIDTH - 1:ADDR_LSB] <= axi_awaddr[ADDR_WIDTH - 1:ADDR_LSB] + 1;
				end
			endcase
		end
	end
end


always @(posedge s_axi_aclk) begin
    if (s_axi_aresetn == 1'b0) begin
        axi_wready <= 1'b0;
    end
    else begin
        if (~axi_wready && s_axi_wvalid && burst_write_active) begin
            axi_wready <= 1'b1;
        end
        else if (s_axi_wlast && axi_wready) begin
            axi_wready <= 1'b0;
        end
    end
end

always @(posedge s_axi_aclk) begin
	if(~s_axi_aresetn) begin
		axi_bvalid <= 1'b0;
		axi_bresp <= 2'b00;
	end
	else begin
		if(burst_write_active && axi_wready && s_axi_wvalid && ~axi_bvalid && s_axi_wlast) begin
			axi_bvalid <= 1'b1;
			axi_bresp <= 2'b00;
		end
		else if(s_axi_bready && axi_bvalid) begin
			axi_bvalid <= 1'b0;
		end
		else
			axi_bvalid <= axi_bvalid;
	end
end


always @(posedge s_axi_aclk) begin
	if(~s_axi_aresetn) begin
		axi_arready <= 1'b0;
		burst_read_active <= 1'b0;
	end
	else begin
		// AR通道握手成功，开始传输
		if(~axi_arready && s_axi_arvalid && ~burst_read_active && ~burst_write_active) begin
			axi_arready <= 1'b1;
			burst_read_active <= 1'b1;
		end
		// R Burst 传输结束
		else if(axi_rvalid && s_axi_rready && read_index == axi_arlen) begin
			burst_read_active <= 1'b0;
		end
		else begin
			axi_arready <= 1'b0;
			burst_read_active <= burst_read_active;
		end
	end
end


always @(posedge s_axi_aclk) begin
	if (~s_axi_aresetn) begin
		axi_araddr <= 'd0;
		axi_arburst <= 'd0;
		axi_arlen <= 'd0;
		read_index <= 8'd0;
		axi_rlast <= 1'b0;
	end
	else begin
		if(~axi_arready && s_axi_arvalid && ~burst_read_active) begin
			axi_araddr <= s_axi_araddr;
			axi_arburst <= s_axi_arburst;
			axi_arlen <= s_axi_arlen;

			read_index <= 'd0;
			axi_rlast <= 1'b0;
		end
		else if (axi_rvalid && s_axi_rready && read_index <= axi_arlen ) begin
			read_index <= read_index + 1'b1;
			axi_rlast <= 1'b0;
			case (axi_arburst)
				2'b00: begin: norm
					axi_araddr <= axi_araddr;		// normal
				end
				
				2'b01: begin: incr
					axi_araddr[ADDR_WIDTH-1:ADDR_LSB] <= axi_araddr[ADDR_WIDTH-1:ADDR_LSB]+1;
					axi_araddr[ADDR_LSB-1:0] <= {{ADDR_LSB}{1'b0}};
				end
				
				2'b10: begin: wrapping
					if(ar_wrap_en) begin
						axi_araddr <= axi_araddr - ar_wrap_size;
					end
					else begin
						axi_araddr[ADDR_WIDTH-1:ADDR_LSB] <= axi_araddr[ADDR_WIDTH-1:ADDR_LSB]+1;
						axi_araddr[ADDR_LSB-1:0] <= {{ADDR_LSB}{1'b0}};					end
					end
				default: 
                    begin
                        axi_araddr <= axi_araddr[ADDR_WIDTH - 1:ADDR_LSB]+1;
                    end
			endcase
		end
        else if((read_index == axi_arlen) && ~axi_rlast && burst_read_active) begin
            axi_rlast <= 1'b1;
        end
        else if (s_axi_rready) begin
            axi_rlast <= 1'b0;
        end
	end
end


always@(posedge s_axi_aclk) begin
	if (~s_axi_aresetn) begin
		axi_rvalid <= 1'b0;
		axi_rresp <= 'd0;
	end
	else begin
		if(burst_read_active && ~axi_rvalid) begin
			axi_rvalid <= 1'b1;
			axi_rresp <= 2'b00;
		end
		else if (axi_rvalid && s_axi_rready) begin
			axi_rvalid <= 1'b0;
		end
	end

end



	// (* RAM_STYLE="BLOCK" *)
	reg [DATA_WIDTH-1:0] mem[MEM_ADDR_WIDTH-1:0];
	wire [MEM_ADDR_WIDTH:0]     mem_address;

	genvar mem_index;
	genvar mem_byte_index;

	// integer i, j;
	// initial begin
	// 	// two nested loops for smaller number of iterations per loop
	// 	// workaround for synthesizer complaints about large loop counts
	// 	for (i = 0; i < 2**VALID_ADDR_WIDTH; i = i + 2**(VALID_ADDR_WIDTH/2)) begin
	// 		for (j = i; j < i + 2**(VALID_ADDR_WIDTH/2); j = j + 1) begin
	// 			mem[j] = 0;
	// 		end
	// 	end
	// end

// implement Block RAM(s)
	generate
		if (MEM_NUM >= 1) begin
			assign mem_address = (burst_read_active  ? axi_araddr[ADDR_LSB+MEM_ADDR_WIDTH:ADDR_LSB] 
							   : (burst_write_active ? axi_awaddr[ADDR_LSB+MEM_ADDR_WIDTH:ADDR_LSB] 
							   : 0));
		end
	endgenerate
	
	generate
		for(mem_index=0; mem_index<= MEM_NUM-1; mem_index=mem_index+1) begin:BRAM_GEN
			wire mem_rden;
			wire mem_wren;
	
			assign mem_wren = axi_wready && s_axi_wvalid;
			assign mem_rden = burst_read_active; 
	
			for(mem_byte_index=0; mem_byte_index<= (DATA_WIDTH/8-1); mem_byte_index=mem_byte_index+1) begin:BYTE_BRAM_GEN
				wire [8-1:0] data_in ;
				wire [8-1:0] data_out;
				reg  [8-1:0] byte_ram [0 : MEM_BYTE_NUM-1]; 
	
				assign data_in  = s_axi_wdata[(mem_byte_index*8+7) -: 8];
				assign data_out = byte_ram[mem_address];
	
				always @(posedge s_axi_aclk) begin
					if (mem_wren && s_axi_wstrb[mem_byte_index]) begin
						byte_ram[mem_address] <= data_in;
					end
				end
				always @(posedge s_axi_aclk) begin
					if (mem_rden) begin
						mem[mem_index][(mem_byte_index*8+7) -: 8] <= data_out;
					end
				end
			end
		end
	endgenerate

	always @(mem[0]) begin // MEM_NUM == 1
		if (axi_rvalid) begin
			axi_rdata <= mem[0];
		end
		else begin
			axi_rdata <= 32'h00000000;
		end
	end
	



endmodule

`resetall
