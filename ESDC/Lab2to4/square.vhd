-----------------------------------------------------------------------------------------
-- Block square : indicates to WRITE MEMORY where a new square must be plotted in the VGA screen
-- x_t: left top column coordinate. 8 MSB of the 10 bits needed.
-- y_t: left top row coordinate. 7 MSB of the 9 bitw needed.
-- color_t: RGB components of the square to plot. 3 bits
-- Start: order to start writing the memory.
-- Inputs: status of the board LEDS.
-- Author: Josep Altet. 
-- Version 1.0 : Date: 12-02-2019.
-- Version 2.0 : Date: 25-02-2020 (Adapted to Theory lecture).
-- Version 3.0 : Date: 08-09-2021 Adapted to Design 1.
-- Electronic System Design for Communications - ESDC - ETSTB. UPC. Barcelona.
----------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity square is
  port( clk_d1, nrst, LG7, LG6, LG2, LG1, LG0   	 	: in std_logic;
		LR2, LR1, LR0 	: in std_logic;
		x_t				: out integer range 0 to 160;
		y_t				: out integer range 0 to 120;
		color_t 		: out integer range 0 to 7;
		start			: out std_logic;
		done			: in std_logic);  -- To be connected to the RAM ADD Bus.
end square;


architecture functional of square is
  
  -- Coordinates of the squares that represent the different LEDs on the VGA
  constant XLG7 : integer := 1;
  constant XLG6 : integer := 33;
  constant XLG2 : integer := 65;
  constant XLG1 : integer := 97;
  constant XLG0 : integer := 129;
  constant XLR2 : integer := 1;
  constant XLR1 : integer := 33;
  constant XLR0 : integer := 65;
  constant YLG : integer := 20;
  constant YLR : integer := 50;
  
  -- Possible colors of the sqares.
  -- Precondition: memory is created blank (remaining color = 000).
  constant RED : integer := 4;
  constant BLUE : integer := 1;
  constant GREEN : integer := 2; 

  -- State definition:
  type state_square is (sLG7a, sLG7b, sLG7c, sLG6a, sLG6b, sLG6c, sLG2a, sLG2b, sLG2c, sLG1a, sLG1b, sLG1c, sLG0a, sLG0b, sLG0c,
                       sLR2a, sLR2b, sLR2c, sLR1a, sLR1b, sLR1c, sLR0a, sLR0b, sLR0c);
  -- Internal signals
  -- Output of the state register
  signal st_square : state_square;
  -- Internal address memory bus
  
  Begin
-- All signals updated inside if (clk_d1'event and clk_d1='1') are output of registers!!
-- With this VHDL description, Control Unit and Process Unit are described with one single Process.
-- Control Unit: state flow.
-- Process Unit: Blocks that process data (counters, registers).
-- Control signals: they are not specified in the VHDL description, but they will be in the final implemented design. 
-- Only output control signals are presented.
	process(clk_d1, nrst)
	Begin
		if (nrst = '0') then
			st_square <= sLG7a;
		elsif (clk_d1'event and clk_d1='1') then
			case st_square is
				-- To activate the square associated to LG7
				when sLG7a  => 
					st_square <= sLG7b;
					x_t <= XLG7; y_t <= YLG;  -- Coordinates of the square.
					if LG7 = '1' then color_t <= GREEN; else color_t <= BLUE; end if;
				when sLG7b =>
					st_square <= sLG7c;  --Start must be activated in this state in a combinacional circuit.
				when sLG7c =>
					if done = '1' then st_square <= sLG6a; end if;
					
				-- To activate the square associated to LG6
				when sLG6a  => 
					st_square <= sLG6b;
					x_t <= XLG6; y_t <= YLG;  -- Coordinates of the square.
					if LG6 = '1' then color_t <= GREEN; else color_t <= BLUE; end if;
				when sLG6b =>
					st_square <= sLG6c;  --Start must be activated in this state in a combinacional circuit.
				when sLG6c =>
					if done = '1' then st_square <= sLG2a; end if;
					
				-- To activate the square associated to LG2
				when sLG2a  => 
					st_square <= sLG2b;
					x_t <= XLG2; y_t <= YLG;  -- Coordinates of the square.
					if LG2 = '1' then color_t <= GREEN; else color_t <= BLUE; end if;
				when sLG2b =>
					st_square <= sLG2c;  --Start must be activated in this state in a combinacional circuit.
				when sLG2c =>
					if done = '1' then st_square <= sLG1a; end if;
					
				-- To activate the square associated to LG1
				when sLG1a  => 
					st_square <= sLG1b;
					x_t <= XLG1; y_t <= YLG;  -- Coordinates of the square.
					if LG1 = '1' then color_t <= GREEN; else color_t <= BLUE; end if;
				when sLG1b =>
					st_square <= sLG1c;  --Start must be activated in this state in a combinacional circuit.
				when sLG1c =>
					if done = '1' then st_square <= sLG0a; end if;
					
				-- To activate the square associated to LG1
				when sLG0a  => 
					st_square <= sLG0b;
					x_t <= XLG0; y_t <= YLG;  -- Coordinates of the square.
					if LG0 = '1' then color_t <= GREEN; else color_t <= BLUE; end if;
				when sLG0b =>
					st_square <= sLG0c;  --Start must be activated in this state in a combinacional circuit.
				when sLG0c =>
					if done = '1' then st_square <= sLR2a; end if;
					
				--- To activate the square associated to LR2
				when sLR2a  => 
					st_square <= sLR2b;
					x_t <= XLR2; y_t <= YLR;  -- Coordinates of the square.
					if LR2 = '1' then color_t <= RED; else color_t <= BLUE; end if;
				when sLR2b =>
					st_square <= sLR2c;  --Start must be activated in this state in a combinacional circuit.
				when sLR2c =>
					if done = '1' then st_square <= sLR1a; end if;
					
				-- To activate the square associated to LR1
				when sLR1a  => 
					st_square <= sLR1b;
					x_t <= XLR1; y_t <= YLR;  -- Coordinates of the square.
					if LR1 = '1' then color_t <= RED; else color_t <= BLUE; end if;
				when sLR1b =>
					st_square <= sLR1c;  --Start must be activated in this state in a combinacional circuit.
				when sLR1c =>
					if done = '1' then st_square <= sLR0a; end if;
					
				-- To activate the square associated to LR1
				when sLR0a  => 
					st_square <= sLR0b;
					x_t <= XLR0; y_t <= YLR;  -- Coordinates of the square.
					if LR0 = '1' then color_t <= RED; else color_t <= BLUE; end if;
				when sLR0b =>
					st_square <= sLR0c;  --Start must be activated in this state in a combinacional circuit.
				when sLR0c =>
					if done = '1' then st_square <= sLG7a; end if;  -- Infinite loop.
			End Case;
		End If;
	End Process;
	
Start <= '1' when (st_square = sLG7b) or (st_square = sLG6b) or (st_square = sLG2b) or
				(st_square = sLG1b) or (st_square = sLG0b) or (st_square = sLR2b) or (st_square = sLR1b) 
				or (st_square = sLR0b) else '0';
End Functional;