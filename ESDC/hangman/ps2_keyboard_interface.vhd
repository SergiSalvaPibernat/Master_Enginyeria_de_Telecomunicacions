library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity PS2_keyboard_interface is
	port (
		clk, nrst, scan_ready, ack_flag, new_code: in std_logic;
		scan_code : in std_logic_vector(7 downto 0);
		flag, in_read : out std_logic;
		keycode : out std_logic_vector(7 downto 0)
		);
end PS2_keyboard_interface;

architecture main of PS2_keyboard_interface is
	type states is (w_newcode, w_scan_ready, load_reg, w_sc2, ack2, w_sc3, activate_flag);
	signal st : states;
	signal ld : std_logic;
	signal set_flag : std_logic;
	signal ascii : std_logic_vector(7 downto 0);
begin
		
	
	-- 8-bit register
	process(clk,ld,nrst)
    begin
        if nrst = '0' then
            keycode <= x"00";
        elsif (clk'event and clk = '1') then
            if ld = '1' then
                keycode <= ascii;
            end if;
        end if;
    end process;

	-- JK flip-flop
	process(clk, set_flag, ack_flag,nrst)
	begin
		if nrst = '0' then
			flag <= '0';
		elsif (clk'event and clk = '1') then
			if set_flag = '1' then
				flag <= '1';
			elsif ack_flag = '1' then
				flag <= '0';
			end if;
		end if;
	end process;
	
	-- State machine
	process(clk,nrst)
	begin
		if(clk'event and clk = '1') then
			if (nrst='0') then
				st <= w_newcode;
			else
				case st is
					when w_newcode =>
						if (new_code='1') then
							st <= w_scan_ready;
						end if;
					when w_scan_ready =>
						if (scan_ready = '1') then
							st <= load_reg;
						end if;
					when load_reg =>
						st <= w_sc2;
					when w_sc2 =>
						if (scan_ready ='1') then
							st <= ack2;
						end if;
					when ack2 =>
						st <= w_sc3;
					when w_sc3 =>
						if scan_ready = '1' then
							st <= activate_flag;
						end if;
					when activate_flag =>
						st <= w_newcode;
				end case;
			end if;
		end if;
	end process;

ld <= '1' when st = load_reg else '0';
in_read <= '1' when st = load_reg or st = ack2 or st = activate_flag else '0';
set_flag <= '1' when st = activate_flag else '0';

-- PS2 to ASCII system
process(scan_code)
begin
	case scan_code is
		WHEN x"29" => ascii <= x"20"; --space
		WHEN x"66" => ascii <= x"08"; --backspace (BS control code)
		WHEN x"0D" => ascii <= x"09"; --tab (HT control code)
		WHEN x"5A" => ascii <= x"0D"; --enter (CR control code)
		WHEN x"76" => ascii <= x"1B"; --escape (ESC control code)
		WHEN x"1C" => ascii <= x"61"; --a
		WHEN x"32" => ascii <= x"62"; --b
		WHEN x"21" => ascii <= x"63"; --c
		WHEN x"23" => ascii <= x"64"; --d
		WHEN x"24" => ascii <= x"65"; --e
		WHEN x"2B" => ascii <= x"66"; --f
		WHEN x"34" => ascii <= x"67"; --g
		WHEN x"33" => ascii <= x"68"; --h
		WHEN x"43" => ascii <= x"69"; --i
		WHEN x"3B" => ascii <= x"6A"; --j
		WHEN x"42" => ascii <= x"6B"; --k
		WHEN x"4B" => ascii <= x"6C"; --l
		WHEN x"3A" => ascii <= x"6D"; --m
		WHEN x"31" => ascii <= x"6E"; --n
		WHEN x"44" => ascii <= x"6F"; --o
		WHEN x"4D" => ascii <= x"70"; --p
		WHEN x"15" => ascii <= x"71"; --q
		WHEN x"2D" => ascii <= x"72"; --r
		WHEN x"1B" => ascii <= x"73"; --s
		WHEN x"2C" => ascii <= x"74"; --t
		WHEN x"3C" => ascii <= x"75"; --u
		WHEN x"2A" => ascii <= x"76"; --v
		WHEN x"1D" => ascii <= x"77"; --w
		WHEN x"22" => ascii <= x"78"; --x
		WHEN x"35" => ascii <= x"79"; --y
		WHEN x"1A" => ascii <= x"7A"; --z
		WHEN x"45" => ascii <= x"30"; --0
		WHEN x"16" => ascii <= x"31"; --1
		WHEN x"1E" => ascii <= x"32"; --2
		WHEN x"26" => ascii <= x"33"; --3
		WHEN x"25" => ascii <= x"34"; --4
		WHEN x"2E" => ascii <= x"35"; --5
		WHEN x"36" => ascii <= x"36"; --6
		WHEN x"3D" => ascii <= x"37"; --7
		WHEN x"3E" => ascii <= x"38"; --8
		WHEN x"46" => ascii <= x"39"; --9
		WHEN x"52" => ascii <= x"27"; --'
		WHEN x"41" => ascii <= x"2C"; --,
		WHEN x"4E" => ascii <= x"2D"; ---
		WHEN x"49" => ascii <= x"2E"; --.
		WHEN x"4A" => ascii <= x"2F"; --/
		WHEN x"4C" => ascii <= x"3B"; --;
		WHEN x"55" => ascii <= x"3D"; --=
		WHEN x"54" => ascii <= x"5B"; --[
		WHEN x"5D" => ascii <= x"5C"; --\
		WHEN OTHERS => NULL;
	end case;
end process;
	
end;	