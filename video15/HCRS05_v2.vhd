library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity HCSR05_v2 is
generic (n: integer :=20);
Port ( 	  clk : in  STD_LOGIC;
           echo : in  STD_LOGIC;
           Trigger : buffer  STD_LOGIC;
           display_out : out  STD_LOGIC_VECTOR (6 downto 0);
			  transistor : out STD_LOGIC_VECTOR (1 downto 0)
		);
end HCSR05_v2;

architecture Behavioral of HCSR05_v2 is 

COMPONENT TriggerGen
	PORT(
		clk : IN std_logic;          
		trigger : OUT std_logic
		
		);
	END COMPONENT;

COMPONENT counter
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		enable : IN std_logic;          
		q : OUT std_logic_vector(19 downto 0)
		);
	END COMPONENT;
	
COMPONENT distance_calculation
	PORT(
		echo_count : IN std_logic_vector(19 downto 0);          
		distance : OUT std_logic_vector(8 downto 0)
		);
	END COMPONENT;

COMPONENT display_decoder
	PORT(
		clk_in: in std_logic;
		distance_in1 : IN std_logic_vector(8 downto 0);          
		display_sal : OUT std_logic_vector(6 downto 0);
		transistor : out STD_LOGIC_VECTOR (1 downto 0)
		
		);
	END COMPONENT;

signal Trigger_out: std_logic;
signal echo_counter1 : STD_LOGIC_VECTOR (19 downto 0);
signal echo_count : STD_LOGIC_VECTOR (19 downto 0);
signal distance_bits : std_logic_vector(8 downto 0);


begin


Inst_counter: counter PORT MAP(
		clk,
		Trigger_out,
		echo,
		echo_counter1 
	);
	
	process(echo) begin
		if falling_edge(echo) then
			echo_count <= echo_counter1;
		end if;
	
	end process;
	
Inst_TriggerGen: TriggerGen PORT MAP(
		clk,
		Trigger_out 
	);
	
Inst_distance_calculation: distance_calculation PORT MAP(
		echo_count,
		distance_bits 
	);
	
Inst_display_decoder: display_decoder PORT MAP(
		clk,
		distance_bits,
		display_out,
		transistor
		 
	);

Trigger <= Trigger_out;




end Behavioral;
		