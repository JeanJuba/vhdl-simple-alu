library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity calculator is
 Port (
	clock: in STD_LOGIC;
	reset: in STD_LOGIC;
	start: in STD_LOGIC;
	instruction: in STD_LOGIC_VECTOR(9 downto 0);
	wr : in STD_LOGIC;
	result: out STD_LOGIC_VECTOR(3 downto 0);
	result_ready: out STD_LOGIC
 );
end calculator;

architecture Behavioral of calculator is

	component SyncRAM is 
	port(
		clock : in std_logic;
		we: in std_logic;
		address : in std_logic_vector (7 downto 0);
		datain: in std_logic_vector (9 downto 0);
		dataout: out std_logic_vector (9 downto 0)
	);
	end component;

	component calc_cb is
		Port (
			clock: in STD_LOGIC;
			reset: in STD_LOGIC;
			start: in STD_LOGIC;
			write_inst: in STD_LOGIC;
			instruction: in STD_LOGIC_VECTOR(9 downto 0);
			multiplication_ready: in STD_LOGIC;
			division_ready: in STD_LOGIC;
			op: out STD_LOGIC_VECTOR(1 downto 0);
			first_value: out STD_LOGIC_VECTOR(3 downto 0);
			second_value: out STD_LOGIC_VECTOR(3 downto 0);
			start_operation: out STD_LOGIC;
			reset_operation: out STD_LOGIC;
			result_ready: out STD_LOGIC;
			mem_value: out STD_LOGIC_VECTOR(9 downto 0);
			mem_address: out STD_LOGIC_VECTOR(7 downto 0);
			mem_write: out STD_lOGIC
		);
	end component;
	
	component lau_ob is
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
	end component;
	
	signal sg_multiplication_ready, sg_division_ready, sg_start_operation, sg_reset_operation, sg_mem_write : STD_LOGIC;
	signal sg_op : STD_LOGIC_VECTOR(1 downto 0);
	signal sg_first_value, sg_second_value, sg_result: STD_LOGIC_VECTOR(3 downto 0);
	signal sg_address : STD_LOGIC_VECTOR(7 downto 0);
	signal sg_value_in, sg_value_out : STD_LOGIC_VECTOR(9 downto 0);

begin
	
	memory : SyncRAM port map (clock, sg_mem_write, sg_address, instruction, sg_value_out);
	
	control : calc_cb port map (clock, reset, start, wr, sg_value_out, sg_multiplication_ready,
										sg_division_ready, sg_op, sg_first_value, sg_second_value, sg_start_operation, sg_reset_operation,
										result_ready, sg_value_in, sg_address, sg_mem_write);
										
	operational : lau_ob port map (clock, sg_reset_operation, sg_start_operation, sg_op, sg_first_value, sg_second_value,
											 sg_division_ready, sg_multiplication_ready, result);

end Behavioral;

