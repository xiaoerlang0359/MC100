-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Sun Nov  8 15:40:06 2020
-- Host        : LAPTOP-BCHII1Q0 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ mii_esi_arbt_0_0_stub.vhdl
-- Design      : mii_esi_arbt_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  Port ( 
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

end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture stub of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "ecat_sof,ecat_eof,ecat_valid,ecat_addr[15:0],ecat_wdata[7:0],ecat_read,ecat_ready,ecat_rdata[7:0],pdi_valid,pdi_addr[15:0],pdi_wdata[7:0],pdi_read,pdi_ready,pdi_rdata[7:0],sof,eof,valid,addr[15:0],wdata[7:0],read,ready,rdata[7:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "esi_arbt,Vivado 2019.1";
begin
end;
