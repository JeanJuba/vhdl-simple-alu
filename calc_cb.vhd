library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;
use ieee.std_logic_unsigned.ALL;
  
entity calc_cb is
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
end calc_cb;

architecture Behavioral of calc_cb is
	type state_type is (WAIT_INSTR, WRITE_MEM, INC_ADDRESS, PREPARE, IDLE, DECODE, SUM, SUBTRACT, MULTIPLY, WAIT_MULTIPLY, DIVIDE, WAIT_DIVIDE, RESULT, INCREMENT, RESET_STATE);
	
	signal estado: state_type;
	signal address: STD_LOGIC_VECTOR(7 downto 0) := "00000000";
	
begin
	process(clock, reset)
		begin
		
			if reset = '1' then
				estado <= RESET_STATE;
			elsif clock'Event and clock = '1' then
			
				case(estado) is
				
					when WAIT_INSTR =>
						if start = '1' then
							estado <= PREPARE;
						else
							if write_inst = '1' then
								estado <= WRITE_MEM;
							else
								estado <= WAIT_INSTR;
							end if;
						end if;
				
					when WRITE_MEM =>
							estado <= INC_ADDRESS;
					
					when INC_ADDRESS =>
						estado <= WAIT_INSTR;
						
					when PREPARE =>
						estado <= RESET_STATE;
					
					when IDLE =>
						if start = '1' then
							estado <= DECODE;
						else	
							estado <= IDLE;
						end if;
						
					when DECODE =>
					
						case (instruction(9 downto 8)) is
						
							when "00" =>
								estado <= SUM;
							
							when "01" =>
								estado <= SUBTRACT;
								
							when "10" =>
								estado <= MULTIPLY;
								
							when "11" =>
								estado <= DIVIDE;
								
							when others =>
								estado <= IDLE;
						
						end case;
						
						
					when SUM =>
						estado <= RESULT;
						
					
					when SUBTRACT =>
						estado <= RESULT;
					
					when DIVIDE =>
						estado <= WAIT_DIVIDE;
						
					when WAIT_DIVIDE =>
						if division_ready = '1' then
							estado <= RESULT;
						else
							estado <= WAIT_DIVIDE;
						end if;
					
					when MULTIPLY =>
						estado <= WAIT_MULTIPLY;
					
					when WAIT_MULTIPLY =>
						if multiplication_ready = '1' then
							estado <= RESULT;
						else
							estado <= WAIT_MULTIPLY;
						end if;
					
					when RESULT =>
						estado <= INCREMENT;
						
					when INCREMENT =>
						estado <= RESET_STATE;
						
					when RESET_STATE =>
						estado <= IDLE;
						
					when others =>
						estado <= IDLE;
					
				end case;
				
			end if;
		
		end process;
		
	process(estado)
		begin 
		
			case(estado) is
				
					when WAIT_INSTR =>
						mem_value <= instruction;
						mem_address <= address;
						mem_write <= '0';
				
					when WRITE_MEM =>
						mem_value <= instruction;
						mem_address <= address;
						mem_write <= '1';
					
					when INC_ADDRESS =>
						address <= std_logic_vector(to_unsigned(to_integer(unsigned( address )) + 1, 8));
						mem_value <= instruction;
						mem_address <= address;
						mem_write <= '0';
					
					when PREPARE =>
						address <= "00000000";
					
					when IDLE =>
						start_operation <= '0';
						reset_operation <= '1';
						mem_write <= '0';
						mem_address <= address;
						
					when DECODE =>
						reset_operation <= '0';
						op <= instruction(9 downto 8);
						first_value <= instruction(7 downto 4);
						second_value <= instruction(3 downto 0);
						
					when SUM =>
						
					when SUBTRACT =>
					
					when DIVIDE =>
						start_operation <= '1';
						
					when WAIT_DIVIDE =>
						start_operation <= '0';
						
					when MULTIPLY =>
						start_operation <= '1';
						
					when WAIT_MULTIPLY =>
						start_operation <= '0';
										
					when RESULT =>
						result_ready <= '1';
						
					when INCREMENT =>
						address <= std_logic_vector(to_unsigned(to_integer(unsigned( address )) + 1, 8));
						
					when RESET_STATE =>
						reset_operation <= '1';
						result_ready <= '0';
						
				
				end case;
				
		end process;

end Behavioral;

