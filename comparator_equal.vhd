library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comparator_equal is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           result : out  STD_LOGIC);
end comparator_equal;

architecture Behavioral of comparator_equal is

begin

	result <= '1' when a = b else '0';

end Behavioral;

