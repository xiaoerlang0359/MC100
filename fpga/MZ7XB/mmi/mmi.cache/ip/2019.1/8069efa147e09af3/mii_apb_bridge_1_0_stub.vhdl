-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Thu Nov  5 22:42:16 2020
-- Host        : LAPTOP-BCHII1Q0 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ mii_apb_bridge_1_0_stub.vhdl
-- Design      : mii_apb_bridge_1_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  Port ( 
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

end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture stub of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "psel,penable,paddr[31:0],pwdata[31:0],prdata[31:0],pwrite,pready,pslverr,valid,read,addr[15:0],wdata[7:0],rdata[7:0],ready,pclk,rst_n";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "apb_bridge,Vivado 2019.1";
begin
end;
