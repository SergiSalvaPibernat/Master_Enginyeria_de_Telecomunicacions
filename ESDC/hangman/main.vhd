library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity main is
	port(	clk, nrst, game_done, user_word_ready: in std_logic;
			char: in std_logic_vector (7 downto 0);
			get_word, game_over, start_game,ack_flag: out std_logic);
end main;

architecture arc of main is
	type state_type is (w_start,s_ack, enter_code, w_user_word,s_start_game, w_game ,s_end);
	signal st : state_type;
	signal start: std_logic;
	signal J_GO : std_logic;
	signal K_GO : std_logic;
begin

	-- States machine
	process(clk, nrst) begin 
		if nrst = '0' then
			st <= w_start;
		elsif clk'event and clk = '1' then
			case st is
				when w_start =>
					if (start = '1') then
						st <= s_ack;
					end if;
				when s_ack =>
					st <= enter_code;
				when enter_code =>
					st <= w_user_word;
				when w_user_word =>
					if (user_word_ready = '1') then
						st <= s_start_game;
					end if;
				when s_start_game =>
					st <= w_game;
				when w_game =>
					if game_done = '1' then
						st <= s_end;
					end if;
				when s_end =>
					st <= w_start;
			end case;
		end if;
	end process;
	
	
	-- Combinacional circuit to activate the start
	-- signal when a #1 is received form keyboard
	process(char)
	begin
		if st = w_start then
			if char = x"31" then
				start <= '1';
			else
				start <= '0';
			end if;
		end if;
	end process;
	
	-- JK flip-flop
	process(clk,nrst,J_GO,K_GO)
	begin
		if nrst = '0' then
			game_over <= '1';
		elsif (clk'event and clk = '1') then
			if J_GO = '1' then
				game_over <= '1';
			elsif K_GO = '1' then
				game_over <= '0';
			end if;
		end if;
	end process;

K_GO <= '1' when st = enter_code else '0';
J_GO <= '1' when st = s_end else '0';
get_word <= '1' when st = enter_code else '0';
ack_flag <= '1' when st = s_ack else '0';
start_game <= '1' when st = s_start_game else '0';
	
end arc;