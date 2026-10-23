library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity hex_disps is
  port ( char0, char1, char2, char3, char4, char5 : in std_logic_vector (4 downto 0);
         HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 : out std_logic_vector (6 downto 0));
end hex_disps ;

architecture behav_display of hex_disps is

  component BCD7seg
    port ( num  : in std_logic_vector (4 downto 0);
           HEX  : out std_logic_vector (6 downto 0));
  end component;

begin

 display0: BCD7seg
   port map(char0,HEX0);
 display1: BCD7seg
   port map(char1,HEX1);
 display2: BCD7seg
   port map(char2,HEX2);
 display3: BCD7seg
   port map(char3,HEX3);
 display4: BCD7seg
   port map(char4,HEX4);
 display5: BCD7seg
   port map(char5,HEX5);

end behav_display;
