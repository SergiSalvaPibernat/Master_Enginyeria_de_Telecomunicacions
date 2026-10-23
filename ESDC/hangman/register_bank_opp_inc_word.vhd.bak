library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity register_bank_opp_inc_word is
	port(	clk50, nrst, f_new : in std_logic;
			new_word: in std_logic_vector (127 downto 0);
			word: out std_logic_vector (127 downto 0);
			bank_ready : out std_logic);
end register_bank_opp_inc_word;

architecture arc of register_bank_opp_inc_word is
	type state_type is (s0, s1, s2, s3);
	signal st :  state_type;
	signal buff_word : std_logic_vector (127 downto 0);
begin
	process(clk50, nrst) begin
		if nrst = '0' then
			bank_ready <= '1';
			buff_word <= (others => '0');
			st <= s0;
		elsif clk50'event and clk50 = '1' then
			case st is
				when s0 =>
					if f_new = '1' then
						st <= s1;
					end if;
				when s1 =>
					st <= s2;
					bank_ready <= '0';
				when s2 =>
					st <= s3;
					buff_word <= new_word;
				when s3 =>
					st <= s0;
					bank_ready <= '1';
			end case;
		end if;
	end process;
word <= buff_word;
end arc;