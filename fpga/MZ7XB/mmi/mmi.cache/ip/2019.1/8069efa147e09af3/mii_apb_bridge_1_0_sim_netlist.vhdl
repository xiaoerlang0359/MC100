-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Thu Nov  5 22:42:16 2020
-- Host        : LAPTOP-BCHII1Q0 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ mii_apb_bridge_1_0_sim_netlist.vhdl
-- Design      : mii_apb_bridge_1_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg400-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  port (
    psel : in STD_LOGIC;
    penable : in STD_LOGIC;
    paddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    pwdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    prdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    pwrite : in STD_LOGIC;
    pready : out STD_LOGIC;
    pslverr : out STD_LOGIC;
    valid : out STD_LOGIC;
    read : out STD_LOGIC;
    addr : out STD_LOGIC_VECTOR ( 15 downto 0 );
    wdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    rdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    ready : in STD_LOGIC;
    pclk : in STD_LOGIC;
    rst_n : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "mii_apb_bridge_1_0,apb_bridge,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "package_project";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "apb_bridge,Vivado 2019.1";
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  signal \<const0>\ : STD_LOGIC;
  signal \^paddr\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \^pwdata\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \^rdata\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \^ready\ : STD_LOGIC;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of penable : signal is "xilinx.com:interface:apb:1.0 APB_S PENABLE";
  attribute X_INTERFACE_INFO of pready : signal is "xilinx.com:interface:apb:1.0 APB_S PREADY";
  attribute X_INTERFACE_INFO of psel : signal is "xilinx.com:interface:apb:1.0 APB_S PSEL";
  attribute X_INTERFACE_INFO of pslverr : signal is "xilinx.com:interface:apb:1.0 APB_S PSLVERR";
  attribute X_INTERFACE_INFO of pwrite : signal is "xilinx.com:interface:apb:1.0 APB_S PWRITE";
  attribute X_INTERFACE_INFO of rst_n : signal is "xilinx.com:signal:reset:1.0 rst_n RST";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of rst_n : signal is "XIL_INTERFACENAME rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of paddr : signal is "xilinx.com:interface:apb:1.0 APB_S PADDR";
  attribute X_INTERFACE_INFO of prdata : signal is "xilinx.com:interface:apb:1.0 APB_S PRDATA";
  attribute X_INTERFACE_INFO of pwdata : signal is "xilinx.com:interface:apb:1.0 APB_S PWDATA";
begin
  \^paddr\(15 downto 0) <= paddr(15 downto 0);
  \^pwdata\(7 downto 0) <= pwdata(7 downto 0);
  \^rdata\(7 downto 0) <= rdata(7 downto 0);
  \^ready\ <= ready;
  addr(15 downto 0) <= \^paddr\(15 downto 0);
  prdata(31) <= \<const0>\;
  prdata(30) <= \<const0>\;
  prdata(29) <= \<const0>\;
  prdata(28) <= \<const0>\;
  prdata(27) <= \<const0>\;
  prdata(26) <= \<const0>\;
  prdata(25) <= \<const0>\;
  prdata(24) <= \<const0>\;
  prdata(23) <= \<const0>\;
  prdata(22) <= \<const0>\;
  prdata(21) <= \<const0>\;
  prdata(20) <= \<const0>\;
  prdata(19) <= \<const0>\;
  prdata(18) <= \<const0>\;
  prdata(17) <= \<const0>\;
  prdata(16) <= \<const0>\;
  prdata(15) <= \<const0>\;
  prdata(14) <= \<const0>\;
  prdata(13) <= \<const0>\;
  prdata(12) <= \<const0>\;
  prdata(11) <= \<const0>\;
  prdata(10) <= \<const0>\;
  prdata(9) <= \<const0>\;
  prdata(8) <= \<const0>\;
  prdata(7 downto 0) <= \^rdata\(7 downto 0);
  pready <= \^ready\;
  pslverr <= \<const0>\;
  wdata(7 downto 0) <= \^pwdata\(7 downto 0);
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
read_INST_0: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => pwrite,
      O => read
    );
valid_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => psel,
      I1 => penable,
      O => valid
    );
end STRUCTURE;
