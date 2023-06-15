----------------------------------------------------------------------------------
-- COPYRIGHT 2019 Jes�s Eduardo M�ndez Rosales
--This program is free software: you can redistribute it and/or modify
--it under the terms of the GNU General Public License as published by
--the Free Software Foundation, either version 3 of the License, or
--(at your option) any later version.
--
--This program is distributed in the hope that it will be useful,
--but WITHOUT ANY WARRANTY; without even the implied warranty of
--MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--GNU General Public License for more details.
--
--You should have received a copy of the GNU General Public License
--along with this program.  If not, see <http://www.gnu.org/licenses/>.
--
--
--							LIBRER�A SENSOR ULTRAS�NICO
--
--
-- Descripci�n: Con �sta librer�a podr�s controlar un sensor ultras�nico HC-SR04.
--
-- Caracter�sticas:
--              - La libreria utiliza un componente que genera la divisi�n y obtener los valores de la distancia. Utiliza el m�todo de aproximaci�n mediante
--                sumatorias y comparaciones, dependiendo el tama�o del numerador y la frecuencia de reloj es el tiempo que le toma al componente realizar la divisi�n.
--              - La librer�a genera el pulso Trigger con los siguientes tiempos:
--
--                  |--10us--| 
--
--    TRIGGER	____/����������\_________ ... ____________/����������\__________ ... ____________/����������\_____
--                  1er pulso                             2do pulso                               pulso N
--					    |---------------62.5 ms---------------|
--
--  DATO_LISTO	_________________________ ... _____________/���\_______________ ... ______________/���\___________
--                                                        |---|
--                                                     (1/FPGA_CLK)
--
--
-- NOTA: Estos son los tiempos sugeridos en la hoja de especificaciones del sensor, en caso
--       de querer cambiar estos tiempos se debe modificar los valores de "ESCALA_PERIODO_TRIGGER" 
--			y "ESCALA_TRIGGER".
--
-- Una vez que se manda la se�al de trigger, el sensor responde con un pulso (ECO) el cual se mide y se obtiene
-- un valor de escala (ESCALA_TOTAL) para despu�s convertir ese valor en tiempo de duraci�n en microsuegundos (TIEMPO_MICROSEGUNDOS).
-- Y finalmente se hace la conversi�n de tiempo a distancia cuya f�rmula se obtuvo en la hoja de especificaciones del sensor.
--
------------------------------------------------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity INTESC_LIB_ULTRASONICO_RevC is

generic(
			FPGA_CLK : INTEGER := 50_000_000
);

PORT(
		CLK 			 : IN  STD_LOGIC;                   -- Reloj del FPGA.
		ECO 			 : IN  STD_LOGIC;                   -- Eco del sensor ultras�nico.
		TRIGGER 		 : OUT STD_LOGIC;                   -- Trigger del sensor ultras�nico.
		DATO_LISTO 	 : OUT STD_LOGIC;                   -- Bandera que indica cuando el valor de la distancia es correcto.
		DISTANCIA_CM : OUT STD_LOGIC_VECTOR(8 DOWNTO 0) -- Valor de la distancia en cent�metros-
);

end INTESC_LIB_ULTRASONICO_RevC;

architecture Behavioral of INTESC_LIB_ULTRASONICO_RevC is


CONSTANT VAL_1US 					  : INTEGER := (FPGA_CLK/1_000_000); -- Constante con el n�mero de periodos de CLK que hay en un microsegundo. Se utiliza para el c�lculo de la distancia.
CONSTANT ESCALA_PERIODO_TRIGGER : INTEGER := (FPGA_CLK/16);        -- Constante para generar el periodo del Trigger.
CONSTANT ESCALA_TRIGGER 		  : INTEGER := (FPGA_CLK/100_000);   -- Constante para generar el ciclo de trabajo del Trigger.

COMPONENT DIVISION_ULTRASONICO_RevA
PORT(
	CLK       : IN  std_logic;
	INI       : IN  std_logic;
	DIVIDENDO : IN  std_logic_vector(31 downto 0);
	DIVISOR   : IN  std_logic_vector(31 downto 0);          
	RESULTADO : OUT std_logic_vector(31 downto 0);
	OK        : OUT std_logic
	);
END COMPONENT;

