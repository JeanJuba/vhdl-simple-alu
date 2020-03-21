library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multiplication is
    Port ( clock : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
			  start: in STD_LOGIC;
			  first_value: STD_LOGIC_VECTOR(3 downto 0);
			  second_value: STD_LOGIC_VECTOR(3 downto 0);
           result : out  STD_LOGIC_VECTOR(3 downto 0);
			  ready : out STD_LOGIC);
	 end multiplication;

architecture Behavioral of multiplication is

	component mult_cb is
    Port ( 
			clock : in  STD_LOGIC;
         reset : in  STD_LOGIC;
			start: in STD_LOGIC;
			temp_result : in STD_LOGIC_VECTOR(3 downto 0);
         ready : in  STD_LOGIC;
			
         set_base : out  STD_LOGIC;
         reset_base : out  STD_LOGIC;
         set_times : out  STD_LOGIC;
         reset_times : out  STD_LOGIC;
			set_counter: out  STD_LOGIC;
         reset_counter : out  STD_LOGIC;
         set_result : out  STD_LOGIC;
         reset_result : out  STD_LOGIC;
		   
         final_result : out  STD_LOGIC_VECTOR(3 downto 0);
         operation_ready : out  STD_LOGIC
			);
	end component;
		
	component mult_ob is
    Port ( clock : in  STD_LOGIC;
			  base_value: in STD_LOGIC_VECTOR(3 downto 0);
			  times_value: in STD_LOGIC_VECTOR(3 downto 0);
			  set_base : in  STD_LOGIC;
			  reset_base : in  STD_LOGIC;
			  set_times : in  STD_LOGIC;
			  reset_times : in  STD_LOGIC;
			  set_counter: in STD_LOGIC;
			  reset_counter: in STD_LOGIC;
			  set_result : in  STD_LOGIC;
			  reset_result : in  STD_LOGIC;
           result : out  STD_LOGIC_VECTOR(3 downto 0);
           ready : out  STD_LOGIC);
	end component;	
		
signal set_base, set_times, set_counter, set_result : STD_LOGIC;
signal reset_base, reset_times, reset_counter, reset_result : STD_LOGIC;
signal mult_ready, operation_ready : STD_LOGIC;
signal temp_result, final_result : STD_LOGIC_VECTOR(3 downto 0);

begin

	control     : mult_cb port map(clock, reset, start, temp_result, mult_ready, set_base, reset_base, set_times, reset_times,
					set_counter, reset_counter, set_result, reset_result, final_result, operation_ready);
	
	operational : mult_ob port map (clock, first_value, second_value, set_base, reset_base, set_times, reset_times,
					set_counter, reset_counter, set_result, reset_result, temp_result, mult_ready);
					
	ready <= operation_ready;
	result <= final_result;
	

end Behavioral;

