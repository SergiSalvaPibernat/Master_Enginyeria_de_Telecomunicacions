library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity main is 
	port(	clk50, nrst, hash, code_entered, winer, loser, tie : in std_logic;
			new_code, key_read, game_over, new_game, LED_CODE : out std_logic);
end  main;

architecture arc of main is
	type state_type is (s0_wait, enter_code, w_code, start_game, w_game);
	signal state : state_type;

	begin process(clk50, nrst) begin
		if (nrst = '0') then
			state <= s0_wait;

		elsif (clk50'event and clk50='1') then
			case state is
			
				when s0_wait =>
					if (hash = '1') then 
						state <= enter_code;
					end if;
				
				when enter_code => 
					state <= w_code;
				
				when w_code =>
					if (code_entered = '1') then
						state <= start_game;
					end if;
				
				when start_game =>
					state <= w_game;
				
				when w_game =>
					if (winer = '1' or loser = '1' or tie = '1') then
						state <= s0_wait;

					end if;
			end case;
		end if;
	end process;
game_over <= '1' when state = s0_wait or (state = w_game and (winer = '1' or loser = '1' or tie = '1')) else '0';
LED_CODE <= '1' when state = enter_code or state = w_code else '0';
key_read <= '1' when state = enter_code else '0';
new_code <= '1' when state = enter_code else '0';
new_game <= '1' when state = start_game else '0';
end arc;
				