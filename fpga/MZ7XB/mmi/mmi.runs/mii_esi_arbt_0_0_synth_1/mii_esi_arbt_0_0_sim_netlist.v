// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sun Nov  8 15:40:06 2020
// Host        : LAPTOP-BCHII1Q0 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ mii_esi_arbt_0_0_sim_netlist.v
// Design      : mii_esi_arbt_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_esi_arbt
   (addr,
    wdata,
    ecat_addr,
    pdi_addr,
    ready,
    ecat_wdata,
    pdi_wdata);
  output [15:0]addr;
  output [7:0]wdata;
  input [15:0]ecat_addr;
  input [15:0]pdi_addr;
  input ready;
  input [7:0]ecat_wdata;
  input [7:0]pdi_wdata;

  wire [15:0]addr;
  wire [15:0]ecat_addr;
  wire [7:0]ecat_wdata;
  wire [15:0]pdi_addr;
  wire [7:0]pdi_wdata;
  wire ready;
  wire [7:0]wdata;

  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \addr[0]_INST_0 
       (.I0(ecat_addr[0]),
        .I1(pdi_addr[0]),
        .I2(ready),
        .O(addr[0]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \addr[10]_INST_0 
       (.I0(ecat_addr[10]),
        .I1(pdi_addr[10]),
        .I2(ready),
        .O(addr[10]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \addr[11]_INST_0 
       (.I0(ecat_addr[11]),
        .I1(pdi_addr[11]),
        .I2(ready),
        .O(addr[11]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \addr[12]_INST_0 
       (.I0(ecat_addr[12]),
        .I1(pdi_addr[12]),
        .I2(ready),
        .O(addr[12]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \addr[13]_INST_0 
       (.I0(ecat_addr[13]),
        .I1(pdi_addr[13]),
        .I2(ready),
        .O(addr[13]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \addr[14]_INST_0 
       (.I0(ecat_addr[14]),
        .I1(pdi_addr[14]),
        .I2(ready),
        .O(addr[14]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \addr[15]_INST_0 
       (.I0(ecat_addr[15]),
        .I1(pdi_addr[15]),
        .I2(ready),
        .O(addr[15]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \addr[1]_INST_0 
       (.I0(ecat_addr[1]),
        .I1(pdi_addr[1]),
        .I2(ready),
        .O(addr[1]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \addr[2]_INST_0 
       (.I0(ecat_addr[2]),
        .I1(pdi_addr[2]),
        .I2(ready),
        .O(addr[2]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \addr[3]_INST_0 
       (.I0(ecat_addr[3]),
        .I1(pdi_addr[3]),
        .I2(ready),
        .O(addr[3]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \addr[4]_INST_0 
       (.I0(ecat_addr[4]),
        .I1(pdi_addr[4]),
        .I2(ready),
        .O(addr[4]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \addr[5]_INST_0 
       (.I0(ecat_addr[5]),
        .I1(pdi_addr[5]),
        .I2(ready),
        .O(addr[5]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \addr[6]_INST_0 
       (.I0(ecat_addr[6]),
        .I1(pdi_addr[6]),
        .I2(ready),
        .O(addr[6]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \addr[7]_INST_0 
       (.I0(ecat_addr[7]),
        .I1(pdi_addr[7]),
        .I2(ready),
        .O(addr[7]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \addr[8]_INST_0 
       (.I0(ecat_addr[8]),
        .I1(pdi_addr[8]),
        .I2(ready),
        .O(addr[8]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \addr[9]_INST_0 
       (.I0(ecat_addr[9]),
        .I1(pdi_addr[9]),
        .I2(ready),
        .O(addr[9]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \wdata[0]_INST_0 
       (.I0(ecat_wdata[0]),
        .I1(pdi_wdata[0]),
        .I2(ready),
        .O(wdata[0]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \wdata[1]_INST_0 
       (.I0(ecat_wdata[1]),
        .I1(pdi_wdata[1]),
        .I2(ready),
        .O(wdata[1]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \wdata[2]_INST_0 
       (.I0(ecat_wdata[2]),
        .I1(pdi_wdata[2]),
        .I2(ready),
        .O(wdata[2]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \wdata[3]_INST_0 
       (.I0(ecat_wdata[3]),
        .I1(pdi_wdata[3]),
        .I2(ready),
        .O(wdata[3]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \wdata[4]_INST_0 
       (.I0(ecat_wdata[4]),
        .I1(pdi_wdata[4]),
        .I2(ready),
        .O(wdata[4]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \wdata[5]_INST_0 
       (.I0(ecat_wdata[5]),
        .I1(pdi_wdata[5]),
        .I2(ready),
        .O(wdata[5]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \wdata[6]_INST_0 
       (.I0(ecat_wdata[6]),
        .I1(pdi_wdata[6]),
        .I2(ready),
        .O(wdata[6]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \wdata[7]_INST_0 
       (.I0(ecat_wdata[7]),
        .I1(pdi_wdata[7]),
        .I2(ready),
        .O(wdata[7]));
endmodule

(* CHECK_LICENSE_TYPE = "mii_esi_arbt_0_0,esi_arbt,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "esi_arbt,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (ecat_sof,
    ecat_eof,
    ecat_valid,
    ecat_addr,
    ecat_wdata,
    ecat_read,
    ecat_ready,
    ecat_rdata,
    pdi_valid,
    pdi_addr,
    pdi_wdata,
    pdi_read,
    pdi_ready,
    pdi_rdata,
    sof,
    eof,
    valid,
    addr,
    wdata,
    read,
    ready,
    rdata);
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

  wire [15:0]addr;
  wire [15:0]ecat_addr;
  wire ecat_eof;
  wire ecat_read;
  wire ecat_sof;
  wire ecat_valid;
  wire [7:0]ecat_wdata;
  wire [15:0]pdi_addr;
  wire pdi_read;
  wire pdi_ready;
  wire pdi_valid;
  wire [7:0]pdi_wdata;
  wire [7:0]rdata;
  wire read;
  wire ready;
  wire valid;
  wire [7:0]wdata;

  assign ecat_rdata[7:0] = rdata;
  assign ecat_ready = ready;
  assign eof = ecat_eof;
  assign pdi_rdata[7:0] = rdata;
  assign sof = ecat_sof;
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_esi_arbt inst
       (.addr(addr),
        .ecat_addr(ecat_addr),
        .ecat_wdata(ecat_wdata),
        .pdi_addr(pdi_addr),
        .pdi_wdata(pdi_wdata),
        .ready(ready),
        .wdata(wdata));
  LUT1 #(
    .INIT(2'h1)) 
    pdi_ready_INST_0
       (.I0(ready),
        .O(pdi_ready));
  LUT3 #(
    .INIT(8'hB8)) 
    read_INST_0
       (.I0(ecat_read),
        .I1(ready),
        .I2(pdi_read),
        .O(read));
  LUT3 #(
    .INIT(8'hB8)) 
    valid_INST_0
       (.I0(ecat_valid),
        .I1(ready),
        .I2(pdi_valid),
        .O(valid));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
