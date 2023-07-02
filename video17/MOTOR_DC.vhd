LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY MOTOR_DC IS
		PORT( 
				CLK,SW2,SW1,SW0 : IN STD_LOGIC;
				PWM1, PWM2		 : OUT STD_LOGIC
			
			 );
END MOTOR_DC;
	
ARCHITECTURE BEHAVIORAL OF MOTOR_DC IS

SIGNAL COUNT: INTEGER RANGE 0 TO 50_000;
SIGNAL SPEED: INTEGER;
 
BEGIN

PROCESS(CLK,SW0,SW1,SW2,SPEED)

	BEGIN
		IF (SW1='1' AND SW0='1')THEN
			SPEED <= 0;
		ELSIF (SW1='1' AND SW0='0')THEN
			SPEED <= 27_000;
		ELSIF (SW1='0' AND SW0='1')THEN
			SPEED <= 33_000;
		ELSE
			SPEED <= 50_000;
		END IF;
	
	IF (RISING_EDGE(CLK)) THEN
		COUNT <= COUNT+1;
	IF(COUNT = 49_999) THEN
		COUNT <= 0;
	END IF;
	
	IF(COUNT < SPEED) THEN
	 IF(SW2 = '0') THEN
		PWM2 <= '0';
		PWM1 <= '1';
	 ELSE
		PWM1 <= '0';
		PWM2 <= '1';
	 END IF;
	 ELSE
		PWM1 <= '0';
		PWM2 <= '0';
	 END IF;
	END IF;
	
END PROCESS;

END BEHAVIORAL;
