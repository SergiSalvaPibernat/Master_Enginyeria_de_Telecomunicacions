library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity cv_ack_generator is
	port(	clk50, nrst, generate_cvack: in std_logic;
			user_word: in std_logic_vector (127 downto 0);
			opponent_char: in std_logic_vector(7 downto 0);
			op_cvack: out std_logic_vector (15 downto 0);
			cvack_generated: out std_logic);
end cv_ack_generator;

architecture arc of cv_ack_generator is
	type state_type is (w_activate, s_compute, s_save, s_end);
	signal state	: state_type;
	
	signal ld		: std_logic;
	signal cvack_int	: std_logic_vector (15 downto 0);

begin
process(clk50, nrst) begin 
	if nrst = '0' then
		state <= w_activate;
	elsif clk50'event and clk50 = '1' then
		case state is
			when w_activate =>
				if (generate_cvack = '1') then
					state <= s_compute;
				end if;
			when s_compute =>
				state <= s_save;
			when s_save =>
				state <= s_end;
			when s_end =>
				state <= w_activate;
		end case;
	end if;
end process;


process(user_word, opponent_char, cvack_int) 
begin
	if state = s_compute then
		for count in 0 to 15 loop
			if(user_word(((count*8)+7) downto (count*8)) = opponent_char) then
				cvack_int(count) <= '1';
			else
				cvack_int(count) <= '0';
			end if;
		end loop;
	end if;
end process;


process(clk50,ld,nrst)
begin
	if nrst = '0' then
		op_cvack <= x"0000";
	elsif (clk50'event and clk50 = '1') then
		if ld = '1' then
			op_cvack <= cvack_int;
		end if;
	end if;
end process;

ld <= '1' when state = s_save else '0';
cvack_generated <= '1' when state = s_end else '0';
			
end arc;