-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Sun Nov  8 15:40:06 2020
-- Host        : LAPTOP-BCHII1Q0 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               D:/fpgawork/mmi/mmi.srcs/sources_1/bd/mii/ip/mii_esi_arbt_0_0/mii_esi_arbt_0_0_sim_netlist.vhdl
-- Design      : mii_esi_arbt_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg400-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity mii_esi_arbt_0_0_esi_arbt is
  port (
    addr : out STD_LOGIC_VECTOR ( 15 downto 0 );
    wdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    ecat_addr : in STD_LOGIC_VECTOR ( 15 downto 0 );
    pdi_addr : in STD_LOGIC_VECTOR ( 15 downto 0 );
    ready : in STD_LOGIC;
    ecat_wdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pdi_wdata : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of mii_esi_arbt_0_0_esi_arbt : entity is "esi_arbt";
end mii_esi_arbt_0_0_esi_arbt;

architecture STRUCTURE of mii_esi_arbt_0_0_esi_arbt is
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \addr[0]_INST_0\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \addr[10]_INST_0\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \addr[11]_INST_0\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \addr[12]_INST_0\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \addr[13]_INST_0\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \addr[14]_INST_0\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \addr[15]_INST_0\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \addr[1]_INST_0\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \addr[2]_INST_0\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \addr[3]_INST_0\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \addr[4]_INST_0\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \addr[5]_INST_0\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \addr[6]_INST_0\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \addr[7]_INST_0\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \addr[8]_INST_0\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \addr[9]_INST_0\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \wdata[0]_INST_0\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \wdata[1]_INST_0\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \wdata[2]_INST_0\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \wdata[3]_INST_0\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \wdata[4]_INST_0\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \wdata[5]_INST_0\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \wdata[6]_INST_0\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \wdata[7]_INST_0\ : label is "soft_lutpair11";
begin
\addr[0]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => ecat_addr(0),
      I1 => pdi_addr(0),
      I2 => ready,
      O => addr(0)
    );
\addr[10]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => ecat_addr(10),
      I1 => pdi_addr(10),
      I2 => ready,
      O => addr(10)
    );
\addr[11]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => ecat_addr(11),
      I1 => pdi_addr(11),
      I2 => ready,
      O => addr(11)
    );
\addr[12]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => ecat_addr(12),
      I1 => pdi_addr(12),
      I2 => ready,
      O => addr(12)
    );
\addr[13]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => ecat_addr(13),
      I1 => pdi_addr(13),
      I2 => ready,
      O => addr(13)
    );
\addr[14]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => ecat_addr(14),
      I1 => pdi_addr(14),
      I2 => ready,
      O => addr(14)
    );
\addr[15]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => ecat_addr(15),
      I1 => pdi_addr(15),
      I2 => ready,
      O => addr(15)
    );
\addr[1]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => ecat_addr(1),
      I1 => pdi_addr(1),
      I2 => ready,
      O => addr(1)
    );
\addr[2]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => ecat_addr(2),
      I1 => pdi_addr(2),
      I2 => ready,
      O => addr(2)
    );
\addr[3]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => ecat_addr(3),
      I1 => pdi_addr(3),
      I2 => ready,
      O => addr(3)
    );
\addr[4]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => ecat_addr(4),
      I1 => pdi_addr(4),
      I2 => ready,
      O => addr(4)
    );
\addr[5]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => ecat_addr(5),
      I1 => pdi_addr(5),
      I2 => ready,
      O => addr(5)
    );
\addr[6]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => ecat_addr(6),
      I1 => pdi_addr(6),
      I2 => ready,
      O => addr(6)
    );
\addr[7]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => ecat_addr(7),
      I1 => pdi_addr(7),
      I2 => ready,
      O => addr(7)
    );
\addr[8]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => ecat_addr(8),
      I1 => pdi_addr(8),
      I2 => ready,
      O => addr(8)
    );
\addr[9]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => ecat_addr(9),
      I1 => pdi_addr(9),
      I2 => ready,
      O => addr(9)
    );
