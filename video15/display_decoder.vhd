library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity display_decoder is
    port ( clk_in: in std_logic;
			  distance_in1 : in  std_logic_vector (8 downto 0);
           display_sal : out  std_logic_vector (6 downto 0);
			  transistor : out std_logic_vector (1 downto 0)
			  );
end display_decoder;

architecture behavioral of display_decoder is
---------
type maquina is (display1,display2);
signal edo_p,edo_f : maquina := display1;
constant conta_sw_fin : integer := 499_999;
signal conta_switch : integer range 0 to conta_sw_fin := 0;
signal contador_principal : std_logic_vector (6 downto 0);
---------
signal unidades: std_logic_vector (6 downto 0);
signal decenas: std_logic_vector (6 downto 0);

begin

unidades	   <="0000000" when distance_in1 = "000000000" else --0
				  "0000001" when distance_in1 = "000000001" else --1
				  "0000010" when distance_in1 = "000000010" else --2
				  "0000011" when distance_in1 = "000000011" else --3
				  "0000100" when distance_in1 = "000000100" else --4
				  "0000101" when distance_in1 = "000000101" else --5
				  "0000110" when distance_in1 = "000000110" else --6
				  "0000111" when distance_in1 = "000000111" else --7
				  "0001000" when distance_in1 = "000001000" else --8
				  "0001001" when distance_in1 = "000001001" else --9
				  "0001010" when distance_in1 = "000001010" else --10
				  ---------------despues de 10cm---------------- 
				  "0000001" when distance_in1 = "000001011" else --11
				  "0000010" when distance_in1 = "000001100" else --12
				  "0000011" when distance_in1 = "000001101" else --13
				  "0000100" when distance_in1 = "000001110" else --14
				  "0000101" when distance_in1 = "000001111" else --15
				  "0000110" when distance_in1 = "000010000" else --16
				  "0000111" when distance_in1 = "000010001" else --17
				  "0001000" when distance_in1 = "000010010" else --18
				  "0001001" when distance_in1 = "000010011" else --19
				  "0000000" when distance_in1 = "000010100" else --20
				  ---------------despues de 20cm---------------- 				  
				  "0000001" when distance_in1 = "000010101" else --21
				  "0000010" when distance_in1 = "000010110" else --22
				  "0000011" when distance_in1 = "000010111" else --23
				  "0000100" when distance_in1 = "000011000" else --24
				  "0000101" when distance_in1 = "000011001" else --25
				  "0000110" when distance_in1 = "000011010" else --26
				  "0000111" when distance_in1 = "000011011" else --27
				  "0001000" when distance_in1 = "000011100" else --28
				  "0001001" when distance_in1 = "000011101" else --29
				  "0000000" when distance_in1 = "000011110" else --30
				  ---------------despues de 30cm---------------- 				   
				  "0000001" when distance_in1 = "000011111" else --31
				  "0000010" when distance_in1 = "000100000";     --32
				  
decenas 		<="0000000" when distance_in1 = "000000000" else 
				  "0000000" when distance_in1 = "000000001" else
				  "0000000" when distance_in1 = "000000010" else
				  "0000000" when distance_in1 = "000000011" else
				  "0000000" when distance_in1 = "000000100" else
				  "0000000" when distance_in1 = "000000101" else
				  "0000000" when distance_in1 = "000000110" else
				  "0000000" when distance_in1 = "000000111" else
				  "0000000" when distance_in1 = "000001000" else
				  "0000000" when distance_in1 = "000001001" else
				  "0000001" when distance_in1 = "000001010" else
				  ---------------despues de 10cm---------------- 
				  
				  "0000001" when distance_in1 = "000001011" else
				  "0000001" when distance_in1 = "000001100" else
				  "0000001" when distance_in1 = "000001101" else
				  "0000001" when distance_in1 = "000001110" else
				  "0000001" when distance_in1 = "000001111" else
				  "0000001" when distance_in1 = "000010000" else
				  "0000001" when distance_in1 = "000010001" else
				  "0000001" when distance_in1 = "000010010" else
				  "0000001" when distance_in1 = "000010011" else
				  "0000010" when distance_in1 = "000010100" else
				  ---------------despues de 20cm---------------- 
				  "0000010" when distance_in1 = "000010101" else
				  "0000010" when distance_in1 = "000010110" else
				  "0000010" when distance_in1 = "000010111" else
				  "0000010" when distance_in1 = "000011000" else
				  "0000010" when distance_in1 = "000011001" else
				  "0000010" when distance_in1 = "000011010" else
				  "0000010" when distance_in1 = "000011011" else
				  "0000010" when distance_in1 = "000011100" else
				  "0000010" when distance_in1 = "000011101" else
				  "0000011" when distance_in1 = "000011110" else
				   ---------------despues de 30cm---------------- 
				  "0000011" when distance_in1 = "000011111" else
				  "0000011" when distance_in1 = "000100000";	

process(edo_p)
begin
	case edo_p is 
			when display1 =>
				edo_f <= display2;
				transistor <= "01";
			when display2 =>
				edo_f <= display1;
				transistor <= "10";
			when others => null;
	end case;
end process;

process(clk_in)
begin	
	if rising_edge(clk_in) then
		conta_switch <= conta_switch +1;
		if conta_switch = conta_sw_fin then
			conta_switch <= 0;
			edo_p <= edo_f;
		end if;
	end if;
end process;

contador_principal <= unidades when edo_p = display1 else
						    decenas;
							 
display_sal <=    not "0111111" when contador_principal = "0000000" else
						not "0000110" when contador_principal = "0000001" else
						not "1011011" when contador_principal = "0000010" else 
						not "1001111" when contador_principal = "0000011" else 
						not "1100110" when contador_principal = "0000100" else
						not "1101101" when contador_principal = "0000101" else
						not "1111101" when contador_principal = "0000110" else
						not "0000111" when contador_principal = "0000111" else
						not "1111111" when contador_principal = "0001000" else
						not "1101111";

end behavioral;
