----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:17:40 10/17/2016 
-- Design Name: 
-- Module Name:    full_adder - Behavioral 
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

entity full_adder is							--4-bit full adder com carry lookahead
	port(carryIn 	 : in  STD_LOGIC;
		  A		 	 :	in  STD_LOGIC_VECTOR (3 downto 0);
		  B		 	 : in  STD_LOGIC_VECTOR (3 downto 0);
		  S		 	 : out STD_LOGIC_VECTOR (3 downto 0);
		  carryOut	 : out STD_LOGIC;
		  carryOut_1 : out STD_LOGIC
		  );
end full_adder;

architecture behavioral_4bitadder of full_adder is
	signal P,G : STD_LOGIC_VECTOR (3 downto 0); --Carry Propagate e Carry Generate. O elemento do vetor com
															  --com maior indice corresponde à operaçao de soma do bit mais significativo
	signal C : STD_LOGIC_VECTOR (4 downto 1);	  --Sinal para receber o calculo do carry lookahead. O elemento do vetor com
															  --com maior indice corresponde ao carry do bit mais significativo

begin
		G <= A and B;
		P <= A xor B;
		
		--Bloco do carry lookahead
		C(1) <= G(0) or (P(0) and carryIn);
		C(2) <= G(1) or (G(0) and P(1)) or ((carryIn and P(0)) and P(1));
		C(3) <= G(2) or (G(1) and P(2)) or	((G(0) and P(1)) and P(2)) or (((carryIn and P(0)) and P(1)) and P(2));
		C(4) <= G(3) or (G(2) and P(3)) or	((G(1) and P(2)) and P(3)) or (((G(0) and P(1)) and P(2)) and P(3)) or ((((carryIn and P(0)) and P(1)) and P(2)) and P(3));

		--Bloco de soma
		S(0) <= (A(0) xor B(0)) xor carryIn;
		S(1) <= (A(1) xor B(1)) xor C(1);
	   S(2) <= (A(2) xor B(2)) xor C(2);	 
		S(3) <= (A(3) xor B(3)) xor C(3);

		carryOut 	<= C(4);
		carryOut_1  <= C(3);
		
end behavioral_4bitadder;