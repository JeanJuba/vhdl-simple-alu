library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mult_ob is
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
end mult_ob;

architecture Behavioral of mult_ob is

	component reg 
    Port (clock 	: in  STD_LOGIC;
			 set 	   : in  STD_LOGIC;   
			 reset 	: in  STD_LOGIC;
			 input 	: in STD_LOGIC_VECTOR(3 downto 0 );
			 stored 	: BUFFER  STD_LOGIC_VECTOR(3 downto 0));
	end component;
	
	component adder
	port (a: in STD_LOGIC_VECTOR(3 downto 0);
			b: in STD_LOGIC_VECTOR(3 downto 0);
			s : out STD_LOGIC_VECTOR(3 downto 0));
	end component;
	
	component commutator
    Port ( a : in  STD_LOGIC_VECTOR(3 downto 0);
           b : in  STD_LOGIC_VECTOR(3 downto 0);
			  l : out  STD_LOGIC_VECTOR(3 downto 0);
           r : out  STD_LOGIC_VECTOR(3 downto 0));
	end component;

	component comparator_equal is
		 Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
				  b : in  STD_LOGIC_VECTOR (3 downto 0);
				  result : out  STD_LOGIC);
	end component;
		
	signal base_reg_val, times_reg_val, counter_reg_val, result_reg_val : STD_LOGIC_VECTOR(3 downto 0);
	signal adder_val, adder_counter_val, greater_val, lesser_val : STD_LOGIC_VECTOR(3 downto 0);
	
begin
	
	base_reg : reg port map (clock, set_base, reset_base, base_value, base_reg_val);
	counter_reg : reg port map (clock, set_counter, reset_counter, adder_counter_val, counter_reg_val);
	times_reg : reg port map (clock, set_times, reset_times, times_value, times_reg_val);
	result_reg : reg port map (clock, set_result, reset_result, adder_val, result_reg_val);
	
	commut : commutator port map(base_reg_val, times_reg_val, greater_val, lesser_val);
	
	add_result : adder port map (result_reg_val, greater_val, adder_val);
	add_counter : adder port map (counter_reg_val, "0001", adder_counter_val);
	
	comparat : comparator_equal port map (lesser_val, counter_reg_val, ready);
	
	result <= result_reg_val;
	
end Behavioral;

