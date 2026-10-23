library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity register_bank_opponent_cv is
	port(	clk50, nrst, load_cv : in std_logic;
			op_cv : in std_logic_vector (15 downto 0);
			cv_out : out std_logic_vector (15 downto 0);
			key_read, bank_ready : out std_logic);
end register_bank_opponent_cv;

architecture arc of register_bank_opponent_cv is
	type state_type is (s_wait, loadreg, s_end);
	signal st : state_type;
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
					if (load_cv = '1') then
						st <= loadreg;
					end if;
				when loadreg =>
					st <= s_end;
				when s_end =>
					st <= s_wait;
			end case;
		end if;
	end process;
	
	
	-- JK flip-flop
	process(clk50,nrst,load_cv,J_BR)
	begin
		if nrst = '0' then
			bank_ready <= '1';
		elsif (clk50'event and clk50 = '1') then
			if J_BR = '1' then
				bank_ready <= '1';
			elsif load_cv = '1' then
				bank_ready <= '0';
			end if;
		end if;
	end process;
	
	-- Load input char to register
	process(clk50,ld,nrst)
    begin
        if nrst = '0' then
            cv_out <= x"0000";
        elsif (clk50'event and clk50 = '1') then
            if ld = '1' then
				cv_out <= op_cv;
            end if;
        end if;
    end process;

J_BR <= '1' when st = s_end else '0';
ld <= '1' when st = loadreg else '0';
	
end arc;