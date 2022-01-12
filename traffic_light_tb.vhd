-- file name :traffic_light_tb.vhd
-- Author : kimjeonghwan
-- date time : 2022-01-06
-- Test Bench of traffic_light.vhd, It call package, traffic_light_pk which I made to skip component part.


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.traffic_light_pk.all; -- call package traffic_light_pk

entity traffic_light_tb is
end traffic_light_tb;

architecture Behavioral of traffic_light_tb is

	signal ck : std_logic ;
	signal rst : std_logic ;
	signal rl : std_logic;
	signal gl : std_logic;
	signal bl : std_logic;
	signal arl : std_logic;
	
begin
	
	main1 : traffic_light port map (ck,rst, rl,gl,bl,arl);
	
	pro1 : process
			begin
				ck <= '0'; wait for 5ns;
				ck <= '1'; wait for 5ns;		
			end process pro1;
			
	pro2 : process
			begin
				rst <= '1'; wait for 50ns;
				rst <= '0'; wait for 10ns;
				rst <= '1'; wait for 10ms;
			end process pro2;

	
end Behavioral;

