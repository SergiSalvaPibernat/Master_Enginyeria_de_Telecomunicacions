library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;

entity LCD_int is 
   port( clk, nrst			       	: in std_logic;
         DB_LCD 					: inout std_logic_vector (7 downto 0);
    	 LON, LEN, LWRN, LRS, busy 	: out std_logic;
    	 run						: in std_logic;
    	 message 					: in integer range 0 to 5 );
end LCD_int;

architecture behaviour of LCD_int is

   type lcd_machine is ( delay, set1, set2, onoff1, onoff2, mode1, mode2, 
						waiting, clear1, clear2, char1, char2, read1, read2 );
   signal lcd_st 	: lcd_machine;
   signal lcdctrl 	: std_logic_vector(2 downto 0);
   signal data		: std_logic_vector(7 downto 0);
   signal ch		: character;
   signal add	  	: integer range 80 downto 0;
   signal counter   : integer range 16 downto 0;	
   signal run_d     : std_logic;
   signal go        : std_logic_vector (1 downto 0);

begin

--D-TYPE FLIP FLOP	
FFD:process (clk,nrst)
    begin
    if nrst ='0' then run_d <= '1';
     elsif clk'event and clk='1' then
         run_d <= run;
	 end if;
end process FFD;
go <= run & run_d;

--LCD CONTROL STATE MACHINE 
  LCD_FSM : process (clk, nrst)  
  begin  	
    if nrst='0' then lcd_st <= delay; 
    elsif clk'event and clk='1' then
      case lcd_st is
		--------Setting---------------
        when delay  => lcd_st <= set1; add <= 0; counter <= 0;
        when set1   => lcd_st <= set2;
        when set2   => lcd_st <= onoff1;
        when onoff1 => lcd_st <= onoff2;
        when onoff2 => lcd_st <= mode1;
        when mode1  => lcd_st <= mode2;
        when mode2  => lcd_st <= waiting;
	    when waiting => if go = "01" then  
					       if message = 1  then  
						      lcd_st <= clear1; add <= 0; 	 -- Message 1
	                       elsif message = 2 then  
							  lcd_st <= clear1; add <= 16;   -- Message 2			
					       elsif message = 3 then  
							  lcd_st <= clear1; add <= 32; 	 -- Message 3  
					       elsif message = 4 then
							  lcd_st <= clear1; add <= 48;	 -- Message 4
					       elsif message = 5 then  
							  lcd_st <= clear1; add <= 64; 	 -- Message 5
						   else
							  lcd_st <= waiting;
						   end if;	  	
					   else lcd_st <= waiting; 
					   end if;
	    -------- Message Display Routine---------------
        when clear1 => lcd_st <= clear2; 
        when clear2 => lcd_st <= char1;
        when char1  => lcd_st <= char2;
        when char2  => lcd_st <= read1;
        when read1  => if DB_LCD(7)='1' then 
							lcd_st <= read2;
						elsif counter = 16 then 
							lcd_st <= waiting;
							counter <= 0;
						else 
							lcd_st <= char1; 
							counter <= counter+1; 
							add <= add+1; 
						end if;
        when read2  => if DB_LCD(7)='1' then 
							lcd_st <= read1;
						elsif counter = 16 then 
							lcd_st <= waiting;
							counter <= 0; 
						else 
							lcd_st <= char1;
							counter <= counter+1; 
							add <= add+1; 
							end if;
     end case;
    end if;
  end process LCD_FSM;

with lcd_st select
    busy <= '0' when waiting,
		    '1' when others;

---------------LCD CONTROL LINES---------------
LRS  <= lcdctrl(2);
LWRN <= lcdctrl(1);
LEN  <= lcdctrl(0);
LON  <= '1';

with lcd_st select
	lcdctrl <= "001" when set1|onoff1|mode1|clear1,
			"000" when set2|onoff2|mode2|clear2, 
			"101" when char1,
			"100" when char2,
			"010" when read1,
			"011" when read2,
			"000" when others;

----------------DATA BUS CONTROL---------------
with lcd_st select
	DB_LCD <= data when char1|char2,
		"ZZZZZZZZ" when read1|read2,
		"001111XX" when set1|set2,
 		"00001111" when onoff1|onoff2,
		"00000001" when clear1|clear2,
		"00000110" when mode1|mode2,
		"00000010" when others;
data  <=  conv_std_logic_vector(character'pos(ch),8);

---------------LCD MESSAGES---------------
with add select
 ch <=	'P' when 0,  ------MESSAGE 1
		'r' when 1,
		'e' when 2,
		's' when 3,
		's' when 4,
		' ' when 5,
		'*' when 6,
		' ' when 7,
		't' when 8,
		'o' when 9,
		' ' when 10,
		's' when 11,
		't' when 12,
		'a' when 13,
		'r' when 14,
		't' when 15,  
		'I' when 16,  -----MESSAGE 2
		'n' when 17,  
		't' when 18,
		'r' when 19,
		'o' when 20,
		'd' when 21,
		'u' when 22,
		'c' when 23,
		'e' when 24,
		' ' when 25,
		'c' when 26,
		'o' when 27,
		'd' when 28,
		'e' when 29,
		' ' when 30 to 31,
		'G' when 32,   -----MESSAGE 3
		'o' when 33,
		' ' when 34,
		'u' when 35,
		'p' when 36,
		' ' when 37 to 47,    
		'Y' when 48,   -----MESSAGE 4
		'o' when 49,
		'u' when 50,
		' ' when 51,
		'W' when 52,
		'o' when 53,
		'n' when 54,
		'!' when 55,  
		' ' when 56 to 63,
		'G' when 64,   -----MESSAGE 5
		'o' when 65,
		' ' when 66,
		'd' when 67,
		'o' when 68,
		'w' when 69,
		'n' when 70,
		' ' when 71 to 79,
	    ' ' when others;
end behaviour;
