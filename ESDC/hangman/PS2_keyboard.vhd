LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY PS2_keyboard IS
	PORT(	keyboard_clk, keyboard_data, clock_25Mhz ,
			reset, in_read : IN STD_LOGIC;
			scan_code : OUT STD_LOGIC_VECTOR( 7 DOWNTO 0 );
			scan_ready : OUT STD_LOGIC);
END PS2_keyboard;

ARCHITECTURE a OF PS2_keyboard IS
	SIGNAL INCNT 					: STD_LOGIC_VECTOR( 3 DOWNTO 0 );
	SIGNAL SHIFTIN 					: STD_LOGIC_VECTOR( 8 DOWNTO 0 );
	SIGNAL READ_CHAR 				: STD_LOGIC;
	SIGNAL INFLAG, ready_set 		: STD_LOGIC;
	SIGNAL keyboard_clk_filtered	: STD_LOGIC;
	SIGNAL filter 					: STD_LOGIC_VECTOR( 7 DOWNTO 0 );


BEGIN
	PROCESS ( in_read, ready_set )
	BEGIN
		IF in_read = '1' THEN
			scan_ready <= '0';
		ELSIF ready_set'EVENT AND ready_set = '1' THEN
			scan_ready <= '1';
		END IF;
	END PROCESS;
		--This process filters the raw clock signal coming from the
		-- keyboard using a shift register and two AND gates
		
Clock_filter:
	PROCESS
		BEGIN
		WAIT UNTIL clock_25Mhz'EVENT AND clock_25Mhz = '1';
		filter ( 6 DOWNTO 0 ) <= filter( 7 DOWNTO 1 ) ;
		filter( 7 ) <= keyboard_clk;
		IF filter = "11111111" THEN
			keyboard_clk_filtered <= '1';
		ELSIF filter = "00000000" THEN
			keyboard_clk_filtered <= '0';
		END IF;
	END PROCESS Clock_filter;
		--This process reads in serial scan code data coming from the keyboard

	PROCESS
	BEGIN
		WAIT UNTIL (keyboard_clk_filtered'EVENT AND KEYBOARD_CLK_filtered = '1');
		IF reset = '0' THEN
			INCNT <= "0000";
			READ_CHAR <= '0';
		ELSE	
			IF KEYBOARD_DATA = '0' AND READ_CHAR = '0' THEN
				READ_CHAR <= '1';
				ready_set <= '0';
			ELSE
					-- Shift in next 8 data bits to assemble a scan code
				IF READ_CHAR = '1' THEN
					IF INCNT < "1001" THEN
						INCNT <= INCNT + 1 ;
						SHIFTIN( 7 DOWNTO 0 ) <= SHIFTIN( 8 DOWNTO 1 );
						SHIFTIN( 8 ) <= KEYBOARD_DATA;
						ready_set <= '0';
								-- End of scan code character, so set flags and exit loop
					ELSE
						scan_code <= SHIFTIN( 7 DOWNTO 0 );
						READ_CHAR <='0';
						ready_set <= '1';
						INCNT <= "0000";
					END IF;
				END IF;
			END IF;
		END IF;
	END PROCESS;
END a;
