library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity reg_bank is
   Port (clock 	: in  STD_LOGIC;
			 set 		: in  STD_LOGIC;   --allow the register value to change
			 reset 	: in  STD_LOGIC;
			 input 	: in STD_LOGIC_VECTOR(7 downto 0 ); --the new value to be stored
			 index   : in STD_LOGIC_VECTOR(1 downto 0);
			 stored 	: BUFFER  STD_LOGIC_VECTOR(7 downto 0)); --the stored value
end reg_bank;

architecture Behavioral of reg_bank is

component reg is
    Port (clock 	: in  STD_LOGIC;
			 set 	: in  STD_LOGIC;   --allow the register value to change
			 reset 	: in  STD_LOGIC;
			 input 	: in STD_LOGIC_VECTOR(7 downto 0 ); --the new value to be stored
			 stored 	: BUFFER  STD_LOGIC_VECTOR(7 downto 0)); --the stored value
end component;

component mux_2bits is
    Port ( a : in  STD_LOGIC_VECTOR (7 downto 0);
           b : in  STD_LOGIC_VECTOR (7 downto 0);
           c : in  STD_LOGIC_VECTOR (7 downto 0);
           d : in  STD_LOGIC_VECTOR (7 downto 0);
           option : in  STD_LOGIC_VECTOR(1 downto 0);
           s : out  STD_LOGIC_VECTOR (7 downto 0));
end component;
	
	signal set_signal : STD_LOGIC_VECTOR(1 downto 0);
	signal out0, out1, out2, out3, out4, out5, out6, out7, output_signal: STD_LOGIC_VECTOR(7 downto 0);
	
begin

	reg0 : reg port map (clock, set, reset, input, out1):
	reg1 : reg port map (clock, set, reset, input, out2):
	reg2 : reg port map (clock, set, reset, input, out3):
	reg3 : reg port map (clock, set, reset, input, out4):
	reg4 : reg port map (clock, set, reset, input, out4):
	reg5 : reg port map (clock, set, reset, input, out4):
	reg6 : reg port map (clock, set, reset, input, out4):
	reg7 : reg port map (clock, set, reset, input, out4):

end Behavioral;

