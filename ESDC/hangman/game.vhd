library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;

entity game is 
port(	clk, nrst, start_game, cv_done, tx_ready, opponent_ready : in std_logic;
		done_reg_gc, cvack_generated, word_ready, winner, loser, resta_vida, new_op_char, new_op_cv: in std_logic;
		activate_reg_gc, load_cv, send_gc, generate_cvack, send_op_cvack: out std_logic;
		activate_gen_inc_word, print_word, led_green, led_red, game_done: out std_logic;
		send_loser, send_winner, generate_cv, send_ready : out std_logic;
		game_veredict: out std_logic_vector(1 downto 0);
		lifes : out std_logic_vector(3 downto 0);
		frame_received, state: out std_logic);
		
end game;

architecture arc of game is
	type state_type is (w_start, s_gen_cv, w_cv, w_tx1, s_send_ready, w_op_ready, s_guess_char, w_guess_char, 
						w_tx2, s_send_gc, w_op_char, s_gen_cvack, w_cvack, w_tx3, s_send_cvack, w_rx_cvack, s_gen_iw, 
						w_word_ready, s_lcd, s_game_veredict, w_tx4, w_tx5, s_send_winner, s_send_loser);
	signal st : state_type;
	signal J_G, K_G, J_R, K_R : std_logic;
	signal int_lifes : integer;
	signal buf_lifes : std_logic_vector(3 downto 0);
	signal int_game_veredict: std_logic_vector(1 downto 0);
	
begin

	-- States machine
	process(clk, nrst) begin 
		if nrst = '0' then
			st <= w_start;
		elsif clk'event and clk = '1' then
			case st is
				when w_start =>
					if(start_game = '1') then
						st <= s_gen_cv;
					end if;
				when s_gen_cv =>
					st <= w_cv;
				when w_cv =>
					if(cv_done = '1') then
						st <= w_tx1;
					end if;
				when w_tx1 =>
					if(tx_ready = '1') then
						st <= s_send_ready;
					end if;
				when s_send_ready =>
					st <= w_op_ready;
				when w_op_ready =>
					if(opponent_ready = '1') then
						st <= s_guess_char;
					end if;
				when s_guess_char =>
					st <= w_guess_char;
				when w_guess_char =>
					if(done_reg_gc = '1') then
						st <= w_tx2;
					end if;
				when w_tx2 =>
					if(tx_ready = '1') then
						st <= s_send_gc;
					end if;
				when s_send_gc =>
					st <= w_op_char;
				when w_op_char =>
					if(new_op_char = '1') then
						st <= s_gen_cvack;
					end if;
				when s_gen_cvack =>
					st <= w_cvack;
				when w_cvack =>
					if(cvack_generated = '1') then
						st <= w_tx3;
					end if;
				when w_tx3 =>
					if (tx_ready ='1') then
						st <= s_send_cvack;
					end if;
				when s_send_cvack =>
					st <= w_rx_cvack;
				when w_rx_cvack =>
					if(new_op_cv ='1') then
						st <= s_gen_iw;
					end if;
				when s_gen_iw =>
					st <= w_word_ready;
				when w_word_ready =>
					if(word_ready = '1') then
						st <= s_lcd;
					end if;
				when s_lcd =>
					st <= s_game_veredict;
				when s_game_veredict =>
					if(int_game_veredict = "10") then
						st<= s_guess_char;
					elsif(int_game_veredict = "00") then
						st<= w_tx4;
					else
						st<= w_tx5;
					end if;
				when w_tx4 =>
					if (tx_ready ='1') then
						st <= s_send_loser;
					end if;
				when w_tx5 =>
					if (tx_ready ='1') then
						st <= s_send_winner;
					end if;
				when s_send_loser =>
					st <= w_start;
				when s_send_winner =>
					st <=w_start;
			end case;
		end if;
	end process;
	
	
	-- Combinacional circuit lifes
	process(clk, nrst, resta_vida)
	begin
		if nrst = '0' then 
			int_lifes <= 16;
		elsif (clk'event and clk = '1' and resta_vida = '1') then
			int_lifes <= int_lifes - 1;
		end if;
	end process;
	
	-- Combinacional circuit game_veredict
	process(clk, nrst, winner, loser)
	begin
		if nrst = '0' then 
			int_game_veredict <= "10";
		elsif (clk'event and clk = '1') then
			if winner = '1' then
				int_game_veredict <= "00";
			elsif loser = '1' or int_lifes = 1 then
				int_game_veredict <= "01";
			else
				int_game_veredict <= "10";
			end if;
		end if;
	end process;
	
	-- JK flip-flops
	process(clk,nrst,J_G,K_G)
	begin
		if nrst = '0' then
			led_green <= '1';
		elsif (clk'event and clk = '1') then
			if J_G = '1' then
				led_green <= '1';
			elsif K_G = '1' then
				led_green <= '0';
			end if;
		end if;
	end process;
	
	process(clk,nrst,J_R,K_R)
	begin
		if nrst = '0' then
			led_red <= '0';
		elsif (clk'event and clk = '1') then
			if J_R = '1' then
				led_red <= '1';
			elsif K_R = '1' then
				led_red <= '0';
			end if;
		end if;
	end process;
	
-- Output activations	
game_done <= '1' when st = s_send_loser or st = s_send_winner else '0';
generate_cv <= '1' when st = s_gen_cv else '0';
J_R <= '1' when st = s_gen_cv or st = s_send_gc else '0';
K_G <= '1' when st = s_gen_cv or st = s_send_gc else '0';
send_ready <= '1' when st = s_send_ready  else '0';
K_R <= '1' when st = s_guess_char else '0';
J_G <= '1' when st = s_guess_char else '0';
load_cv <= '1' when st = s_guess_char else '0';
activate_reg_gc <= '1' when st = s_guess_char else '0';
send_gc <= '1' when st = s_send_gc else '0';
generate_cvack <= '1' when st = s_gen_cvack else '0';
send_op_cvack <= '1' when st = s_send_cvack else '0';
activate_gen_inc_word <= '1' when st = s_gen_iw else '0';
print_word <= '1' when st = s_lcd else '0';
send_winner <= '1' when st = s_send_winner else '0';
send_loser <= '1' when st = s_send_loser else '0';
frame_received <= '1' when st = s_guess_char or st = s_gen_cvack or st = s_gen_iw else '0';
state <= '1' when st = w_op_ready else '0';

--direct connection
buf_lifes <=  std_logic_vector(to_unsigned(int_lifes, buf_lifes'length)-1);
--buf_lifes <= conv_std_logic_vector(int_lifes, buf_lifes'length);
lifes <= buf_lifes;
game_veredict <= int_game_veredict;
end arc;
