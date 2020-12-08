// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sun Nov  8 15:40:06 2020
// Host        : LAPTOP-BCHII1Q0 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               D:/fpgawork/mmi/mmi.srcs/sources_1/bd/mii/ip/mii_esi_arbt_0_0/mii_esi_arbt_0_0_stub.v
// Design      : mii_esi_arbt_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "esi_arbt,Vivado 2019.1" *)
module mii_esi_arbt_0_0(ecat_sof, ecat_eof, ecat_valid, ecat_addr, 
  ecat_wdata, ecat_read, ecat_ready, ecat_rdata, pdi_valid, pdi_addr, pdi_wdata, pdi_read, 
  pdi_ready, pdi_rdata, sof, eof, valid, addr, wdata, read, ready, rdata)
/* synthesis syn_black_box black_box_pad_pin="ecat_sof,ecat_eof,ecat_valid,ecat_addr[15:0],ecat_wdata[7:0],ecat_read,ecat_ready,ecat_rdata[7:0],pdi_valid,pdi_addr[15:0],pdi_wdata[7:0],pdi_read,pdi_ready,pdi_rdata[7:0],sof,eof,valid,addr[15:0],wdata[7:0],read,ready,rdata[7:0]" */;
  input ecat_sof;
  input ecat_eof;
  input ecat_valid;
  input [15:0]ecat_addr;
  input [7:0]ecat_wdata;
  input ecat_read;
  output ecat_ready;
  output [7:0]ecat_rdata;
  input pdi_valid;
  input [15:0]pdi_addr;
  input [7:0]pdi_wdata;
  input pdi_read;
  output pdi_ready;
  output [7:0]pdi_rdata;
  output sof;
  output eof;
  output valid;
  output [15:0]addr;
  output [7:0]wdata;
  output read;
  input ready;
  input [7:0]rdata;
endmodule
