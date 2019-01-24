library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity ROM is

Port ( addr : in STD_LOGIC_VECTOR (2 downto 0);
		 data : out STD_LOGIC_VECTOR (7 downto 0));
end ROM;

architecture a_ROM of ROM is

begin
with addr select 
		data <=
				   "00000000" when "000", -- 0 
				   "00000001" when "001", -- 1
				   "00000110" when "010", --int(6.06)=6 ............... en todos REDONDEO HACIA ABAJO ........
				   "00010001" when "011", --int(17.39)=17 								
				   "00100100" when "100", --int(36.75)=36 
				   "01000001" when "101", --int(65.66)=65
				   "01101001" when "110" , --int(105.49)=105
				   "10011101" when "111", --int(157.49)=157 ..................................................
					"00000000" when others; --por si acaso
end a_ROM;