signal ok		  				 : std_logic;                                      -- Bandera que indica fin de divisi�n.
signal ini		  				 : std_logic;                                      -- Bit que inicia el proceso de divisi�n.
signal trigger_s 				 : std_logic := '0';                               -- Bit auxiliar para Trigger y tambi�n se utiliza como indicador para mandar la distancia.
signal calcular 				 : std_logic := '0';                               -- Bit que indica cu�ndo calcular la divisi�n.
signal dividendo 				 : std_logic_vector(31 downto 0);                  -- Operadior dividendo.
signal divisor   				 : std_logic_vector(31 downto 0);                  -- Operador divisor.
signal resultado 				 : std_logic_vector(31 downto 0);                  -- Resultado de la divisi�n.
signal conta_trigger 		 : integer range 0 to escala_periodo_trigger := 0; -- Contador para la generaci�n del Trigger.
signal conta_eco 				 : integer := 0;                                   -- Contador para el c�lculo del tiempo de Eco.
signal escala_total 			 : integer := 0;                                   -- Auxiliar que adquiere el n�mero de periodos que se obtubieron con Eco en '1' y as� calcular la distancia.
signal tiempo_microsegundos : integer := 0;                                   -- Se�al que guarda el tiempo en microsegundos.
signal edo_res : integer range 0 to 7 := 0;                                   -- Se�al para la m�quina de estados que calcula la distancia.
signal edo_eco : integer range 0 to 7 := 0;                                   -- Se�al para la m�quina de estados que calcula los periodos de CLK con Eco en '1'.

begin

-- Instancia del componente que realiza la divisi�n.
Inst_DIVISION_ULTRASONICO_RevA: DIVISION_ULTRASONICO_RevA PORT MAP(
	CLK, INI, DIVIDENDO, DIVISOR, RESULTADO, OK );

--PROCESO QUE GENERA SE�AL DE TRIGGER---
process(CLK)
begin
	if rising_edge(CLK) then
		conta_trigger <= conta_trigger+1;
		if conta_trigger = 0 then
			trigger_s <= '1';
		elsif conta_trigger = escala_trigger then
			trigger_s <= '0';
		elsif conta_trigger = escala_periodo_trigger then
			conta_trigger <= 0;
		end if;
	end if;
end process;

TRIGGER <= trigger_s;
----------------------------------------

--PROCESO QUE OBTIENE ESCALA DE ECO---
process(CLK)
begin
if rising_edge(CLK) then
	if edo_eco = 0 then -- Se espera a que Eco se ponga a '1'.
		if eco = '1' then
			edo_eco <= 1;
		end if;
		
	elsif edo_eco = 1 then
		if eco = '1' then -- Cuenta el n�mero de periodos cuando Eco se encuentra en '1'.
			conta_eco <= conta_eco+1;
		else
			edo_eco <= 2;
		end if;
		
	elsif edo_eco = 2 then -- Se reinicia el contador cuando Eco se hace '0' y se almacena el �ltimo valor registrado en "conta_eco". Se pone a '1' "calcular".
		conta_eco <= 0;
		escala_total <= conta_eco;
		calcular <= '1';
		edo_eco <= 3;
			
	elsif edo_eco = 3 then -- Se desactuva el bit "calcular" y se regresa al estado 0.
		calcular <= '0';
		edo_eco <= 0;
		
	end if;
end if;
end process;
--------------------------------------

--Proceso que divide y obtiene el resultado final--
process(CLK)
begin
if rising_edge(CLK) then -- Espera a que transcurra el primer trigger para realizar el primer c�lculo y tenerlo listo en el segundo trigger.
	if edo_res = 0 then
		if trigger_s = '1' then
			edo_res <= 1;
		end if;
		
	elsif edo_res = 1 then -- Espera a que se le indique cu�ndo realizar la divisi�n para obtener los microsegundos que dur� "Eco".
		if calcular = '1' then
			dividendo <= conv_std_logic_vector(escala_total,32);
			divisor <= conv_std_logic_vector(VAL_1US,32);
			edo_Res <= 3;
		end if;
		
	elsif edo_res = 3 then -- Espera a que finalice el proceso de divisi�n.
		if ok = '1' then
			edo_res <= 4;
			ini <= '0';
		else
			ini <= '1';
		end if;
		
	elsif edo_res = 4 then -- Se realiza la divisi�n Tmicrosegundos/58 para obtener el valor de la distancia.
		dividendo <= resultado;
		divisor <= conv_std_logic_vector(58,32);
		edo_res <= 5;
		
	elsif edo_res = 5 then -- Espera a que finalice el proceso de divisi�n.
		if ok = '1' then
			edo_res <= 6;
			ini <= '0';
		else
			ini <= '1';
		end if;
	
	elsif edo_res = 6 then -- Espera a que Trigger se ponga a '1' y se mande la distancia por el puerto "DISTANCIA_CM". Se activa la bandera "DATO_LISTO".
		if trigger_s = '1' then
			DATO_LISTO <= '1';
			DISTANCIA_CM <= resultado(8 downto 0);
			edo_res <= 7;
		end if;
		
	
	elsif edo_res = 7 then -- Se desactiva la bandera "DATO_LISTO".
		DATO_LISTO <= '0';
		edo_res <= 1;
	
	end if;
end if;
end process;



end Behavioral;

