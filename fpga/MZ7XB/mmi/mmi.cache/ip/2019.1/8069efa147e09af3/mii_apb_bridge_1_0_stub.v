// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Thu Nov  5 22:42:16 2020
// Host        : LAPTOP-BCHII1Q0 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ mii_apb_bridge_1_0_stub.v
// Design      : mii_apb_bridge_1_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "apb_bridge,Vivado 2019.1" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(psel, penable, paddr, pwdata, prdata, pwrite, pready, 
  pslverr, valid, read, addr, wdata, rdata, ready, pclk, rst_n)
/* synthesis syn_black_box black_box_pad_pin="psel,penable,paddr[31:0],pwdata[31:0],prdata[31:0],pwrite,pready,pslverr,valid,read,addr[15:0],wdata[7:0],rdata[7:0],ready,pclk,rst_n" */;
  input psel;
  input penable;
  input [31:0]paddr;
  input [31:0]pwdata;
  output [31:0]prdata;
  input pwrite;
  output pready;
  output pslverr;
  output valid;
  output read;
  output [15:0]addr;
  output [7:0]wdata;
  input [7:0]rdata;
  input ready;
  input pclk;
  input rst_n;
endmodule
