library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg is
    Port (clock 	: in  STD_LOGIC;
			 set 	: in  STD_LOGIC;   --allow the register value to change
			 reset 	: in  STD_LOGIC;
			 input 	: in STD_LOGIC_VECTOR(3 downto 0 ); --the new value to be stored
			 stored 	: BUFFER  STD_LOGIC_VECTOR(3 downto 0)); --the stored value
end reg;

architecture Behavioral of reg is
	
begin
process(clock, reset) 
 
begin
	if reset = '1' then
		stored <= "0000";
	elsif (clock'Event and clock = '1' and set = '1') then
		stored <= input;
	end if;
end process;
	
end Behavioral;

