--------------------------------------------
-- Module Name: ssd
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ssd is
Port (
    digit0: IN STD_LOGIC_VECTOR(3 downto 0);
    digit1: IN STD_LOGIC_VECTOR(3 downto 0);
    digit2: IN STD_LOGIC_VECTOR(3 downto 0);
    digit3: IN STD_LOGIC_VECTOR(3 downto 0);
    clk: IN STD_LOGIC;
    out_div: OUT STD_LOGIC_VECTOR(6 downto 0);
    an: OUT STD_LOGIC_VECTOR(3 downto 0)
    );
end ssd;

architecture Behavioral of ssd is
signal cnt: STD_LOGIC_VECTOR(15 downto 0):=x"0000";
signal mux_digit: STD_LOGIC_VECTOR(3 downto 0);

begin

process(clk)
begin
    if(clk='1' and clk'event) then
        cnt<=cnt+1;
     end if;
end process;

process(cnt(15 downto 14), digit0, digit1, digit2, digit3)
begin
    case(cnt(15 downto 14)) is
        when "00" => mux_digit<=digit0;
        when "01" => mux_digit<=digit1;
        when "10" => mux_digit<=digit2;
        when "11" => mux_digit<=digit3;
        when others =>
     end case;
end process;

process(cnt(15 downto 14))
begin
    case(cnt(15 downto 14)) is
        when "00" => an<="1110";
        when "01" => an<="1101";
        when "10" => an<="1011";
        when "11" => an<="0111";
        when others =>
     end case;
end process;

with mux_digit select
   out_div<= "1111001" when "0001",   --1
         "0100100" when "0010",   --2
         "0110000" when "0011",   --3
         "0011001" when "0100",   --4
         "0010010" when "0101",   --5
         "0000010" when "0110",   --6
         "1111000" when "0111",   --7
         "0000000" when "1000",   --8
         "0010000" when "1001",   --9
         "0001000" when "1010",   --A
         "0000011" when "1011",   --b
         "1000110" when "1100",   --C
         "0100001" when "1101",   --d
         "0000110" when "1110",   --E
         "0001110" when "1111",   --F
         "1000000" when others;   --0


end Behavioral;
