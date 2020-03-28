LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

 
ENTITY Test_RAM IS
END Test_RAM;
 
ARCHITECTURE behavior OF Test_RAM IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SyncRAM
    PORT(
         clock : IN  std_logic;
         we : IN  std_logic;
         address : IN  std_logic_vector(7 downto 0);
         datain : IN  std_logic_vector(7 downto 0);
         dataout : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal we : std_logic := '0';
   signal address : std_logic_vector(7 downto 0) := (others => '0');
   signal datain : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal dataout : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SyncRAM PORT MAP (
          clock => clock,
          we => we,
          address => address,
          datain => datain,
          dataout => dataout
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      datain <= "1000000000";
		we <= '1';
		wait for 20ns;
		we <= '0';
		wait for 20ns;
		
		address <= "0000000001";
		datain <= "1111111111";
		we <= '1';
		wait for 40ns;
		we <= '0';
		wait for 20ns;
		
   end process;

END;
