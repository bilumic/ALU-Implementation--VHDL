library ieee;
USE ieee.std_logic_1164.all;
-----------------------------------------
entity addsub is
	generic (n : integer);
	port (x,y : in std_logic_vector (n-1 downto 0); 
		  func : in std_logic_vector (2 downto 0);
		  res : out std_logic_vector (n-1 downto 0);
		  cout : out std_logic) ;
end addsub ;

architecture dataflowaddsub of addsub is
component FA  
	PORT (xi, yi, cin: IN std_logic;
		res, cout: OUT std_logic);
end component;
	
signal cin : std_logic ;
signal x_temp,y_temp,res_temp,reg : std_logic_vector (n-1 downto 0) ;
signal O_vector : std_logic_vector (n-1 downto 0) := (others => '0');
begin 			
	x_temporary : for i in 0 to n-1 generate 
		x_temp(i) <= x(i) when func = "000" else
				not x(i) when (func = "010" or func  = "001") else
				'0' when func = "011" else
	            '1' when func = "100" else '0' ;
		y_temp(i) <= '0' when func = "010" else y(i) ;		
	end generate ;
	cin <= '1' when (func = "001") or (func = "010") or (func = "011") else '0' ;
	first : FA port map(
			xi => x_temp(0),
			yi => y_temp(0),
			cin => cin,
			res => res_temp(0),
			cout => reg(0)
	);
	
	rest : for i in 1 to n-1 generate
		chain : FA port map(
			xi => x_temp(i),
			yi => y_temp(i),
			cin => reg(i-1),
			res => res_temp(i),
			cout => reg(i) 
		);
	end generate;
	res <= res_temp when ((func = "000") or (func = "001") or (func = "010") or (func = "011") or (func = "100")) else O_vector ; 
	cout <= reg(n-1) ; 
end dataflowaddsub ;