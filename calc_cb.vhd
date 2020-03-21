library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity calc_cb is
	Port (
		clock: in STD_LOGIC;
		reset: in STD_LOGIC;
		start: in STD_LOGIC;
		instruction: in STD_LOGIC_VECTOR(9 downto 0);
		multiplication_ready: in STD_LOGIC;
		division_ready: in STD_LOGIC;
		op: out STD_LOGIC_VECTOR(1 downto 0);
		first_value: out STD_LOGIC_VECTOR(3 downto 0);
		second_value: out STD_LOGIC_VECTOR(3 downto 0);
		start_operation: out STD_LOGIC;
		reset_operation: out STD_LOGIC;
		result_ready: out STD_LOGIC
	);
end calc_cb;

architecture Behavioral of calc_cb is
	type state_type is (IDLE, DECODE, SUM, SUBTRACT, MULTIPLY, WAIT_MULTIPLY, DIVIDE, WAIT_DIVIDE, RESULT, RESET_STATE);
	
	signal estado: state_type;
begin
	process(clock, reset)
		begin
		
			if reset = '1' then
				estado <= RESET_STATE;
			elsif clock'Event and clock = '1' then
			
				case(estado) is
				
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
				
					when IDLE =>
						start_operation <= '0';
						reset_operation <= '1';
						
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
						
					when RESET_STATE =>
						reset_operation <= '1';
						result_ready <= '0';
				
				end case;
				
		end process;

end Behavioral;

