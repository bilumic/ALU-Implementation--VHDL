library ieee;
use ieee.std_logic_1164.all;
----------------------------------------
entity logic is 
	generic (n : integer );
	port (x,y : in std_logic_vector (n-1 downto 0); 
		  func : in std_logic_vector (2 downto 0);
		  res : out std_logic_vector (n-1 downto 0));
end logic;
-----------------------------------------
architecture dataflowlogic of logic is
begin
	result : for i in 0 to n-1 generate
		res(i) <= not (y(i)) when func = "000" else
				y(i) or x(i) when func = "001" else
				y(i) and x(i) when func = "010" else
				y(i) xor x(i) when func = "011" else
				y(i) nor x(i) when func = "100" else
				y(i) nand x(i) when func = "101" else
				y(i) xnor x(i) when func = "111" else
				'0';
	end generate; 
end dataflowlogic;

		  