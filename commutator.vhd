library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity commutator is
    Port ( a : in  STD_LOGIC_VECTOR(3 downto 0);
           b : in  STD_LOGIC_VECTOR(3 downto 0);
			  l : out  STD_LOGIC_VECTOR(3 downto 0);
           r : out  STD_LOGIC_VECTOR(3 downto 0));
end commutator;

architecture Behavioral of commutator is

begin
	
	l <= a when a > b else b;
	r <= a when a < b else b;
	
end Behavioral;

