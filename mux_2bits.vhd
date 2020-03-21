library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux_2bits is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           c : in  STD_LOGIC_VECTOR (3 downto 0);
           d : in  STD_LOGIC_VECTOR (3 downto 0);
           option : in  STD_LOGIC_VECTOR(1 downto 0);
           s : out  STD_LOGIC_VECTOR (3 downto 0));
end mux_2bits;

architecture Behavioral of mux_2bits is

begin
	
	s <= a when option = "00" else b when option = "01" else c when option = "10" else d when option = "11";

end Behavioral;

