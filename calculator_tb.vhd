-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY testbench IS
  END testbench;

  ARCHITECTURE behavior OF testbench IS 
      
	
   signal clock : std_logic := '0';
	signal reset : std_logic := '0';
   signal start : std_logic := '0';
	signal instruction : std_logic_vector(9 downto 0) := "0000000000";
   signal result : std_logic_vector(3 downto 0);
   signal result_ready : std_logic;

   -- Clock period definitions
   constant clock_period : time := 10 ns;

  BEGIN

	  uut: entity work.calculator PORT MAP (
         clock => clock,
			reset => reset,
			start => start,
			instruction => instruction,
			result => result,
			result_ready => result_ready
     );

	  clock_process :process
		begin
			clock <= '0';
			wait for clock_period/2;
			clock <= '1';
			wait for clock_period/2;
		end process;
	
		reset<= '1', '0' after 20 ns;
		start <= '0', '1' after 20 ns;
		instruction <= "1001010011";

  END;
