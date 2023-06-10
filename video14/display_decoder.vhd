library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;


entity display_decoder is
    Port ( distance_in1 : in  STD_LOGIC_VECTOR (8 downto 0);
           display_sal : out  STD_LOGIC_VECTOR (6 downto 0);
			  display_sal2 : out  STD_LOGIC_VECTOR (6 downto 0)
			  );
end display_decoder;

architecture Behavioral of display_decoder is


signal display_out: STD_LOGIC_VECTOR (6 downto 0);
signal display_out1: STD_LOGIC_VECTOR (6 downto 0);
signal display_out2: STD_LOGIC_VECTOR (6 downto 0);
signal display_out3: STD_LOGIC_VECTOR (6 downto 0);

begin

display_out <="1000000" when distance_in1 = "000000000" else 
				  "1111001" when distance_in1 = "000000001" else
				  "0100100" when distance_in1 = "000000010" else
				  "0110000" when distance_in1 = "000000011" else
				  "0011001" when distance_in1 = "000000100" else
				  "0010010" when distance_in1 = "000000101" else
				  "0000010" when distance_in1 = "000000110" else
				  "0111000" when distance_in1 = "000000111" else
				  "0000000" when distance_in1 = "000001000" else
				  "0011000" when distance_in1 = "000001001" else
				  "1000000" when distance_in1 = "000001010" else
				   ---------------despues de 10------------------
				  "1111001" when distance_in1 = "000001011" else
				  "0100100" when distance_in1 = "000001100" else
				  "0110000" when distance_in1 = "000001101" else
				  "0011001" when distance_in1 = "000001110" else
				  "0010010" when distance_in1 = "000001111" else
				  "0000010" when distance_in1 = "000010000" else
				  "0111000" when distance_in1 = "000010001" else
				  "0000000" when distance_in1 = "000010010" else
				  "0011000" when distance_in1 = "000010011" else
				  "1000000" when distance_in1 = "000010100" else
				  ---------------despues de 20------------------
				  "1111001" when distance_in1 = "000010101" else
				  "0100100" when distance_in1 = "000010110" else
				  "0110000" when distance_in1 = "000010111" else
				  "0011001" when distance_in1 = "000011000" else
				  "0010010" when distance_in1 = "000011001" else
				  "0000010" when distance_in1 = "000011010" else
				  "0111000" when distance_in1 = "000011011" else
				  "0000000" when distance_in1 = "000011100" else
				  "0011000" when distance_in1 = "000011101" else
				  "1000000" when distance_in1 = "000011110" else
				   ---------------despues de 30------------------
				  "1111001" when distance_in1 = "000011111" else
				  "0100100" when distance_in1 = "000100000";
				  
display_out1 <="0000000" when distance_in1 = "000000000" else 
				  "0000000" when distance_in1 = "000000001" else
				  "0000000" when distance_in1 = "000000010" else
				  "0000000" when distance_in1 = "000000011" else
				  "0000000" when distance_in1 = "000000100" else
				  "0000000" when distance_in1 = "000000101" else
				  "0000000" when distance_in1 = "000000110" else
				  "0000000" when distance_in1 = "000000111" else
				  "0000000" when distance_in1 = "000001000" else
				  "0000000" when distance_in1 = "000001001" else
				  "0000110" when distance_in1 = "000001010" else
				  
				   ---------------despues de 10------------------
				  "0000110" when distance_in1 = "000001011" else
				  "0000110" when distance_in1 = "000001100" else
				  "0000110" when distance_in1 = "000001101" else
				  "0000110" when distance_in1 = "000001110" else
				  "0000110" when distance_in1 = "000001111" else
				  "0000110" when distance_in1 = "000010000" else
				  "0000110" when distance_in1 = "000010001" else
				  "0000110" when distance_in1 = "000010010" else
				  "0000110" when distance_in1 = "000010011" else
				  "1011011" when distance_in1 = "000010100" else
				  ---------------despues de 20------------------
				  "1011011" when distance_in1 = "000010101" else
				  "1011011" when distance_in1 = "000010110" else
				  "1011011" when distance_in1 = "000010111" else
				  "1011011" when distance_in1 = "000011000" else
				  "1011011" when distance_in1 = "000011001" else
				  "1011011" when distance_in1 = "000011010" else
				  "1011011" when distance_in1 = "000011011" else
				  "1011011" when distance_in1 = "000011100" else
				  "1011011" when distance_in1 = "000011101" else
				  "1001111" when distance_in1 = "000011110" else
				   ---------------despues de 30------------------
				  "1001111" when distance_in1 = "000011111" else
				  "1001111" when distance_in1 = "000100000";	

display_sal<=display_out;
display_sal2<=display_out1;

end Behavioral;