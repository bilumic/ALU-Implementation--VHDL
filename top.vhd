LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
-------------------------------------
ENTITY top IS
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
END top;
------------- complete the top Architecture code --------------
ARCHITECTURE struct OF top IS 
signal addsub_XVector,addsub_YVector,addsub_OVector,shifter_XVector,shifter_YVector,shifter_OVector,logic_XVector,logic_YVector,logic_OVector : STD_LOGIC_VECTOR (n-1 DOWNTO 0);
signal Z_vector : STD_LOGIC_VECTOR(n-1 DOWNTO 0) := (others => 'Z');
signal O_vector : STD_LOGIC_VECTOR(n-1 DOWNTO 0) := (others => '0');      
signal addsub_Cout,shifter_Cout: STD_LOGIC ;
signal ALU_Out : STD_LOGIC_VECTOR (n-1 DOWNTO 0) ;
signal Func_i : STD_LOGIC_VECTOR (2 DOWNTO 0);

BEGIN
	addsub_XVector <= X_i when ALUFN_i(4 DOWNTO 3) = "01" else Z_vector ;
	addsub_YVector <= Y_i when ALUFN_i(4 DOWNTO 3) = "01" else Z_vector ;
	shifter_XVector <= X_i when ALUFN_i(4 DOWNTO 3) = "10" else Z_vector ;
	shifter_YVector <= Y_i when ALUFN_i(4 DOWNTO 3) = "10" else Z_vector ;
	logic_XVector <= X_i when ALUFN_i(4 DOWNTO 3) = "11" else Z_vector ;
	logic_YVector <= Y_i when ALUFN_i(4 DOWNTO 3) = "11" else Z_vector ;
	Func_i <= ALUFN_i(2 DOWNTO 0) when (ALUFN_i (4 DOWNTO 3) = "01" ) or (ALUFN_i (4 DOWNTO 3) = "01") or (ALUFN_i (4 DOWNTO 3) = "01") else "ZZZ" ;


	
	addsub_Func : addsub generic map (n) port map (x => addsub_XVector,y => addsub_YVector,func => ALUFN_i(2 downto 0), res => addsub_OVector , cout => addsub_Cout);
	logic_Func : logic  generic map (n) port map (x => logic_XVector,y => logic_YVector,func => ALUFN_i(2 downto 0), res => logic_OVector);
	shifter_Func : shifter generic map (n,k) port map (x => shifter_XVector,y => shifter_YVector,func => ALUFN_i(2 downto 0), res => shifter_OVector , cout => shifter_Cout);
	
	with ALUFN_i(4 DOWNTO 3) select 
	ALU_Out <= addsub_OVector when "01",
				logic_OVector  when "11",
				shifter_OVector when "10",
				O_vector when others;
	
	with ALUFN_i(4 DOWNTO 3) select 
	Cflag_o <= addsub_Cout when "01",
				'0'  when "11",
			shifter_Cout when "10",
				'0' when others ;		
	Zflag_o <= '1' when (ALU_Out = O_vector) else '0'; 
	Nflag_o <= ALU_Out(n-1) ;
	
	Vflag_o <= '1' when( (ALUFN_i = "01000")   and 
				(((addsub_XVector(n-1) = '0') and (addsub_YVector(n-1) = '0') and (ALU_Out(n-1) = '1')) or 
				((addsub_XVector(n-1) = '1' ) and (addsub_YVector(n-1) = '1') and (ALU_Out(n-1) = '0'))) ) or (
				(ALUFN_i = "01001") and 
              (((addsub_XVector(n-1) = '1') and (addsub_YVector(n-1) = '0') and (ALU_Out(n-1) = '1')) or
               ((addsub_XVector(n-1) = '0') and (addsub_YVector(n-1) = '1') and (ALU_Out(n-1) = '0'))) )
			else '0'; 

	ALUout_o <= ALU_Out ;	
			 
END struct;

