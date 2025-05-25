LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE work.aux_package.ALL;
--------------------------------------------------------

ENTITY Shifter IS
    GENERIC (n : INTEGER ; -- vector length
             k : INTEGER ); -- k=log2(n)
    -- create port map - set type and size of each input port
    PORT ( func: IN std_logic_vector (2 downto 0); -- shift left (0) or right (1)
        x: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
        y: IN std_logic_vector (n-1 DOWNTO 0);
        res: OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0);
        cout: OUT STD_LOGIC);
END entity Shifter;

------------------------------------

ARCHITECTURE dataflow OF Shifter IS
	signal zeros : std_logic_vector (n-1 downto 0) := (others => '0');
	signal carry_indicator : integer range 0 to n;
    type data_array is array (0 to k) of std_logic_vector (n-1 downto 0);
    signal res_left : data_array;
	signal res_right : data_array;
	signal coutfuncone : std_logic;
	signal coutfunctwo : std_logic;
    

begin
	carry_indicator <= to_integer(unsigned(x(k-1 downto 0)));
	res_left(0) <= y;
	res_right(0) <= y;
	
	shifting: for i in 0 to k-1 generate
	begin
		with x(i) select res_left(i+1) <= res_left(i)(n-1-2**i downto 0) & zeros(2**i-1 downto 0) when '1', res_left(i) when others;
		with x(i) select res_right(i+1) <= zeros(2**i-1 downto 0) & res_right(i)(n-1 downto 2**i) when '1', res_right(i) when others;
	end generate;
	
	coutfuncone <= y(n-carry_indicator) when carry_indicator > 0 else '0';
	coutfunctwo <= y(carry_indicator-1) when carry_indicator > 0 else '0';
	
	with func select
	cout <= coutfuncone when "000", coutfunctwo when "001", '0' when others;
	
	with func select 
	res <= res_left(k) when "000", res_right(k) when "001", zeros when others;
	
end dataflow;




    