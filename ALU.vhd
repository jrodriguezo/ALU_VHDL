--author: Jesus Rodriguez Ovejero

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;


entity ALU is

Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
		 b : in STD_LOGIC_VECTOR (7 downto 0);
		 control : in STD_LOGIC_VECTOR (2 downto 0);
		 resultado : out STD_LOGIC_VECTOR (7 downto 0);
		 error : out STD_LOGIC);
end ALU;

architecture a_ALU of ALU is

-- señales auxiliares 
-- SUM
signal suma : STD_LOGIC_VECTOR(7 downto 0);
signal resta : STD_LOGIC_VECTOR(7 downto 0);
-- LOG
signal cable_aux_ROM: STD_LOGIC_VECTOR(2 downto 0);
signal resultado_LOG: STD_LOGIC_VECTOR(7 downto 0);
-- signal idle_aux: STD_LOGIC; se puede tambien usar
signal resultado_distance: STD_LOGIC_VECTOR(7 downto 0);
signal error_suma , error_resta, error_LOG: STD_LOGIC;

-- declaracion de componentes
	
	component HAMMING is
		Port ( byte1 : in STD_LOGIC_VECTOR (7 downto 0);
				 byte2 : in STD_LOGIC_VECTOR (7 downto 0);
				 distance : out STD_LOGIC_VECTOR (7 downto 0));
	end component;
		
	component CP is
		Port ( e : in STD_LOGIC_VECTOR (7 downto 0);
				 y : out STD_LOGIC_VECTOR (2 downto 0);
				 idle : out STD_LOGIC);
	end component;
	
	component ROM is
		Port ( addr : in STD_LOGIC_VECTOR (2 downto 0);
				 data : out STD_LOGIC_VECTOR (7 downto 0));
	end component;
	

begin

-- port map
	Unit_HAMMING: HAMMING port map( byte1 => a,
											  byte2 => b,
											  distance => resultado_distance);

   Unit_CP: CP port map( e => a,
								 y=>cable_aux_ROM,
								 idle => open); -- ademas se puede hacer asi : idle => idle_aux
								 
	Unit_ROM: ROM port map(addr =>cable_aux_ROM,
								  data => resultado_LOG);
										
-- zona de control

suma <= (signed(a)+signed(b)) ;
resta <= (signed(a)-signed(b));

error_suma <= '1'   when ((((a(7)='0') and (b(7)='0'))and suma(7)='1') or (((a(7)='1') and (b(7)='1') and suma(7)='0'))) else '0';
error_resta <= '1'  when ((((a(7)='0') and (b(7)='1'))and resta(7)='1') or (((a(7)='1') and (b(7)='0') and resta(7)='0'))) else '0';
error_LOG <= '1'   when (signed(a)<0 or a=0) else '0';

with control select 
							resultado <=
				suma                when "000",
				resta               when "001",
				(not a)				  when "010",
				(a nand b) 			  when "011",	
				(a nor b)			  when "100",
				'0'&a(7 downto 1)   when "101",
				resultado_distance  when "110",				
			   resultado_LOG		  when "111",
				"00000000"          when others;
				
				
with control select 
							error <=
				error_suma          when "000",
				error_resta         when "001",
				'0'				     when "010",
				'0' 			        when "011",	
				'0'			        when "100",
				a(0)                when "101",
				'0'                 when "110",				
			   error_LOG		     when "111",
				'0'          when others;
				
end a_ALU;

