----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:19:50 11/15/2017 
-- Design Name: 
-- Module Name:    FA - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FA is
Port ( a : in STD_LOGIC;
		 b : in STD_LOGIC;
		 cin : in STD_LOGIC;
		 s : out STD_LOGIC;
		 cout : out STD_LOGIC);
end FA;

architecture a_FA of FA is

begin

--s <= ((a XOR b) XOR Cin) ;
--Cout <= ((a AND b) OR (Cin AND a) OR (Cin AND a);

s <= a xor b xor cin;
cout <= (a and b) or (cin and (a or b));


end a_FA;

