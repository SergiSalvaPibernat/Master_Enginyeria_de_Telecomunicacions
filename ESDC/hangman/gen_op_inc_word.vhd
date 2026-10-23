library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity gen_op_inc_word is
	port(	clk, nrst, gen_inc_word, rb_inc_word_rdy: in std_logic;
			old_word: in std_logic_vector (127 downto 0);
			guess_char: in std_logic_vector(7 downto 0);
			rx_cvack, op_cv: in std_logic_vector (15 downto 0);
			new_word: out std_logic_vector (127 downto 0);
			word_ready, winner, resta_vida, update_word: out std_logic);
end gen_op_inc_word;

architecture arc of gen_op_inc_word is
	type state_type is (w_gen_inc_word, s_check_cvack, s_miss, s_compute_word, w_rb, s_save_word, s_compute_cv, s_compare_cv, s_winner, s_end);
	signal state	: state_type;
	signal J_WIN, K_WIN : std_logic;
	signal compute_word : std_logic;
	signal cv_int : std_logic_vector (15 downto 0);
	signal word_buff : std_logic_vector (127 downto 0);
	
begin
-- states machine
process(clk, nrst) begin 
	if nrst = '0' then
		state <= w_gen_inc_word;
	elsif clk'event and clk = '1' then
		case state is
			when w_gen_inc_word =>
				if (gen_inc_word = '1') then
					state <= s_check_cvack;
				end if;
			when s_check_cvack =>
				if (rx_cvack = x"0000") then
					state <= s_miss;
				else
					state <= s_compute_word;
				end if;
			when s_miss =>
				state <= w_gen_inc_word;
			when s_compute_word =>
				state <= w_rb;
			when w_rb =>
				if (rb_inc_word_rdy = '1') then
					state <= s_save_word;
				end if;
			when s_save_word =>
				state <= s_compute_cv;
			when s_compute_cv =>
				state <= s_compare_cv;
			when s_compare_cv =>
				if (cv_int = op_cv) then
					state <= s_winner;
				else
					state <= s_end;
				end if;
			when s_winner =>
				state <= s_end;
			when s_end =>
				state <= w_gen_inc_word;
		end case;
	end if;
end process;


-- Put the new character into the incomplete word
process(clk,nrst,compute_word)
begin
	if nrst = '0' then
		word_buff <= x"00000000000000000000000000000000";
	elsif (clk'event and clk = '1') then
		if compute_word = '1' then
			word_buff <= old_word;
			for count in 0 to 15 loop
				if(rx_cvack(count)= '1') then
					word_buff(((count*8)+7) downto (count*8)) <= guess_char;
				end if;
			end loop;
		end if;
	end if;
end process;


-- JK FF to control the winner flag
process(clk,nrst,J_WIN,K_WIN)
begin
	if nrst = '0' then
		winner <= '0';
	elsif (clk'event and clk = '1') then
		if J_WIN = '1' then
			winner <= '1';
		elsif K_WIN = '1' then
			winner <= '0';
		end if;
	end if;
end process;

-- Combinacional circuit to compute
-- the CV from the user word
process(clk,nrst,word_buff,cv_int)
begin
	if nrst = '0' then
		cv_int <= x"0000";
	elsif (clk'event and clk = '1') then
		if state = s_compute_cv then
			if word_buff(7 downto 0) = x"00" then
				cv_int(0) <= '0';
			else
				cv_int(0) <= '1';
			end if;
			if word_buff(15 downto 8) = x"00" then
				cv_int(1) <= '0';
			else
				cv_int(1) <= '1';
			end if;
			if word_buff(23 downto 16) = x"00" then
				cv_int(2) <= '0';
			else
				cv_int(2) <= '1';
			end if;
			if word_buff(31 downto 24) = x"00" then
				cv_int(3) <= '0';
			else
				cv_int(3) <= '1';
			end if;
			if word_buff(39 downto 32) = x"00" then
				cv_int(4) <= '0';
			else
				cv_int(4) <= '1';
			end if;
			if word_buff(47 downto 40) = x"00" then
				cv_int(5) <= '0';
			else
				cv_int(5) <= '1';
			end if;
			if word_buff(55 downto 48) = x"00" then
				cv_int(6) <= '0';
			else
				cv_int(6) <= '1';
			end if;
			if word_buff(63 downto 56) = x"00" then
				cv_int(7) <= '0';
			else
				cv_int(7) <= '1';
			end if;
			if word_buff(71 downto 64) = x"00" then
				cv_int(8) <= '0';
			else
				cv_int(8) <= '1';
			end if;
			if word_buff(79 downto 72) = x"00" then
				cv_int(9) <= '0';
			else
				cv_int(9) <= '1';
			end if;
			if word_buff(87 downto 80) = x"00" then
				cv_int(10) <= '0';
			else
				cv_int(10) <= '1';
			end if;
			if word_buff(95 downto 88) = x"00" then
				cv_int(11) <= '0';
			else
				cv_int(11) <= '1';
			end if;
			if word_buff(103 downto 96) = x"00" then
				cv_int(12) <= '0';
			else
				cv_int(12) <= '1';
			end if;
			if word_buff(111 downto 104) = x"00" then
				cv_int(13) <= '0';
			else
				cv_int(13) <= '1';
			end if;
			if word_buff(119 downto 112) = x"00" then
				cv_int(14) <= '0';
			else
				cv_int(14) <= '1';
			end if;
			if word_buff(127 downto 120) = x"00" then
				cv_int(15) <= '0';
			else
				cv_int(15) <= '1';
			end if;
		end if;
	end if;
end process;

resta_vida <= '1' when state = s_miss else '0';
word_ready <= '1' when state = s_miss or state = s_end else '0';
compute_word <= '1' when state = s_compute_word else '0';
update_word <= '1' when state = s_save_word else '0';
J_WIN <= '1' when state = s_winner else '0';
K_WIN <= '1' when state = s_check_cvack else '0';
new_word <= word_buff;
			
end arc;