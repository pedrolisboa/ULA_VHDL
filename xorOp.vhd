----------------------------------------------------------------------------------
-- Instituiçao: Universidade Federal do Rio de Janeiro
-- Aluno: Pedro Henrique Braga Lisboa
-- Aluno: Daniel Haddad 
-- 
-- Create Date:    11:24:27 10/17/2016 
-- Module Name:    xorOp - Behavioral 
-- Project Name: 	 Unidade Lógica Aritmética
-- Target Devices: Xilinx Spartan 3AN
-- Description: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xorOp is
	port (vectorA : in STD_LOGIC_VECTOR (3 downto 0);
			vectorB : in STD_LOGIC_VECTOR (3 downto 0);
			vectorOut : out STD_LOGIC_VECTOR (3 downto 0)
 	);
end xorOp;

architecture behavioral_xorOp of xorOp is
begin
	vectorOut <= vectorA xor vectorB;
end behavioral_xorOp;
