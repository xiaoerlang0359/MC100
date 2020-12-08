// (c) Copyright 1995-2020 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:module_ref:esi_arbt:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module mii_esi_arbt_0_0 (
  ecat_sof,
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
  rdata
);

input wire ecat_sof;
input wire ecat_eof;
input wire ecat_valid;
input wire [15 : 0] ecat_addr;
input wire [7 : 0] ecat_wdata;
input wire ecat_read;
output wire ecat_ready;
output wire [7 : 0] ecat_rdata;
input wire pdi_valid;
input wire [15 : 0] pdi_addr;
input wire [7 : 0] pdi_wdata;
input wire pdi_read;
output wire pdi_ready;
output wire [7 : 0] pdi_rdata;
output wire sof;
output wire eof;
output wire valid;
output wire [15 : 0] addr;
output wire [7 : 0] wdata;
output wire read;
input wire ready;
input wire [7 : 0] rdata;

  esi_arbt inst (
    .ecat_sof(ecat_sof),
    .ecat_eof(ecat_eof),
    .ecat_valid(ecat_valid),
    .ecat_addr(ecat_addr),
    .ecat_wdata(ecat_wdata),
    .ecat_read(ecat_read),
    .ecat_ready(ecat_ready),
    .ecat_rdata(ecat_rdata),
    .pdi_valid(pdi_valid),
    .pdi_addr(pdi_addr),
    .pdi_wdata(pdi_wdata),
    .pdi_read(pdi_read),
    .pdi_ready(pdi_ready),
    .pdi_rdata(pdi_rdata),
    .sof(sof),
    .eof(eof),
    .valid(valid),
    .addr(addr),
    .wdata(wdata),
    .read(read),
    .ready(ready),
    .rdata(rdata)
  );
endmodule
