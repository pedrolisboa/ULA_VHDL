----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:00:32 10/18/2016 
-- Design Name: 
-- Module Name:    input_generator - Behavioral 
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

entity input_generator is
    Port ( clk_50MHz : in  STD_LOGIC; --System clock
			  clock_enable : in  STD_LOGIC;
           switch : in  STD_LOGIC;
			  input : in  STD_LOGIC_VECTOR (3 downto 0);  --Pushbuttons
           dataA : out  STD_LOGIC_VECTOR (3 downto 0); --Número gerado
           dataB : out  STD_LOGIC_VECTOR (3 downto 0)); --Número gerado
end input_generator;

architecture Behavioral of input_generator is

component JK_flipflop
	port(clk_50MHz:     in std_logic;
		  J, K:    in std_logic;
		  clock_enable : in STD_LOGIC;
		  reset: 	 in std_logic;
		  Q: out std_logic
);
end component;

signal clock_enableA,clock_enableB: STD_LOGIC := '0';

begin

clock_enableA <= switch and clock_enable;
clock_enableB <= (not switch) and clock_enable;

a0 : JK_flipflop port map(clk_50MHz,input(0), input(0), clock_enableA, '0', dataA(0) );
a1 : JK_flipflop port map(clk_50MHz,input(1), input(1), clock_enableA, '0', dataA(1) );
a2 : JK_flipflop port map(clk_50MHz,input(2), input(2), clock_enableA, '0', dataA(2) );
a3 : JK_flipflop port map(clk_50MHz,input(3), input(3), clock_enableA, '0', dataA(3) );

b0 : JK_flipflop port map(clk_50MHz,input(0), input(0), clock_enableB, '0', dataB(0) );
b1 : JK_flipflop port map(clk_50MHz,input(1), input(1), clock_enableB, '0', dataB(1) );
b2 : JK_flipflop port map(clk_50MHz,input(2), input(2), clock_enableB, '0', dataB(2) );
b3 : JK_flipflop port map(clk_50MHz,input(3), input(3), clock_enableB, '0', dataB(3));

end Behavioral;

