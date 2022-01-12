-- filename : vending_machine.vhd

-- Author : Kimjeonghwan

-- description : this machine have 2 merchandises, cocoa and coffee. Each prices are 100, 150.
-- We have 300 in pocket. we can insert coins that's value is 50 and 100.
-- Machine also return coin , we inserted, when return button is activeted.
-- Using our money, we can get cocoa and coffee. if exception is occur, command will be rejected.

-- Date time : 2022.01.12
 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vhdl_2016114172 is
	port(coffee_button,cocoa_button,rst,coin50,coin100,return_button,ck : in std_logic;
			coffee_out, cocoa_out : out integer;
			coin50out,coin100out : out integer );
end vhdl_2016114172;

architecture Behavioral of vhdl_2016114172 is
	type stype is (s0, s50, s100, s150, s200, s250, s300);
	signal st : stype;
	
begin
	process (coffee_button,cocoa_button,rst,coin50,coin100,return_button)
	
		variable total : integer := 300; --total mean money that i have in pocket 
		variable coffee_value : integer := 0; -- Keep coffee number, i ordered. it send it's value to out port (coffee_out)
		variable cocoa_value : integer := 0;  -- Keep cocoa number, i ordered. it send it's value to out port (cocoa_out)
		
		--Num of coffee and cocoa is unchangeable without reset signal. so coffee_out and cocoa_out keep their value until program is over.
		--But, The number of coins returned does not hold a value because it only needs to be shown for a moment.
		
		begin
		
		if(rst ='0') then
			st <= s0;
			total := 300;
			coffee_value :=0;
			cocoa_value :=0;
			coin50out <=0;
			coin100out <=0;
			
		elsif(ck'event and ck='1') then
		
			case st is
				
				when s0 =>
					if(total >= 50 and coin50 = '1' and coin100 = '0') then
						st <= s50;
						coin50out <= 0;
						coin100out <= 0;
						coffee_value := coffee_value+0;
						cocoa_value := cocoa_value +0;
						total := total - 50;
					elsif(total >= 100 and coin100 = '1' and coin50 = '0') then
						st <= s100;
						coin50out <= 0;
						coin100out <= 0;
						coffee_value := coffee_value;
						cocoa_value := cocoa_value;	
						total := total - 100;
					else -- When order coffee, cocoa. or inserted 2 coin simultaneously, or there is no money left.
						coin50out <= 0;
						coin100out <= 0;
						coffee_value := coffee_value;
						cocoa_value := cocoa_value;
						st <= s0;
					end if;
				
				
				
				
				when s50 =>
					if(return_button = '1') then -- Check the return button first
						st <= s0;
						coin50out <= 1;
						coin100out <= 0;
						coffee_value := coffee_value;
						cocoa_value := cocoa_value;
						total := total + 50;
					elsif(total >= 50 and coin50 = '1' and coin100 = '0') then
						st <= s100;
						coin50out <= 0;
						coin100out <= 0;
						coffee_value := coffee_value;
						cocoa_value := cocoa_value;
						total := total - 50;
					elsif(total >= 100 and coin100 = '1' and coin50 = '0') then
						st <= s150;
						coin50out <= 0;
						coin100out <= 0;
						coffee_value := coffee_value;
						cocoa_value := cocoa_value;	
						total := total - 100;
					else -- When order coffee, cocoa. or inserted 2 coin simultaneously.
						st <= s100;
						coin50out <= 0;
						coin100out <= 0;
						coffee_value := coffee_value;
						cocoa_value := cocoa_value;
					end if;
					
					
					
				when s100 =>
					if(return_button = '1') then
						st <= s0;
						coin50out <= 0;
						coin100out <= 1;
						coffee_value := coffee_value;
						cocoa_value := cocoa_value;
						total := total + 100; 
					elsif(cocoa_button = '1' and coffee_button = '0') then
						st <= s0;
						coin50out <= 0;
						coin100out <= 0;
						coffee_value := coffee_value;
						cocoa_value := cocoa_value +1 ;
					elsif(total >= 50 and coin50 = '1' and coin100 = '0') then
						st <= s150;
						coin50out <= 0;
						coin100out <= 0;
						coffee_value := coffee_value;
						cocoa_value := cocoa_value;
						total := total - 50;
					elsif(total >= 100 and coin100 = '1' and coin50 = '0') then
						st <= s200;
						coin50out <= 0;
						coin100out <= 0;
						coffee_value := coffee_value;
						cocoa_value := cocoa_value;
						total := total - 100;
					else -- When order coffee, cocoa. or inserted 2 coin simultaneously.
						st <= s100;
						coin50out <= 0;
						coin100out <=0;
						coffee_value := coffee_value;
						cocoa_value := cocoa_value;
					end if;
				
				
				
				when s150 =>
					if(return_button = '1') then
						st <= s0;
						coin50out <=1;
						coin100out <= 1;
						coffee_value := coffee_value;
						cocoa_value := cocoa_value;
						total := total + 150;
					elsif(coffee_button = '1' and cocoa_button = '0') then
						st <= s0;
						coin50out <= 0;
						coin100out <= 0;
						coffee_value := coffee_value +1 ;
						cocoa_value := cocoa_value;
					elsif(cocoa_button = '1' and coffee_button = '0') then
						st <= s50;
						coin50out <= 0;
						coin100out <= 0;
						coffee_value := coffee_value;
						cocoa_value := cocoa_value + 1;
					elsif(total >= 50 and coin50 = '1' and coin100 = '0') then
						st <= s200;
						coin50out <= 0;
						coin100out <= 0;
						coffee_value := coffee_value;
						cocoa_value := cocoa_value;
						total := total - 50;
					elsif(total >= 100 and coin100 = '1' and coin50 = '0') then
						st <= s250;
						coin50out <= 0;
						coin100out <= 0;
						coffee_value := coffee_value;
						cocoa_value := cocoa_value;
						total := total - 100;
					else -- When order coffee, cocoa simultaneously. or inserted 2 coin simultaneously.
						st <= s150;
						coin50out <= 0;
						coin100out <=0;
						coffee_value := coffee_value;
						cocoa_value := cocoa_value;
					end if;				
				
				
				when s200 =>
					if(return_button = '1') then
						st <= s0;
						coin50out <=0;
						coin100out <= 2;
						coffee_value := coffee_value;
						cocoa_value := cocoa_value;
						total := total + 200;
					elsif(coffee_button = '1' and cocoa_button = '0') then
						st <= s50;
						coin50out <= 0;
						coin100out <= 0;
						coffee_value := coffee_value + 1;
						cocoa_value := cocoa_value;
					elsif(cocoa_button = '1' and coffee_button = '0') then
						st <= s100;
						coin50out <= 0;
						coin100out <= 0;
						coffee_value := coffee_value;
						cocoa_value := cocoa_value + 1;
					elsif(total >= 50 and coin50 = '1' and coin100 = '0') then
						st <= s250;
						coin50out <= 0;
						coin100out <= 0;
						coffee_value := coffee_value;
						cocoa_value := cocoa_value;
						total := total - 50;
					elsif(total >= 100 and coin100 = '1' and coin50 = '0') then
						st <= s300;
						coin50out <= 0;
						coin100out <= 0;
						coffee_value := coffee_value;
						cocoa_value := cocoa_value;
						total := total - 100;
					else -- When order coffee, cocoa simultaneously. or inserted 2 coin simultaneously.
						st <= s200;
						coin50out <= 0;
						coin100out <=0;
						coffee_value := coffee_value;
						cocoa_value := cocoa_value;
					end if;		
					
					
					
				when s250 =>
					if(return_button = '1') then
						st <= s0;
						coin50out <=1;
						coin100out <= 2;
						coffee_value := coffee_value;
						cocoa_value := cocoa_value;
						total := total + 250;
					elsif(coffee_button = '1' and cocoa_button = '0') then
						st <= s100;
						coin50out <= 0;
						coin100out <= 0;
						coffee_value := coffee_value + 1;
						cocoa_value := cocoa_value;
					elsif(cocoa_button = '1' and coffee_button = '0') then
						st <= s150;
						coin50out <= 0;
						coin100out <= 0;
						coffee_value := coffee_value;
						cocoa_value := cocoa_value +1;
					elsif(total >= 50 and coin50 = '1' and coin100 = '0') then
						st <= s300;
						coin50out <= 0;
						coin100out <= 0;
						coffee_value := coffee_value;
						cocoa_value := cocoa_value;
						total := total - 50;
					else  -- When order coffee, cocoa simultaneously. or inserted 2 coin simultaneously. or inserted 100 coin.
						st <= s250;
						coin50out <= 0;
						coin100out <=0;
						coffee_value := coffee_value;
						cocoa_value := cocoa_value;
					end if;
				
				
				
				when s300 =>
					if(return_button = '1') then
						st <= s0;
						coin50out <=0;
						coin100out <= 3;
						coffee_value := coffee_value;
						cocoa_value := cocoa_value;
						total := total + 300;
					elsif(coffee_button = '1' and cocoa_button = '0') then
						st <= s150;
						coin50out <= 0;
						coin100out <= 0;
						coffee_value := coffee_value +1;
						cocoa_value := cocoa_value;
					elsif(cocoa_button = '1' and coffee_button = '0') then
						st <= s200;
						coin50out <= 0;
						coin100out <= 0;
						coffee_value := coffee_value;
						cocoa_value := cocoa_value + 1;
					else -- When order coffee, cocoa simultaneously. or inserted coin simultaneously.
						st <= s300;
						coin50out <= 0;
						coin100out <=0;
						coffee_value := coffee_value;
						cocoa_value := cocoa_value;
					end if;
			
			end case;
			
			
			
		end if;
		
		coffee_out <= coffee_value;
		cocoa_out <= cocoa_value;
		
	end process;

		

		
end Behavioral;