\wdata[0]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => ecat_wdata(0),
      I1 => pdi_wdata(0),
      I2 => ready,
      O => wdata(0)
    );
\wdata[1]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => ecat_wdata(1),
      I1 => pdi_wdata(1),
      I2 => ready,
      O => wdata(1)
    );
\wdata[2]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => ecat_wdata(2),
      I1 => pdi_wdata(2),
      I2 => ready,
      O => wdata(2)
    );
\wdata[3]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => ecat_wdata(3),
      I1 => pdi_wdata(3),
      I2 => ready,
      O => wdata(3)
    );
\wdata[4]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => ecat_wdata(4),
      I1 => pdi_wdata(4),
      I2 => ready,
      O => wdata(4)
    );
\wdata[5]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => ecat_wdata(5),
      I1 => pdi_wdata(5),
      I2 => ready,
      O => wdata(5)
    );
\wdata[6]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => ecat_wdata(6),
      I1 => pdi_wdata(6),
      I2 => ready,
      O => wdata(6)
    );
\wdata[7]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => ecat_wdata(7),
      I1 => pdi_wdata(7),
      I2 => ready,
      O => wdata(7)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity mii_esi_arbt_0_0 is
  port (
    ecat_sof : in STD_LOGIC;
    ecat_eof : in STD_LOGIC;
    ecat_valid : in STD_LOGIC;
    ecat_addr : in STD_LOGIC_VECTOR ( 15 downto 0 );
    ecat_wdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    ecat_read : in STD_LOGIC;
    ecat_ready : out STD_LOGIC;
    ecat_rdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    pdi_valid : in STD_LOGIC;
    pdi_addr : in STD_LOGIC_VECTOR ( 15 downto 0 );
    pdi_wdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pdi_read : in STD_LOGIC;
    pdi_ready : out STD_LOGIC;
    pdi_rdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    sof : out STD_LOGIC;
    eof : out STD_LOGIC;
    valid : out STD_LOGIC;
    addr : out STD_LOGIC_VECTOR ( 15 downto 0 );
    wdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    read : out STD_LOGIC;
    ready : in STD_LOGIC;
    rdata : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of mii_esi_arbt_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of mii_esi_arbt_0_0 : entity is "mii_esi_arbt_0_0,esi_arbt,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of mii_esi_arbt_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of mii_esi_arbt_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of mii_esi_arbt_0_0 : entity is "esi_arbt,Vivado 2019.1";
end mii_esi_arbt_0_0;

architecture STRUCTURE of mii_esi_arbt_0_0 is
  signal \^ecat_eof\ : STD_LOGIC;
  signal \^ecat_sof\ : STD_LOGIC;
  signal \^rdata\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \^ready\ : STD_LOGIC;
begin
  \^ecat_eof\ <= ecat_eof;
  \^ecat_sof\ <= ecat_sof;
  \^rdata\(7 downto 0) <= rdata(7 downto 0);
  \^ready\ <= ready;
  ecat_rdata(7 downto 0) <= \^rdata\(7 downto 0);
  ecat_ready <= \^ready\;
  eof <= \^ecat_eof\;
  pdi_rdata(7 downto 0) <= \^rdata\(7 downto 0);
  sof <= \^ecat_sof\;
inst: entity work.mii_esi_arbt_0_0_esi_arbt
     port map (
      addr(15 downto 0) => addr(15 downto 0),
      ecat_addr(15 downto 0) => ecat_addr(15 downto 0),
      ecat_wdata(7 downto 0) => ecat_wdata(7 downto 0),
      pdi_addr(15 downto 0) => pdi_addr(15 downto 0),
      pdi_wdata(7 downto 0) => pdi_wdata(7 downto 0),
      ready => \^ready\,
      wdata(7 downto 0) => wdata(7 downto 0)
    );
pdi_ready_INST_0: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^ready\,
      O => pdi_ready
    );
read_INST_0: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ecat_read,
      I1 => \^ready\,
      I2 => pdi_read,
      O => read
    );
valid_INST_0: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ecat_valid,
      I1 => \^ready\,
      I2 => pdi_valid,
      O => valid
    );
end STRUCTURE;
