library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;



entity HAMMING is
Port ( byte1 : in STD_LOGIC_VECTOR (7 downto 0);
		 byte2 : in STD_LOGIC_VECTOR (7 downto 0);
		 distance : out STD_LOGIC_VECTOR (7 downto 0));
end HAMMING;

architecture a_HAMMING of HAMMING is

	component FA is
		Port ( a : in STD_LOGIC;
				 b : in STD_LOGIC;
				 cin : in STD_LOGIC;
				 s : out STD_LOGIC;
				 cout : out STD_LOGIC);
	end component;
	
signal xor_resultado: STD_LOGIC_VECTOR (7 downto 0);
signal cout_rojo: STD_LOGIC_VECTOR (3 downto 0);
signal cout_U6, cout_U5, sum_U5,sum_U1,sum_U2,sum_U3: STD_LOGIC;

begin

	xor_resultado <= byte1 xor byte2;
	
	U1_sumador: FA port map(
					a => xor_resultado(2),
					b => xor_resultado(1),
					cin=> xor_resultado(0),
					s=> sum_U1,
					cout=> cout_rojo(0));
					
	U2_sumador: FA port map(
					a => xor_resultado(5),
					b => xor_resultado(4),
					cin=> xor_resultado(3),
					s=> sum_U2,
					cout=> cout_rojo(1));
					
	U3_sumador: FA port map(
					a => '0',
					b => xor_resultado(7),
					cin=> xor_resultado(6),
					s=> sum_U3,
					cout=> cout_rojo(2));
					
	U4_sumador: FA port map(
					a => sum_U3,
					b => sum_U2, 
					cin=> sum_U1,
					s=> distance(0),
					cout=> cout_rojo(3));
					
	U5_sumador: FA port map(
					a => cout_rojo(2),
					b => cout_rojo(1),
					cin=> cout_rojo(0),
					s=> sum_U5,
					cout=> cout_U5);
					
	U6_sumador: FA port map(
					a => '0',
					b => sum_U5,
					cin=> cout_rojo(3),--S0
					s=> distance(1),--S1
					cout=> cout_U6);
					
	U7_sumador: FA port map(
					a => '0',
					b => cout_U5,
					cin=> cout_U6,
					s=> distance(2),--S2
					cout=> distance(3)); --S3

	distance(4) <= '0';
	distance(5) <= '0';
	distance(6) <= '0';
	distance(7) <= '0';
	
	
end a_HAMMING;

