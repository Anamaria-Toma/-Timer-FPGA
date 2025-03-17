--------------------------------------------
-- Module Name: Program ceas digital
--------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity ceas_digital is
   Port (
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sec_out:out std_logic_vector(5 downto 0);
           min_out:out std_logic_vector(5 downto 0));
           
end ceas_digital;

architecture Behavioral of ceas_digital is

    signal secunde: std_logic_vector(5 downto 0) := "000000";
    signal minute: std_logic_vector(5 downto 0) := "000000";
    signal sec_counter : unsigned(31 downto 0) := (others => '0');
    signal min_counter : unsigned(31 downto 0) := (others => '0');

begin

process(clk, reset)
    begin
        if reset = '1' then
            secunde <= "000000";
            minute <= "000000";
            sec_counter <= (others => '0');
            min_counter <= (others => '0');
            
        elsif rising_edge(clk) then
            sec_counter <= sec_counter + 1;
            
            if sec_counter = 100000000 then
                secunde <= std_logic_vector(unsigned(secunde) + 1);
                sec_counter <= (others => '0');
                
                if secunde = "111001" then
                    secunde <= "000000";
                    min_counter <= min_counter + 1;
                    minute <= std_logic_vector(unsigned(minute) + 1);
                    if minute = "111001"then
                        minute <= "000000";
                        min_counter <= (others => '0');
                    end if;
                    
                end if;
                
            end if;
            
        end if;
    end process;

    sec_out<=secunde;
    min_out<=minute;


end Behavioral;

