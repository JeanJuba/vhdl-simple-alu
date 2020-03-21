library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mult_cb is
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
end mult_cb;

architecture Behavioral of mult_cb is
	type state_type is (IDLE, CONFIGURE, CHECK, MULTIPLY, DISPLAY);
	
	signal estado : state_type;
	
begin

	process (clock, reset)
	begin
		
		if reset = '1' then
			estado <= IDLE;
		elsif clock'Event and clock = '1' then
			
			case (estado) is
			
				when IDLE =>
					if start = '1' then
						estado <= CONFIGURE;
					end if;
				
				when CONFIGURE =>
					estado <= CHECK;
				
				when CHECK =>
					if ready = '1' then
						estado <= DISPLAY;
					else
						estado <=  MULTIPLY;
					end if;
				
				when MULTIPLY =>
					estado <= CHECK;
				
				when DISPLAY =>
					if reset = '1' then
						estado <= IDLE;
					else
						estado <= DISPLAY;
					end if;
		
			end case;
		end if;
	end process;
	
	process (estado)
	begin 
		
		case (estado) is
			
		when IDLE =>
			set_base <= '0';
         reset_base <= '1';
         set_times <= '0';
         reset_times <= '1';
			set_counter <= '0';
			reset_counter <= '1';
         set_result <= '0';
         reset_result <= '1';
         final_result <= temp_result;
         operation_ready <= '0';
		
		when CONFIGURE =>
			set_base <= '1';
         reset_base <= '0';
         set_times <= '1';
         reset_times <= '0';
			set_counter <= '0';
			reset_counter <= '1';
         set_result <= '0';
         reset_result <= '1';
         final_result <= temp_result;
         operation_ready <= '0';
			
		when CHECK =>
			set_base <= '0';
         reset_base <= '0';
         set_times <= '0';
         reset_times <= '0';
			set_counter <= '1';
			reset_counter <= '0';
         set_result <= '1';
         reset_result <= '0';
         final_result <= temp_result;
         operation_ready <= '0';
		
		when MULTIPLY =>
			set_base <= '0';
         reset_base <= '0';
         set_times <= '0';
         reset_times <= '0';
			set_counter <= '0';
			reset_counter <= '0';
         set_result <= '0';
         reset_result <= '0';
         final_result <= temp_result;
         operation_ready <= ready;
		
		when DISPLAY =>
			set_base <= '0';
         reset_base <= '0';
         set_times <= '0';
         reset_times <= '0';
			set_counter <= '0';
			reset_counter <= '0';
         set_result <= '0';
         reset_result <= '0';
         final_result <= temp_result;
         operation_ready <= ready;

		end case;
	
	end process;

end Behavioral;

