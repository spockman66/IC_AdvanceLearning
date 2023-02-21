// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sun Dec 11 21:48:41 2022
// Host        : DESKTOP-2S5PL5E running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               E:/study/3.lesson_for_fpga/1.fir_low_pass/1.fir_low_pass.srcs/sources_1/ip/dds_5M/dds_5M_stub.v
// Design      : dds_5M
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tfgg484-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dds_compiler_v6_0_18,Vivado 2019.1" *)
module dds_5M(aclk, m_axis_data_tvalid, m_axis_data_tdata, 
  m_axis_phase_tvalid, m_axis_phase_tdata)
/* synthesis syn_black_box black_box_pad_pin="aclk,m_axis_data_tvalid,m_axis_data_tdata[15:0],m_axis_phase_tvalid,m_axis_phase_tdata[31:0]" */;
  input aclk;
  output m_axis_data_tvalid;
  output [15:0]m_axis_data_tdata;
  output m_axis_phase_tvalid;
  output [31:0]m_axis_phase_tdata;
endmodule
