library IEEE;
use ieee.std_logic_1164.all;

package aux_package is
--------------------------------------------------------
	component top is
	GENERIC (n : INTEGER ;
		   k : integer ;   -- k=log2(n)
		   m : integer	); -- m=2^(k-1)
	PORT 
	(  
		Y_i,X_i: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		ALUFN_i : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		ALUout_o: OUT STD_LOGIC_VECTOR(n-1 downto 0);
		Nflag_o,Cflag_o,Zflag_o,Vflag_o: OUT STD_LOGIC 
	); -- Zflag,Cflag,Nflag,Vflag
	end component;
---------------------------------------------------------  
	component FA is
		PORT (xi, yi, cin: IN std_logic;
			      s, cout: OUT std_logic);
	end component;
---------------------------------------------------------	
	component logic is 
		generic (n : integer);
		port (x,y : in std_logic_vector (n-1 downto 0); 
		  func : in std_logic_vector (2 downto 0);
		  res : out std_logic_vector (n-1 downto 0));
	end component;
	---------------------------------------------------------------
	component addsub is
		generic (n : integer ) ;
		port (x,y : in std_logic_vector (n-1 downto 0); 
			  func : in std_logic_vector (2 downto 0);
			  res : out std_logic_vector (n-1 downto 0);
			  cout : out std_logic) ;
	end component ;
	-----------------------------------------------------------------
	component shifter is 
		generic ( n :  integer ; k : integer );
		port (x,y : in std_logic_vector (n-1 downto 0); 
			  func : in std_logic_vector (2 downto 0);
			  res : out std_logic_vector (n-1 downto 0);
			  cout : out std_logic );
	end component;
	
	
	
end aux_package;

