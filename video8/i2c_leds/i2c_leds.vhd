library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity i2c_leds is 
 port(
	scl						:inout std_logic;
	sda						:inout std_logic;
	clk						:in	 std_logic;
	rst						:in	 std_logic;
	led_o						:out	 std_logic_vector(7 downto 0)
 );
end entity;

architecture RTL of i2c_leds is

signal read_req			: std_logic;
signal data_to_master	: std_logic_vector(7 downto 0);
signal data_valid			: std_logic;
signal data_from_master : std_logic_vector(7 downto 0);

signal data_reg  : std_logic_vector(7 downto 0);


begin

i2c_slave0: entity work.I2C_slave(arch) port map (scl,sda,clk,rst, read_req, data_to_master,data_valid,data_from_master);

led_o				<= data_reg;
data_to_master <= data_reg+5;


process(clk)
 begin
 
  if(clk'event and clk= '1') then 
   if(data_valid='1') then 
	  data_reg <= data_from_master;
	end if;
  end if;
  




end process;

end architecture;
