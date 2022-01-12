-- file name : traffic_light.vhd
-- Author : kimjeonghwan
-- date time : 2022-01-06
-- Every 3 seconds, Cycle through 4 states(red_state, green_state, blue_state,yellow_state).

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity traffic_light is
	port( ck, rst : in std_logic;
			red_light, green_light, blue_light, yellow_light : out std_logic); 
end traffic_light;

architecture Behavioral of traffic_light is
	type stype is (red_state, green_state, blue_state, yellow_state);
	signal st : stype;
begin

	process(ck, rst)
		variable cnt : integer :=0; --cnt restores time flow until 3.
		
		begin
		
		if(rst='0') then 
			st <= red_state;
		elsif (ck'event and ck='1') then
			
			case st is
			
				when red_state =>
					if(cnt < 3) then
						cnt := cnt + 1;
						st <= red_state;
					else
						cnt := 0;
						st <= green_state;
					end if;
				
				when green_state =>
					if(cnt < 3) then
						cnt := cnt + 1;
						st <= green_state;
					else
						cnt := 0;
						st <= blue_state;
					end if;
				
				when blue_state =>
					if(cnt < 3) then
						cnt := cnt + 1;
						st <= blue_state;
					else
						cnt := 0;
						st <= yellow_state;
					end if;
					
				when yellow_state =>
					if(cnt < 3) then
						cnt := cnt + 1;
						st <= yellow_state;
					else
						cnt := 0;
						st <= red_state;
					end if;
			end case;
		end if;
	end process;
	
	red_light <= '1' when st=red_state else
					'0';
	green_light <= '1' when st=green_state else
			'0';
	blue_light <= '1' when st=blue_state else
			'0';
	yellow_light <= '1' when st=yellow_state else
			'0';
			
end Behavioral;


