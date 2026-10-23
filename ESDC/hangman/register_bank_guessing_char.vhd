library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity register_bank_guessing_char is
	port(	clk50, nrst,char_flag, new_char : in std_logic;
			char : in std_logic_vector (7 downto 0);
			out_char : out std_logic_vector (7 downto 0);
			key_read, bank_ready : out std_logic);
end register_bank_guessing_char;

architecture arc of register_bank_guessing_char is
	type state_type is (s_wait, w_charflag, loadreg, s_end);
	signal st : state_type;
	signal buff_char : std_logic_vector (7 downto 0);
	signal J_BR : std_logic;
	signal K_BR : std_logic;
	signal ld	: std_logic;
begin

	-- States machine
	process(clk50, nrst) begin 
		if nrst = '0' then
			st <= s_wait;
		elsif clk50'event and clk50 = '1' then
			case st is
				when s_wait =>
					if (new_char = '1') then
						st <= w_charflag;
					end if;
				when w_charflag =>
					if (char_flag = '1') then
						if char /= x"0D" then 
							st <= loadreg;
						else
							st <= s_end;
						end if;
					end if;
				when loadreg =>
					st <= w_charflag;
				when s_end =>
					st <= s_wait;
			end case;
		end if;
	end process;
	
	
	-- JK flip-flop
	process(clk50,nrst,new_char,J_BR)
	begin
		if nrst = '0' then
			bank_ready <= '1';
		elsif (clk50'event and clk50 = '1') then
			if J_BR = '1' then
				bank_ready <= '1';
			elsif new_char = '1' then
				bank_ready <= '0';
			end if;
		end if;
	end process;
	
	-- Load input char to register
	process(clk50,ld,nrst)
    begin
        if nrst = '0' then
            buff_char <= x"00";
        elsif (clk50'event and clk50 = '1') then
            if ld = '1' then
				buff_char <= char;
            end if;
        end if;
    end process;

key_read <= '1' when st = w_charflag else '0';
J_BR <= '1' when st = s_end else '0';
ld <= '1' when st = loadreg else '0';
out_char <= buff_char;
	
end arc;