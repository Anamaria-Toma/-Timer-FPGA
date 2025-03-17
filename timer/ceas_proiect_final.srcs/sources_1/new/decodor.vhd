--------------------------------------------
-- Module Name: Decoder
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity decoder is
Port (
 sec: in std_logic_vector(5 downto 0);
 min: in std_logic_vector(5 downto 0);

digit0: out std_logic_vector(3 downto 0);
digit1: out std_logic_vector(3 downto 0);
digit2: out std_logic_vector(3 downto 0);
digit3: out std_logic_vector(3 downto 0));
end decoder;

architecture Behavioral of decoder is

begin



output_process: process(sec, min)
begin
    --reguli generale de obtinere a cifrelor
    digit0 <= conv_std_logic_vector((conv_integer(sec) mod 10), 4);
    digit1 <= conv_std_logic_vector((conv_integer(sec)/10) , 4);
    digit2 <= conv_std_logic_vector((conv_integer(min) mod 10), 4);
    digit3 <= conv_std_logic_vector((conv_integer(min)/10) , 4);
end process;

end Behavioral;
