----------------------------------------------------------------------------------
-- COPYRIGHT 2019 Jesús Eduardo Méndez Rosales
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
--                         División
--
-- Descripción: Código que realiza divisiones mediante sumatorias, el algoritmo cuenta el número de iteraciones que fueron necesarias para que el divisor
--              sea igual o mayor al dividendo.
--
-- Características: 
--
--                - El codigo optimiza recursos pero aumenta el tiempo de cálculo.
--                - El tiempo que le tome al codigo calcular el resultado dependerá de la frecuencia de reloj y del número de iteraciones que se requerirán.
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity DIVISION_ULTRASONICO_RevA is

PORT(
		CLK 		 : IN  STD_LOGIC;                     -- Reloj FPGA.
		INI		 : IN  STD_LOGIC;                     -- Bit que inicia proceso de división.
		DIVIDENDO : IN  STD_LOGIC_VECTOR(31 DOWNTO 0); -- Operador dividendo.
		DIVISOR   : IN  STD_LOGIC_VECTOR(31 DOWNTO 0); -- Operador divisor.
		RESULTADO : OUT STD_LOGIC_VECTOR(31 DOWNTO 0); -- Resultado de la división.
		OK			 : OUT STD_LOGIC                      -- Bit que indica fin de división.
);

end DIVISION_ULTRASONICO_RevA;

architecture Behavioral of DIVISION_ULTRASONICO_RevA is

signal iteraciones : std_logic_vector(31 downto 0) := (others => '0'); -- Señal que cuenta el número de iteraciones.
signal dividendo_s : std_logic_vector(31 downto 0) := (others => '0'); -- Señal auxiliar para el dividendo.
signal divisor_s   : std_logic_vector(31 downto 0) := (others => '0'); -- Señal auxiliar para el divisor.
signal edo 			 : integer range 0 to 3 := 0;                        -- Señal para la máquina de estados.

begin

PROCESS(CLK)
begin
if rising_edge(CLK) then
	if edo = 0 then
		if ini = '1' then -- Espera a que el bit "ini" se ponga a '1'.
			dividendo_s <= DIVIDENDO;
			divisor_s <= DIVISOR;
			iteraciones <= (others => '0');
			edo <= 1;
		end if;
		
	elsif edo = 1 then -- Proceso de aproximación para calcular el número de iteraciones.
		if divisor_s <= dividendo_s then -- Si es menor o igual el proceso continúa.
			divisor_s <= divisor_s + DIVISOR;
			iteraciones <= iteraciones+1;
			edo <= 1;
		else -- Si la condición deja de cumplirse entonces se manda el resultado como el número de iteraciones. Se activa la bandera "ok".
			resultado <= iteraciones;
			ok <= '1';
			edo <= 2;
		end if;
		
	elsif edo = 2 then -- Se desactiva la bandera "ok".
		ok <= '0';
		edo <= 3;
	
	elsif edo = 3 then -- Estado dummy.
		edo <= 0;
	
	end if;
end if;
end process;


end Behavioral;

