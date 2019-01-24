library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity CP is
Port ( e : in STD_LOGIC_VECTOR (7 downto 0);
		 y : out STD_LOGIC_VECTOR (2 downto 0);
		 idle : out STD_LOGIC);
end CP;

architecture a_CP of CP is

signal H: STD_LOGIC_VECTOR (7 downto 0); -- prioridades
begin
 
 idle<=NOT e(7) AND NOT e(6) AND NOT e(5) AND NOT e(4) AND NOT e(3) AND NOT e(2) AND NOT e(1) AND NOT e(0);
 
 H(7)<=e(7);
 H(6)<=NOT e(7) AND e(6);
 H(5)<=NOT e(7) AND NOT e(6) AND e(5);
 H(4)<=NOT e(7) AND NOT e(6) AND NOT e(5) AND e(4);
 H(3)<=NOT e(7) AND NOT e(6) AND NOT e(5) AND NOT e(4) AND e(3);
 H(2)<=NOT e(7) AND NOT e(6) AND NOT e(5) AND NOT e(4) AND NOT e(3) AND e(2);
 H(1)<=NOT e(7) AND NOT e(6) AND NOT e(5) AND NOT e(4) AND NOT e(3 )AND NOT e(2) AND e(1);
 H(0)<=NOT e(7) AND NOT e(6) AND NOT e(5) AND NOT e(4) AND NOT e(3) AND NOT e(2) AND NOT e(1) AND e(0);
 
 y(2)<=(H(4) OR H(5) OR H(6) OR H(7));
 y(1)<=(H(2) OR H(3) OR H(6) OR H(7));
 y(0)<=(H(1) OR H(3) OR H(5) OR H(7)); 



end a_CP;

