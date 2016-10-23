----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:37:33 10/17/2016 
-- Design Name: 
-- Module Name:    jk_ff - Behavioral 
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

entity JK_Flipflop is
port ( clk_50MHz:     in std_logic;
       J, K:    in std_logic;
		 clock_enable : in STD_LOGIC;	--Enable para alteraçao de estado do flip_flop
       reset: 	 in std_logic;
		 Q : out std_logic
);
end JK_Flipflop;


architecture Behavioral of JK_Flipflop is
	
	signal Q_signal : std_logic :='0';
	
	begin
	Q <= Q_signal;


	process(clk_50MHz,reset,clock_enable)
	begin
		if(reset = '1') then           --'Reset' assíncrono.
				Q_signal <= '0';

		elsif( falling_edge(clk_50MHz)) then
			if (clock_enable = '1') then
				if(J='0' and K='0') then       --Sem mudanças na saida
					NULL;
				elsif(J='0' and K='1') then    
					Q_signal <= '0';

				elsif(J='1' and K='0') then   
					Q_signal <= '1';

				else                           --'Toggle' output.
					Q_signal <= not Q_signal;
				end if;
			end if;
		end if;
	end process;
end Behavioral;
