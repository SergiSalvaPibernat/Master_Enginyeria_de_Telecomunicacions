library work;
library ieee;
use ieee.std_logic_1164.all;

entity BCD7seg is 
   port( num : in std_logic_vector (4 downto 0);
        HEX  : out std_logic_vector (6 downto 0)
         );
end BCD7seg;

architecture behaviour of BCD7seg is
   
begin

        HEX(6 downto 0) <=   "1000000" when num(4 downto 0) = "00000" else  --0
							 "1111001" when num(4 downto 0) = "00001" else --1
							 "0100100" when num(4 downto 0) = "00010" else --2
							 "0110000" when num(4 downto 0) = "00011" else --3
							 "0011001" when num(4 downto 0) = "00100" else --4
							 "0010010" when num(4 downto 0) = "00101" else --5
							 "0000010" when num(4 downto 0) = "00110" else --6
							 "1111000" when num(4 downto 0) = "00111" else --7
							 "0000000" when num(4 downto 0) = "01000" else --8
							 "0010000" when num(4 downto 0) = "01001" else --9
							 "1000011" when num(4 downto 0) = "10000" else --W
							 "1100001" when num(4 downto 0) = "10001" else --W
							 "1111001" when num(4 downto 0) = "10010" else --I
							 "1001000" when num(4 downto 0) = "10011" else --N
							 "1000111" when num(4 downto 0) = "10100" else --L
							 "1000000" when num(4 downto 0) = "10101" else --O
							 "0010010" when num(4 downto 0) = "10110" else --S
							 "0000110" when num(4 downto 0) = "10111" else --E
							 "1111111";
	
						 
end behaviour;
