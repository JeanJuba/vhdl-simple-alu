LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY comparator_zero IS
	PORT (
		input	: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		zero: OUT STD_LOGIC
	);
END comparator_zero;

ARCHITECTURE Behavioral OF comparator_zero IS
BEGIN
	zero <= '1' WHEN input = "0000" ELSE '0';--True if the input is zero
END Behavioral;