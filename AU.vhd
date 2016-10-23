----------------------------------------------------------------------------------
-- Instituiao: Universidade Federal do Rio de Janeiro
-- Aluno: Pedro Henrique Braga Lisboa
-- Aluno: Daniel Haddad 
-- 
-- Create Date:    11:24:27 10/17/2016 
-- Module Name:    AU - Behavioral 
-- Project Name: 	 Unidade Lgica Aritmtica
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


entity AU is
	port (inputVectorA 	 : in STD_LOGIC_VECTOR (3  downto 0);		-- Numero A recebido do menu
	      inputVectorB 	 : in STD_LOGIC_VECTOR (3 downto 0); 		-- Nmero B recebido do menu
         selectionVector : in STD_LOGIC_VECTOR (2 downto 0); 		-- Posiao do selecionador, recebido do menu
			output 			 : out STD_LOGIC_VECTOR (3 downto 0);		-- Saida correspondente ao resultado da operaao da AU
			carryOut 	 	 : out STD_LOGIC;									--Carry do bit  mais significativo 
			overflow 	 	 : out STD_LOGIC									--Overflow em caso da operaao de subtraao
			);
end AU;

architecture behavorial_AU of AU is

	component full_adder			--Somador de 4-bits com carry lookahead
		port(carryIn 	 : in  STD_LOGIC;
			  A		 	 :	in  STD_LOGIC_VECTOR (3 downto 0);
			  B		 	 : in  STD_LOGIC_VECTOR (3 downto 0);
			  S		 	 : out STD_LOGIC_VECTOR (3 downto 0);
			  carryOut	 : out STD_LOGIC;			--Carry do bit mais significativo
			  carryOut_1 : out STD_LOGIC);		--Carry do n-1 bit, sendo n o mais significativo
	end component;

	signal entryA, entryB : STD_LOGIC_VECTOR (3 downto 0); --Sinais de transiao, 
																			 --recebem os valores a serem passados para o full adder
	signal carryIn, signal_carryOut, signal_carryOut_1 : STD_LOGIC;
begin

	process(selectionVector,inputVectorA,inputVectorB, signal_carryOut, signal_carryOut_1)
	begin

		case selectionVector is
			when	"011" =>
				--Incremento
				
				overflow <= signal_carryOut xor signal_carryOut_1;
				carryOut <= signal_carryOut;
				carryIn <= '1';
				entryB <= "0000";
				entryA <= inputVectorA;
			when	"100" =>
				--Adio
				carryIn <= '0';
				
				overflow <= signal_carryOut xor signal_carryOut_1;
				carryOut <= signal_carryOut;
				entryB <= inputVectorB;
				entryA <= inputVectorA;
			when	"101" =>
				--Subtrao
				carryIn <= '1';	

				overflow <= signal_carryOut xor signal_carryOut_1;
				carryOut <= not signal_carryOut;				--complemento de 2 INSERI O NOT
				entryB <= not inputVectorB;		--complemento de 2
				entryA <= inputVectorA;
			when	"110" =>
				--Add carry
				carryIn <= '1';
				
				overflow <= signal_carryOut xor signal_carryOut_1;
				carryOut <= signal_carryOut;
				entryB <= inputVectorB;
				entryA <= inputVectorA;
			when	"111" =>
				--Inverter
				carryIn <= '0';
				entryB <= "0000";
				
				overflow <= signal_carryOut xor signal_carryOut_1;
				carryOut <= signal_carryOut;
				entryA <= not inputVectorA;
			when others =>
				--Defult: soma sem carry.
				carryIn <= '0';
				
				overflow <= '0';
				carryOut <= '0';
				entryB <= inputVectorB;
				entryA <= inputVectorA;
		end case;
	end process;

	au_interface : full_adder port map(carryIn, entryA, entryB, output, signal_carryOut, signal_carryOut_1);
end behavorial_AU;


