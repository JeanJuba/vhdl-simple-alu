library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity subtractor is
    Port ( a : in  STD_LOGIC_VECTOR(3 downto 0);
           b : in  STD_LOGIC_VECTOR(3 downto 0);
           s : out  STD_LOGIC_VECTOR(3 downto 0));
end subtractor;

architecture Behavioral of subtractor is

begin

	s <= a - b when a > "0000" else "0000";

end Behavioral;

