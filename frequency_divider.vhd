----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:32:30 10/17/2016 
-- Design Name: 
-- Module Name:    frequency_divider - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity frequency_divider is
    Port ( clk_50MHz : in  STD_LOGIC;
           clock_enable : out  STD_LOGIC); --Enable à ser passado para os flip-flops do contador
end frequency_divider;


architecture Behavioral of frequency_divider is

constant TWOSECTIMER : natural := ((100000000-1));	--Constante para definição do período de ativaçao do enable

signal counter : natural range 0 to TWOSECTIMER := 0;		--Declaraçao do sinal de contagem
signal enable_signal : STD_LOGIC := '0';						

begin
	process (clk_50MHz)
	begin
		if (falling_edge(clk_50MHz)) then
			if (counter = TWOSECTIMER) then	--Ativaçao do enable
				enable_signal <= '1';			--Enable ativo por um tempo de duraçao igual ao período do clock de entrada
				counter <= 0;						
			elsif (counter /= TWOSECTIMER)then	--Contador diferente do limite de ativaçao
				enable_signal <= '0';				--Enable desativado
				counter <= counter + 1;				--Contagem de pulsos do clock de entrada
			end if;
		end if;	
	end process;
	
	clock_enable <= enable_signal;
end Behavioral;

