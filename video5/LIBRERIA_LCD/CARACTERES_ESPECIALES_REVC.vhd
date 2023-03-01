library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CARACTERES_ESPECIALES_REVC is

PORT( C1,C2,C3,C4,C5,C6,C7,C8 : OUT STD_LOGIC_VECTOR(39 DOWNTO 0);
		CLK : IN STD_LOGIC
		);
--


end CARACTERES_ESPECIALES_REVC;

architecture Behavioral of CARACTERES_ESPECIALES_REVC is

SIGNAL CHAR_1 : STD_LOGIC_VECTOR(39 DOWNTO 0) := X"0000000000";
SIGNAL CHAR_2 : STD_LOGIC_VECTOR(39 DOWNTO 0) := X"0000000000";
SIGNAL CHAR_3 : STD_LOGIC_VECTOR(39 DOWNTO 0) := X"0000000000";
SIGNAL CHAR_4 : STD_LOGIC_VECTOR(39 DOWNTO 0) := X"0000000000";
SIGNAL CHAR_5 : STD_LOGIC_VECTOR(39 DOWNTO 0) := X"0000000000";
SIGNAL CHAR_6 : STD_LOGIC_VECTOR(39 DOWNTO 0) := X"0000000000";
SIGNAL CHAR_7 : STD_LOGIC_VECTOR(39 DOWNTO 0) := X"0000000000";
SIGNAL CHAR_8 : STD_LOGIC_VECTOR(39 DOWNTO 0) := X"0000000000";
 
begin

------------------------------------------------------------------
---------------CARACTERES A DIBUJAR-------------------------------

CHAR_1 <=

 "00000"&
 "00000"&	
 "00000"&
 "00001"&
 "00011"&
 "00011"&
 "00001"&
 "00000";
 
 CHAR_2 <=
 
 "00000"&
 "01110"&	
 "11111"&
 "11111"&
 "01110"&
 "11111"&
 "11011"&
 "11111";
 
 CHAR_3 <=
 
 "00000"&
 "00000"&	
 "00000"&
 "10000"&
 "11000"&
 "11000"&
 "10000"&
 "00010";
 
 CHAR_4 <=
 
 "01100"&
 "10101"&	
 "00111"&
 "00000"&
 "00001"&
 "00110"&
 "00100"&
 "00000";
 
 CHAR_5 <=
 
 "01110"&
 "11111"&	
 "01010"&
 "01010"&
 "11011"&
 "00000"&
 "00000"&
 "00000";
 
 CHAR_6 <=
 
 "00010"&
 "10110"&	
 "11100"&
 "00000"&
 "10100"&
 "11100"&
 "00000"&
 "00000";
 
 CHAR_7 <=
 
 "11111"&
 "11111"&	
 "11111"&
 "11111"&
 "11011"&
 "10010"&
 "10011"&
 "11000";
 
 CHAR_8 <=
 
 "11111"&
 "11111"&	
 "11111"&
 "11111"&
 "11011"&
 "10010"&
 "11010"&
 "00011";
 
------------------------------------------------------------------
------------------------------------------------------------------

C1 <= CHAR_1;
C2 <= CHAR_2;
C3 <= CHAR_3;
C4 <= CHAR_4;
C5 <= CHAR_5;
C6 <= CHAR_6;
C7 <= CHAR_7;
C8 <= CHAR_8;

end Behavioral;