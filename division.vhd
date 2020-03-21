library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity division is
    Port ( clock : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
			  start: in STD_LOGIC;
			  first_value: STD_LOGIC_VECTOR(3 downto 0);
			  second_value: STD_LOGIC_VECTOR(3 downto 0);
           result : out  STD_LOGIC_VECTOR(3 downto 0);
			  ready : out STD_LOGIC);
end division;

architecture Behavioral of division is

	component div_cb is
    Port (clock : in  STD_LOGIC;
         reset : in  STD_LOGIC;
			start: in STD_LOGIC;
			temp_result : in STD_LOGIC_VECTOR(3 downto 0);
         ready : in  STD_LOGIC;
			
			start_signal: out STD_LOGIC;
         set_base : out  STD_LOGIC;
         reset_base : out  STD_LOGIC;
         set_divider : out  STD_LOGIC;
         reset_divider : out  STD_LOGIC;
			set_counter: out  STD_LOGIC;
         reset_counter : out  STD_LOGIC;
         set_result : out  STD_LOGIC;
         reset_result : out  STD_LOGIC;
		   
         final_result : out  STD_LOGIC_VECTOR(3 downto 0);
         operation_ready : out  STD_LOGIC
			  );
	end component;

	component div_ob is
    port ( clock : in  STD_LOGIC;
			  start: in STD_LOGIC;
			  base_value: in STD_LOGIC_VECTOR(3 downto 0);
			  divider_value: in STD_LOGIC_VECTOR(3 downto 0);
			  set_base : in  STD_LOGIC;
			  reset_base : in  STD_LOGIC;
			  set_divider : in  STD_LOGIC;
			  reset_divider : in  STD_LOGIC;
			  set_counter: in STD_LOGIC;
			  reset_counter: in STD_LOGIC;
			  set_result : in  STD_LOGIC;
			  reset_result : in  STD_LOGIC;
           result : out  STD_LOGIC_VECTOR(3 downto 0);
           ready : out  STD_LOGIC);
	end component;
	
	signal start_signal, set_base, set_divider, set_counter, set_result : STD_LOGIC;
	signal reset_base, reset_divider, reset_counter, reset_result : STD_LOGIC;
	signal division_ready, operation_ready : STD_LOGIC;
	signal temp_result, final_result : STD_LOGIC_VECTOR(3 downto 0);

begin

	control     : div_cb port map(clock, reset, start, temp_result, division_ready, start_signal, set_base, reset_base, set_divider, reset_divider,
					set_counter, reset_counter, set_result, reset_result, final_result, operation_ready);
	
	operational : div_ob port map (clock, start_signal, first_value, second_value, set_base, reset_base, set_divider, reset_divider,
					set_counter, reset_counter, set_result, reset_result, temp_result, division_ready);
					 
	ready <= operation_ready;
	result <= final_result;


end Behavioral;

