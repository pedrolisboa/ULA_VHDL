----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:52:44 10/17/2016 
-- Design Name: 
-- Module Name:    ff_mod3_counter - Behavioral 
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

entity ff_mod3_counter is
    Port ( clk_50MHz : in  STD_LOGIC;
			  clock_enable   : in STD_LOGIC;
           output_vector : out  STD_LOGIC_VECTOR (1 downto 0));
end ff_mod3_counter;

architecture Behavioral of ff_mod3_counter is

component JK_Flipflop
	port (clk_50MHz, 
			J,
			K,
			clock_enable : in STD_LOGIC;
			reset : in STD_LOGIC;
			Q: out STD_LOGIC
		);
end component;

signal q1, q2, reset : STD_LOGIC := '0';

begin


ff1 : JK_Flipflop port map (clk_50MHz, '1', '1',clock_enable,reset, q1);
ff2 : JK_Flipflop port map (clk_50MHz, q1, q1,clock_enable,reset, q2);


reset <= q1 and q2;
	
output_vector(0) <= q1;
output_vector(1) <= q2;
end Behavioral;

