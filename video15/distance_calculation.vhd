library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;


entity distance_calculation is
port(
echo_count : in STD_LOGIC_VECTOR (19 downto 0);
distance : out  STD_LOGIC_VECTOR (8 downto 0)
);
end distance_calculation;

architecture Behavioral of distance_calculation is


begin
--                                  5800

Distance <="000000000" when (echo_count < 2900) else --0cm
			  "000000001" when (echo_count > 2900 and echo_count < 4350) else --1-1.5cm
			  "000000001" when (echo_count > 4350 and echo_count < 5800) else --1.5-2cm
			  "000000010" when (echo_count > 5800 and echo_count < 7250) else --2-2.5cm
			  "000000010" when (echo_count > 7250  and echo_count < 8700) else --2.5-3cm
			  "000000011" when (echo_count > 8700  and echo_count < 10150) else --3-3.5cm
			  "000000011" when (echo_count > 10150 and echo_count < 11600) else --3.5-4cm
			  "000000100" when (echo_count > 13050 and echo_count < 14500) else --4-4.5cm
			  "000000100" when (echo_count > 14500 and echo_count < 15950) else --4.5-5cm
			  ------------------------------------------------------------------------------
			  "000000101" when (echo_count > 15950 and echo_count < 17400) else --5-5.5cm
			  "000000101" when (echo_count > 17400 and echo_count < 18850) else --5.5-6cm
			  "000000110" when (echo_count > 18850 and echo_count < 20300) else --6-6.5cm
			  "000000110" when (echo_count > 20300 and echo_count < 21750) else --6.5-7cm
			  "000000111" when (echo_count > 21750 and echo_count < 23200) else --7-7.5cm 
			  "000000111" when (echo_count > 23200 and echo_count < 24650) else --7.5-8cm 
			  "000001000" when (echo_count > 24650 and echo_count < 26100) else --8-8.5cm 
			  "000001000" when (echo_count > 27550 and echo_count < 29000) else --8.5-9cm
			  "000001001" when (echo_count > 29000 and echo_count < 30450) else --9-9.5cm
			  "000001001" when (echo_count > 30450 and echo_count < 31900) else --9.5-10cm
			  ------------------------------------------------------------------------------
			  "000001010" when (echo_count > 30450 and echo_count < 31900) else --10-10.5cm
			  "000001010" when (echo_count > 31900 and echo_count < 33350) else --10.5-11cm
			  "000001011" when (echo_count > 33350 and echo_count < 34800) else --11-11.5cm
			  "000001011" when (echo_count > 34800 and echo_count < 36250) else --11.5-12cm
			  "000001100" when (echo_count > 36250 and echo_count < 37700) else --12-12.5cm
			  "000001100" when (echo_count > 37700 and echo_count < 39150) else --12.5-13cm
			  "000001101" when (echo_count > 39150 and echo_count < 40600) else --13-13.5cm
			  "000001101" when (echo_count > 40600 and echo_count < 42050) else --13.5-14cm
			  "000001110" when (echo_count > 42050 and echo_count < 43500) else --14-14.5cm
			  "000001110" when (echo_count > 43500 and echo_count < 44950) else --14.5-15cm
			  ------------------------------------------------------------------------------
			  "000001111" when (echo_count > 44950 and echo_count < 46400) else --15-15.5cm
			  "000001111" when (echo_count > 46400 and echo_count < 47850) else --15.5-16cm
			  "000010000" when (echo_count > 47850 and echo_count < 49300) else --16-16.5cm
			  "000010000" when (echo_count > 49300 and echo_count < 50750) else --16.5-17cm
			  "000010001" when (echo_count > 50750 and echo_count < 52200) else --17-17.5cm
			  "000010001" when (echo_count > 52200 and echo_count < 53650) else --17.5-18cm
			  "000010010" when (echo_count > 53650 and echo_count < 55100) else --18-18.5cm
			  "000010010" when (echo_count > 55100 and echo_count < 56550) else --18.5-19cm
			  "000010011" when (echo_count > 56550 and echo_count < 58000) else --19-19.5cm
			  "000010011" when (echo_count > 58000 and echo_count < 59450) else --19.5-20cm
			  ------------------------------------------------------------------------------
			  "000010100" when (echo_count > 59450 and echo_count < 60900) else --20-20.5cm
			  "000010100" when (echo_count > 60900 and echo_count < 62350) else --20.5-21cm
			  "000010101" when (echo_count > 62350 and echo_count < 63800) else --21-21.5cm
			  "000010101" when (echo_count > 63800 and echo_count < 65250) else --21.5-22cm
			  "000010110" when (echo_count > 65250 and echo_count < 66700) else --22-22.5cm
			  "000010110" when (echo_count > 66700 and echo_count < 68150) else --22.5-23cm
			  "000010111" when (echo_count > 68150 and echo_count < 69600) else --23-23.5cm
			  "000010111" when (echo_count > 69600 and echo_count < 71050) else --23.5-24cm
			  "000011000" when (echo_count > 71050 and echo_count < 72500) else --24-24.5cm
			  "000011000" when (echo_count > 72500 and echo_count < 73950) else --24.5-25cm
			  ------------------------------------------------------------------------------
			  "000011001" when (echo_count > 73950 and echo_count < 75400) else --25-25.5cm
			  "000011001" when (echo_count > 75400 and echo_count < 76850) else --25.5-26cm
			  "000011010" when (echo_count > 76850 and echo_count < 78300) else --26-26.5cm
			  "000011010" when (echo_count > 78300 and echo_count < 79750) else --26.5-27cm
			  "000011011" when (echo_count > 79750 and echo_count < 81200) else --27-27.5cm
			  "000011011" when (echo_count > 81200 and echo_count < 82650) else --27.5-28cm
			  "000011100" when (echo_count > 82650 and echo_count < 84100) else --28-28.5cm
			  "000011100" when (echo_count > 84100 and echo_count < 85550) else --28.5-29cm
			  "000011101" when (echo_count > 85550 and echo_count < 87000) else --29-29.5cm
			  "000011101" when (echo_count > 87000 and echo_count < 88450) else --29.5-30cm
			  "000011110" when (echo_count > 88450 and echo_count < 89900) else --30-30.5cm
			  "000011110" when (echo_count > 89900 and echo_count < 91350) else --30.5-31cm
			  "000011111";
		  
end Behavioral;