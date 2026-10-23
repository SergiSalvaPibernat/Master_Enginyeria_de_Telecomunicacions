library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity register_bank is
	port(	clk50, nrst, bcd, ast, new_code: in std_logic;
			keycode: in std_logic_vector (3 downto 0);
			DataH, DataT, DataU: out std_logic_vector (3 downto 0);
			key_read, bank_ready : out std_logic);
end register_bank;

architecture arc of register_bank is
	type state_type is (s0_wait, w_keypress, get_key, s_end);
	
	signal state : state_type;
	signal set_DataH, set_DataT, set_DataU : std_logic_vector(3 downto 0);

	begin process(clk50, nrst) begin 
		if nrst = '0' then
			state <= s0_wait;
			bank_ready <= '1';
			set_DataH <= "0000";
			set_DataT <= "0000";
			set_DataU <= "0000";
		elsif clk50'event and clk50 = '1' then
			case state is
			
				when s0_wait =>
					if (new_code = '1') then
						state <= w_keypress;
						bank_ready <= '0';
						set_DataH <= "0000";
						set_DataT <= "0000";
						set_DataU <= "0000";
					end if;
					
				when w_keypress =>
					if (bcd = '1') then 
						state <= get_key;
					elsif (ast = '1') then
						state <= s_end;
					end if;
				
				when get_key =>
					state <= w_keypress;
					set_dataH <= set_dataT;
					set_dataT <= set_dataU;
					set_dataU <= keycode;
				
				when s_end =>
					state <= s0_wait;
					bank_ready <= '1';
			
			end case;
		end if;
	end process;

key_read <= '1' when state = get_key or state = s_end else '0';
DataH <= set_dataH;
DataT <= set_dataT;
DataU <= set_dataU;
	
end arc;