library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

Entity Controlador is
		port(
				led: in std_logic_vector(7 downto 0);
				sw1,sw2,sw3,sw4: out std_logic_vector(2 downto 0)
			);
end Controlador;
	
Architecture Behavioral of Controlador is

signal sw0_1:std_logic_vector(0 to 2);
signal sw0_2:std_logic_vector(0 to 2);
signal sw0_3:std_logic_vector(0 to 2);
signal sw0_4:std_logic_vector(0 to 2);
begin
-------------------------------------------------------------------------------------
motor1:process(led,sw0_1)
begin
	case led is
		--LOGICA NORMAL         --LOGICA INVERSA
		when "00000011" => sw0_1 <= "001"; --3 ---> Derecha (MOV ADELANTE)
		when "00000101" => sw0_1 <= "000"; --5 <--- Izquieda (MOV ATRAS)
		when "00000111" => sw0_1 <= "001"; --7 ---> Derecha (MOV DERECHA)
		when "00001001" => sw0_1 <= "000"; --9 <--- Izquierda (MOV IZQUIERDA)
		when "00001011" => sw0_1 <= "001"; --11 ---> Derecha (DIAG DERECHA_ARRIBA)
		when "00001101" => sw0_1 <= "000"; --13 <--- Izquierda (DIAG IZQUIERDA_ABAJO)
		when "00010011" => sw0_1 <= "001"; --19 ---> Derecha (GIRO IZQUIERDA)
		when "00010101" => sw0_1 <= "000"; --21 <--- Izquierda (GIRO DERECHA)
		when others => sw0_1 <= "111"; --1 DETENER MOTORES
	end case;
end process;


motor2:process(led,sw0_2)
begin
	case led is
		--LOGICA NORMAL         --LOGICA INVERSA
		when "00000011" => sw0_2 <= "000"; --3 <--- Izquierda (MOV ADELANTE)
		when "00000101" => sw0_2 <= "001"; --5 ---> Derecha (MOV ATRAS)
		when "00000111" => sw0_2 <= "001"; --7 ---> Derecha (MOV DERECHA)
		when "00001001" => sw0_2 <= "000"; --9 <--- Izquierda (MOV IZQUIERDA)
		when "00001111" => sw0_2 <= "000"; --15 <--- Izquierda (DIAG IZQUIERDA_ARRIBA)
		when "00010001" => sw0_2 <= "001"; --17 ---> Derecha (DIAG DERECHA_ABAJO)
		when "00010011" => sw0_2 <= "001"; --19 ---> Derecha (GIRO IZQUIERDA)
		when "00010101" => sw0_2 <= "000"; --21 <--- Izquierda (GIRO DERECHA)
		when others => sw0_2 <= "111"; --1 DETENER MOTORES
	end case;
end process;

motor3:process(led,sw0_3)
begin
	case led is
		--LOGICA NORMAL         --LOGICA INVERSA
		when "00000011" => sw0_3 <= "000"; --3 <--- Izquierda (MOV ADELANTE)
		when "00000101" => sw0_3 <= "001"; --5 ---> Derecha (MOV ATRAS)
		when "00000111" => sw0_3 <= "001"; --7 ---> Derecha (MOV DERECHA)
		when "00001001" => sw0_3 <= "000"; --9 <--- Izquierda (MOV IZQUIERDA)
		when "00001111" => sw0_3 <= "000"; --15 <--- Izquierda (DIAG IZQUIERDA_ARRIBA)
		when "00010001" => sw0_3 <= "001"; --17 ---> Derecha (DIAG DERECHA_ABAJO)
		when "00010011" => sw0_3 <= "000"; --19 <--- Izquierda (GIRO IZQUIERDA)
		when "00010101" => sw0_3 <= "001"; --21 ---> Derecha (GIRO DERECHA)
		when others => sw0_3 <= "111"; --1 DETENER MOTORES
	end case;
end process;

motor4:process(led,sw0_4)
begin
	case led is
		--LOGICA NORMAL         --LOGICA INVERSA
		when "00000011" => sw0_4 <= "001"; --3 ---> Derecha (MOV ADELANTE)
		when "00000101" => sw0_4 <= "000"; --5 <--- Izquierda (MOV ATRAS)
		when "00000111" => sw0_4 <= "001"; --7 ---> Derecha (MOV DERECHA)
		when "00001001" => sw0_4 <= "000"; --9 <--- Izquierda (MOV IZQUIERDA)
		when "00001011" => sw0_4 <= "001"; --11 ---> Derecha (DIAG DERECHA_ARRIBA)
		when "00001101" => sw0_4 <= "000"; --13 <--- Izquierda (DIAG IZQUIERDA_ABAJO)
		when "00010011" => sw0_4 <= "000"; --19 <--- Izquierda (GIRO IZQUIERDA)
		when "00010101" => sw0_4 <= "001"; --21 ---> Derecha (GIRO DERECHA)
		when others => sw0_4 <= "111"; --1 DETENER MOTORES
	end case;
end process;
-------------------------------------------------------------------------------------


sw1(0) <= sw0_1(0);
sw1(1) <= sw0_1(1);
sw1(2) <= sw0_1(2);

sw2(0) <= sw0_2(0);
sw2(1) <= sw0_2(1);
sw2(2) <= sw0_2(2);

sw3(0) <= sw0_3(0);
sw3(1) <= sw0_3(1);
sw3(2) <= sw0_3(2);

sw4(0) <= sw0_4(0);
sw4(1) <= sw0_4(1);
sw4(2) <= sw0_4(2);


		
end Behavioral;