--------------------------------------------
-- Module Name: Top Module
--------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
library UNISIM;
use UNISIM.VComponents.all;
entity top_module is
Port (
          clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           an: inout STD_LOGIC_VECTOR(3 downto 0);
           out_div : out STD_LOGIC_VECTOR(6 downto 0));
end top_module;
Architecture behavior of top_module Is
component ceas_digital is
   Port (
         clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sec_out:out std_logic_vector(5 downto 0);
           min_out:out std_logic_vector(5 downto 0));
end component;

component decoder is
Port (

 sec: in std_logic_vector(5 downto 0);
 min: in std_logic_vector(5 downto 0);

digit0: out std_logic_vector(3 downto 0);
digit1: out std_logic_vector(3 downto 0);
digit2: out std_logic_vector(3 downto 0);
digit3: out std_logic_vector(3 downto 0));
end component;

component ssd is
Port (
  digit0: IN STD_LOGIC_VECTOR(3 downto 0);
    digit1: IN STD_LOGIC_VECTOR(3 downto 0);
    digit2: IN STD_LOGIC_VECTOR(3 downto 0);
    digit3: IN STD_LOGIC_VECTOR(3 downto 0);
    clk: IN STD_LOGIC;
    out_div: OUT STD_LOGIC_VECTOR(6 downto 0);
    an: OUT STD_LOGIC_VECTOR(3 downto 0));
end component;

signal sec_out: std_logic_vector(5 downto 0):= (others => '0');
signal min_out: std_logic_vector(5 downto 0):= (others => '0');
signal digit0: std_logic_vector(3 downto 0);
signal digit1: std_logic_vector(3 downto 0);
signal digit2: std_logic_vector(3 downto 0);
signal digit3: std_logic_vector(3 downto 0);
begin
avg: ceas_digital port map(
clk=>clk,
reset=>reset,
sec_out=>sec_out,
min_out=>min_out

);

decoding: decoder port map(
 sec=>sec_out,
 min=> min_out,
 digit0 => digit0,
 digit1 => digit1,
 digit2 => digit2,
 digit3 => digit3
);
seven_segment_display: ssd port map(
 digit0 => digit0,
 digit1 => digit1,
 digit2 => digit2,
 digit3 => digit3,
 clk => clk,
 out_div => out_div,
 an => an
);
end behavior;
