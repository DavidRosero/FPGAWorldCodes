------------------------------------------------------------------------------------------
--EJEMPLO DE USO DEL MÓDULO BLUETOOTH HC06 COMO RECEPTOR
--CONECTADO A LA TARJETA CYCLONE IV, USANDO PROTOCOLO RS-232 Y
--UNA APLICACIÓN DE CELULAR COMERCIAL QUE ENVÍA CÓDIGO ASCII.
------------------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

----------------------------------------------------------
ENTITY CONTROLADOR IS 
PORT(	
		RX_DATA		: IN STD_LOGIC_VECTOR(7 DOWNTO 0); --SALIDA A LEDS
		LEDS        :OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
END CONTROLADOR;
----------------------------------------------------------
ARCHITECTURE BEHAVIORAL OF CONTROLADOR IS

SIGNAL WIRE1 : STD_LOGIC_VECTOR(3 DOWNTO 0); 

BEGIN				
PROCESS(RX_DATA,WIRE1)
BEGIN
	CASE RX_DATA IS
		WHEN "00000011" => WIRE1 <= "0111"; --3 ---> ENCEDER 1 LED
		WHEN "00000101" => WIRE1 <= "0011"; --5 ---> ENCEDER 2 LED
		WHEN "00000111" => WIRE1 <= "0001"; --7 ---> ENCEDER 3 LED
		WHEN "00001111" => WIRE1 <= "0000"; --15 --> ENCEDER 4 LED
		WHEN OTHERS => WIRE1 <= "1111";
	END CASE;
END PROCESS;

LEDS <= WIRE1;



							
END BEHAVIORAL; --FIN DE LA ARQUITECTURA
