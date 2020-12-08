//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
//Date        : Fri Nov 27 16:27:46 2020
//Host        : LAPTOP-BCHII1Q0 running 64-bit major release  (build 9200)
//Command     : generate_target ecat_tb_wrapper.bd
//Design      : ecat_tb_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module ecat_tb_wrapper
   (DDR_addr,
    DDR_ba,
    DDR_cas_n,
    DDR_ck_n,
    DDR_ck_p,
    DDR_cke,
    DDR_cs_n,
    DDR_dm,
    DDR_dq,
    DDR_dqs_n,
    DDR_dqs_p,
    DDR_odt,
    DDR_ras_n,
    DDR_reset_n,
    DDR_we_n,
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    clk_in1_0,
    mdc_1,
    mdio_1,
    mdio_rtl_0_mdc,
    mdio_rtl_0_mdio_io,
    rx_ctl_0,
    rxd0_0,
    rxd1_0,
    rxd2_0,
    rxd3_0,
    tx_clk_0,
    tx_ctl_0,
    txd0_0,
    txd1_0,
    txd2_0,
    txd3_0);
  inout [14:0]DDR_addr;
  inout [2:0]DDR_ba;
  inout DDR_cas_n;
  inout DDR_ck_n;
  inout DDR_ck_p;
  inout DDR_cke;
  inout DDR_cs_n;
  inout [3:0]DDR_dm;
  inout [31:0]DDR_dq;
  inout [3:0]DDR_dqs_n;
  inout [3:0]DDR_dqs_p;
  inout DDR_odt;
  inout DDR_ras_n;
  inout DDR_reset_n;
  inout DDR_we_n;
  inout FIXED_IO_ddr_vrn;
  inout FIXED_IO_ddr_vrp;
  inout [53:0]FIXED_IO_mio;
  inout FIXED_IO_ps_clk;
  inout FIXED_IO_ps_porb;
  inout FIXED_IO_ps_srstb;
  input clk_in1_0;
  output mdc_1;
  inout mdio_1;
  output mdio_rtl_0_mdc;
  inout mdio_rtl_0_mdio_io;
  input rx_ctl_0;
  input rxd0_0;
  input rxd1_0;
  input rxd2_0;
  input rxd3_0;
  output tx_clk_0;
  output [0:0]tx_ctl_0;
  output [0:0]txd0_0;
  output [0:0]txd1_0;
  output [0:0]txd2_0;
  output [0:0]txd3_0;

  wire [14:0]DDR_addr;
  wire [2:0]DDR_ba;
  wire DDR_cas_n;
  wire DDR_ck_n;
  wire DDR_ck_p;
  wire DDR_cke;
  wire DDR_cs_n;
  wire [3:0]DDR_dm;
  wire [31:0]DDR_dq;
  wire [3:0]DDR_dqs_n;
  wire [3:0]DDR_dqs_p;
  wire DDR_odt;
  wire DDR_ras_n;
  wire DDR_reset_n;
  wire DDR_we_n;
  wire FIXED_IO_ddr_vrn;
  wire FIXED_IO_ddr_vrp;
  wire [53:0]FIXED_IO_mio;
  wire FIXED_IO_ps_clk;
  wire FIXED_IO_ps_porb;
  wire FIXED_IO_ps_srstb;
  wire clk_in1_0;
  wire mdc_1;
  wire mdio_1;
  wire mdio_rtl_0_mdc;
  wire mdio_rtl_0_mdio_i;
  wire mdio_rtl_0_mdio_io;
  wire mdio_rtl_0_mdio_o;
  wire mdio_rtl_0_mdio_t;
  wire rx_ctl_0;
  wire rxd0_0;
  wire rxd1_0;
  wire rxd2_0;
  wire rxd3_0;
  wire tx_clk_0;
  wire [0:0]tx_ctl_0;
  wire [0:0]txd0_0;
  wire [0:0]txd1_0;
  wire [0:0]txd2_0;
  wire [0:0]txd3_0;

  ecat_tb ecat_tb_i
       (.DDR_addr(DDR_addr),
        .DDR_ba(DDR_ba),
        .DDR_cas_n(DDR_cas_n),
        .DDR_ck_n(DDR_ck_n),
        .DDR_ck_p(DDR_ck_p),
        .DDR_cke(DDR_cke),
        .DDR_cs_n(DDR_cs_n),
        .DDR_dm(DDR_dm),
        .DDR_dq(DDR_dq),
        .DDR_dqs_n(DDR_dqs_n),
        .DDR_dqs_p(DDR_dqs_p),
        .DDR_odt(DDR_odt),
        .DDR_ras_n(DDR_ras_n),
        .DDR_reset_n(DDR_reset_n),
        .DDR_we_n(DDR_we_n),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
        .clk_in1_0(clk_in1_0),
        .mdc_1(mdc_1),
        .mdio_1(mdio_1),
        .mdio_rtl_0_mdc(mdio_rtl_0_mdc),
        .mdio_rtl_0_mdio_i(mdio_rtl_0_mdio_i),
        .mdio_rtl_0_mdio_o(mdio_rtl_0_mdio_o),
        .mdio_rtl_0_mdio_t(mdio_rtl_0_mdio_t),
        .rx_ctl_0(rx_ctl_0),
        .rxd0_0(rxd0_0),
        .rxd1_0(rxd1_0),
        .rxd2_0(rxd2_0),
        .rxd3_0(rxd3_0),
        .tx_clk_0(tx_clk_0),
        .tx_ctl_0(tx_ctl_0),
        .txd0_0(txd0_0),
        .txd1_0(txd1_0),
        .txd2_0(txd2_0),
        .txd3_0(txd3_0));
  IOBUF mdio_rtl_0_mdio_iobuf
       (.I(mdio_rtl_0_mdio_o),
        .IO(mdio_rtl_0_mdio_io),
        .O(mdio_rtl_0_mdio_i),
        .T(mdio_rtl_0_mdio_t));
endmodule
