library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity div_ob is
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
end div_ob;

architecture Behavioral of div_ob is

	component reg 
    port (clock 	: in  STD_LOGIC;
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
	
	component subtractor is
    port ( a : in  STD_LOGIC_VECTOR(3 downto 0);
           b : in  STD_LOGIC_VECTOR(3 downto 0);
           s : out  STD_LOGIC_VECTOR(3 downto 0));
	end component;
	
	component comparator_zero IS
	port (
		input	: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		zero: OUT STD_LOGIC
	);
	end component;
	
	component mux is
    port ( a, b	: in  STD_LOGIC_VECTOR(3 downto 0);
           opt 	: in  STD_LOGIC;
           s 	: out  STD_LOGIC_VECTOR(3 downto 0));
	end component;
	
	signal is_base_zero : STD_LOGIC;
	signal base_reg_value, counter_reg_val, divider_reg_value, result_reg_value : STD_LOGIC_VECTOR(3 downto 0);
	signal adder_counter_val, sub_result, mux_result, counter_adition: STD_LOGIC_VECTOR (3 downto 0);
	
begin

	base_reg : reg port map(clock, set_base, reset_base, base_value, base_reg_value);
	counter_reg : reg port map (clock, set_counter, reset_counter, adder_counter_val, counter_reg_val);
	divider_reg : reg port map(clock, set_divider, reset_divider, divider_value, divider_reg_value);
	
	mx: mux port map (sub_result, base_value, start, mux_result); --in the first cycle sets base value as the default value
	result_reg : reg port map(clock, set_result, reset_result, mux_result, result_reg_value);
	
	subtraction : subtractor port map (result_reg_value, divider_reg_value, sub_result);
	special_comparator: comparator_zero port map (base_reg_value, is_base_zero);
	special_mux : mux port map("0001", "0000", is_base_zero, counter_adition);
	add_counter : adder port map (counter_reg_val, counter_adition, adder_counter_val);
	comparator: comparator_zero port map (sub_result, ready);
	
	result <= adder_counter_val;
	
end Behavioral;

