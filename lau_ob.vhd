library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity lau_ob is
	port( clock : in STD_LOGIC;
			reset: in STD_LOGIC;
			start: in STD_LOGIC;
			mux_option: in STD_LOGIC_VECTOR(1 downto 0);
			first_value: in STD_LOGIC_VECTOR(3 downto 0);
			second_value: in STD_LOGIC_VECTOR(3 downto 0);
			division_ready: out STD_LOGIC;
			multiplication_ready: out STD_LOGIC;
			result: out STD_LOGIC_VECTOR(3 downto 0)
	);
end lau_ob;

architecture Behavioral of lau_ob is

	component division is
    Port ( clock : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
			  start: in STD_LOGIC;
			  first_value: STD_LOGIC_VECTOR(3 downto 0);
			  second_value: STD_LOGIC_VECTOR(3 downto 0);
           result : out  STD_LOGIC_VECTOR(3 downto 0);
			  ready : out STD_LOGIC);
	end component;
	
	component multiplication is
    Port ( clock : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
			  start: in STD_LOGIC;
			  first_value: STD_LOGIC_VECTOR(3 downto 0);
			  second_value: STD_LOGIC_VECTOR(3 downto 0);
           result : out  STD_LOGIC_VECTOR(3 downto 0);
			  ready : out STD_LOGIC);
	 end component;
	 
	 component adder is
    Port ( a : in  STD_LOGIC_VECTOR(3 downto 0);
           b : in  STD_LOGIC_VECTOR(3 downto 0);
           s : out  STD_LOGIC_VECTOR(3 downto 0));
	end component;
	
	component subtractor is
    Port ( a : in  STD_LOGIC_VECTOR(3 downto 0);
           b : in  STD_LOGIC_VECTOR(3 downto 0);
           s : out  STD_LOGIC_VECTOR(3 downto 0));
	end component;
	
	component mux_2bits is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           c : in  STD_LOGIC_VECTOR (3 downto 0);
           d : in  STD_LOGIC_VECTOR (3 downto 0);
           option : in  STD_LOGIC_VECTOR(1 downto 0);
           s : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;

	signal addition_result, subtraction_result, multiplication_result, division_result : STD_LOGIC_VECTOR(3 downto 0); 

begin
	
	addition: adder port map (first_value, second_value, addition_result);
	subtraction: subtractor port map (first_value, second_value, subtraction_result);
	multiplier: multiplication port map (clock, reset, start, first_value, second_value, multiplication_result, multiplication_ready);
	divider: division port map (clock, reset, start, first_value, second_value, division_result, division_ready);
	
	mux_2b : mux_2bits port map (addition_result, subtraction_result, multiplication_result, division_result, mux_option, result);
	
end Behavioral;

