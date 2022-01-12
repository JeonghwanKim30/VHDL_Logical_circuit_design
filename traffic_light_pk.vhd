-- file name : traffic_light_pk.vhd
-- Author : kimjeonghwan
-- date time : 2022-01-06
-- Packing traffic_light.vhd

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package	traffic_light_pk is

	component traffic_light
		port (ck,rst : in std_logic;
				red_light, green_light, blue_light, yellow_light : out std_logic);
	end component traffic_light;
	
end package traffic_light_pk;

