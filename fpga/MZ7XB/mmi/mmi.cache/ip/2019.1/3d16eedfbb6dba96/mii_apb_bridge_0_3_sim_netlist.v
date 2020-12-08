// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Fri Nov  6 11:48:49 2020
// Host        : LAPTOP-BCHII1Q0 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ mii_apb_bridge_0_3_sim_netlist.v
// Design      : mii_apb_bridge_0_3
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_apb_bridge
   (wdata,
    pwdata,
    paddr);
  output [7:0]wdata;
  input [31:0]pwdata;
  input [1:0]paddr;

  wire [1:0]paddr;
  wire [31:0]pwdata;
  wire [7:0]wdata;

  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wdata[0]_INST_0 
       (.I0(pwdata[24]),
        .I1(pwdata[8]),
        .I2(paddr[0]),
        .I3(pwdata[16]),
        .I4(paddr[1]),
        .I5(pwdata[0]),
        .O(wdata[0]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wdata[1]_INST_0 
       (.I0(pwdata[25]),
        .I1(pwdata[9]),
        .I2(paddr[0]),
        .I3(pwdata[17]),
        .I4(paddr[1]),
        .I5(pwdata[1]),
        .O(wdata[1]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wdata[2]_INST_0 
       (.I0(pwdata[26]),
        .I1(pwdata[10]),
        .I2(paddr[0]),
        .I3(pwdata[18]),
        .I4(paddr[1]),
        .I5(pwdata[2]),
        .O(wdata[2]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wdata[3]_INST_0 
       (.I0(pwdata[27]),
        .I1(pwdata[11]),
        .I2(paddr[0]),
        .I3(pwdata[19]),
        .I4(paddr[1]),
        .I5(pwdata[3]),
        .O(wdata[3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wdata[4]_INST_0 
       (.I0(pwdata[28]),
        .I1(pwdata[12]),
        .I2(paddr[0]),
        .I3(pwdata[20]),
        .I4(paddr[1]),
        .I5(pwdata[4]),
        .O(wdata[4]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wdata[5]_INST_0 
       (.I0(pwdata[29]),
        .I1(pwdata[13]),
        .I2(paddr[0]),
        .I3(pwdata[21]),
        .I4(paddr[1]),
        .I5(pwdata[5]),
        .O(wdata[5]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wdata[6]_INST_0 
       (.I0(pwdata[30]),
        .I1(pwdata[14]),
        .I2(paddr[0]),
        .I3(pwdata[22]),
        .I4(paddr[1]),
        .I5(pwdata[6]),
        .O(wdata[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \wdata[7]_INST_0 
       (.I0(pwdata[31]),
        .I1(pwdata[15]),
        .I2(paddr[0]),
        .I3(pwdata[23]),
        .I4(paddr[1]),
        .I5(pwdata[7]),
        .O(wdata[7]));
endmodule

(* CHECK_LICENSE_TYPE = "mii_apb_bridge_0_3,apb_bridge,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "package_project" *) 
(* X_CORE_INFO = "apb_bridge,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (psel,
    penable,
    paddr,
    pwdata,
    prdata,
    pwrite,
    pready,
    pslverr,
    valid,
    read,
    addr,
    wdata,
    rdata,
    ready,
    clk,
    rst_n);
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 APB_S PSEL" *) input psel;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 APB_S PENABLE" *) input penable;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 APB_S PADDR" *) input [31:0]paddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 APB_S PWDATA" *) input [31:0]pwdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 APB_S PRDATA" *) output [31:0]prdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 APB_S PWRITE" *) input pwrite;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 APB_S PREADY" *) output pready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 APB_S PSLVERR" *) output pslverr;
  output valid;
  output read;
  output [15:0]addr;
  output [7:0]wdata;
  input [7:0]rdata;
  input ready;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, FREQ_HZ 25000000, PHASE 0.000, CLK_DOMAIN mii_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *) input clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst_n RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input rst_n;

  wire \<const0> ;
  wire [31:0]paddr;
  wire penable;
  wire psel;
  wire [31:0]pwdata;
  wire pwrite;
  wire [7:0]rdata;
  wire read;
  wire ready;
  wire valid;
  wire [7:0]wdata;

  assign addr[15:0] = paddr[15:0];
  assign prdata[31] = \<const0> ;
  assign prdata[30] = \<const0> ;
  assign prdata[29] = \<const0> ;
  assign prdata[28] = \<const0> ;
  assign prdata[27] = \<const0> ;
  assign prdata[26] = \<const0> ;
  assign prdata[25] = \<const0> ;
  assign prdata[24] = \<const0> ;
  assign prdata[23] = \<const0> ;
  assign prdata[22] = \<const0> ;
  assign prdata[21] = \<const0> ;
  assign prdata[20] = \<const0> ;
  assign prdata[19] = \<const0> ;
  assign prdata[18] = \<const0> ;
  assign prdata[17] = \<const0> ;
  assign prdata[16] = \<const0> ;
  assign prdata[15] = \<const0> ;
  assign prdata[14] = \<const0> ;
  assign prdata[13] = \<const0> ;
  assign prdata[12] = \<const0> ;
  assign prdata[11] = \<const0> ;
  assign prdata[10] = \<const0> ;
  assign prdata[9] = \<const0> ;
  assign prdata[8] = \<const0> ;
  assign prdata[7:0] = rdata;
  assign pready = ready;
  assign pslverr = \<const0> ;
  GND GND
       (.G(\<const0> ));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_apb_bridge inst
       (.paddr(paddr[1:0]),
        .pwdata(pwdata),
        .wdata(wdata));
  LUT1 #(
    .INIT(2'h1)) 
    read_INST_0
       (.I0(pwrite),
        .O(read));
  LUT2 #(
    .INIT(4'h8)) 
    valid_INST_0
       (.I0(psel),
        .I1(penable),
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
