----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:28:53 10/16/2016 
-- Design Name: 
-- Module Name:    menu - Behavioral 
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

entity menu is
	port (clk_50MHz : STD_LOGIC;
			input : in STD_LOGIC_VECTOR (3 downto 0);						--Input dos pushbuttons
			switch : in  STD_LOGIC; --HIGH => inputA  LOW => inputB	--Input dos switch mais  direita
			selectionVector : in STD_LOGIC_VECTOR (2 downto 0); 		--Input dos 3 switchs mais  esquerda
			p_flag : out STD_LOGIC_VECTOR (1 downto 0);					--Indica o que est sendo apresentado nos LEDs de resultado
			au_flags : out STD_LOGIC_VECTOR (1 downto 0);				--Carry/Borrow e Overflow
			menuOutput : out STD_LOGIC_VECTOR (3 downto 0)				--LEDs de resultado
 	);
end menu;

architecture behavorial_menu of menu is

component ALU
	port (inputA : in STD_LOGIC_VECTOR (3  downto 0);
			inputB : in STD_LOGIC_VECTOR (3 downto 0);
			selectionVector : in STD_LOGIC_VECTOR (2 downto 0);
			output : out STD_LOGIC_VECTOR (3 downto 0);
			au_flags : out STD_LOGIC_VECTOR(1 downto 0) --Apenas para operaoes da AU
	);
end component;

component input_generator					--Gerador de numeros a partir dos inputs dos pushbuttons
	Port ( clk_50MHz : in  STD_LOGIC;
			 clock_enable : in  STD_LOGIC;
		 	 switch : in  STD_LOGIC;
			 input : in  STD_LOGIC_VECTOR (3 downto 0);
			 dataA : out  STD_LOGIC_VECTOR (3 downto 0);
			 dataB : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

component frequency_divider	--Divisor de frequncias
	port ( clk_50MHz : in  STD_LOGIC;
          clock_enable : out  STD_LOGIC);
end component;

component ff_mod3_counter		--Contador mdulo 3
  port ( clk_50MHz : in  STD_LOGIC;
			clock_enable : in STD_LOGIC;
         output_vector : out  STD_LOGIC_VECTOR (1 downto 0));
end component;


signal enable : std_logic := '0';
signal counter : std_logic_vector (1 downto 0) := "00";
signal signal_menuOutput, numeroA, numeroB : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal alu_output : std_logic_vector(3 downto 0) := "0000";
signal presentation_flag : std_logic_vector (1 downto 0) := "10";
signal signal_au_flags	: std_logic_vector   (1 downto 0) := "00";

begin
	input_data : input_generator
		port map(clk_50MHz, enable, switch, input, numeroA, numeroB);

	alu_instance : ALU
		port map(numeroA, numeroB, selectionVector, alu_output, signal_au_flags);

	time_generator : frequency_divider
 		port map(clk_50MHz, enable);

	show_counter: ff_mod3_counter
		port map(clk_50MHz,enable, counter);

		process (enable,counter, numeroA, numeroB, alu_output, signal_au_flags) 
		begin
			case counter is
				when "00" =>		--Primeiro nmero apresentado	(numeroA)
					au_flags <= "00";
					presentation_flag <= "10";		
					signal_menuOutput <= numeroA;
 				when "01" =>
					au_flags <= "00";
					presentation_flag <= "01"; --Segundo nmero apresentado (numeroB)
					signal_menuOutput <= numeroB;
				when "10" =>
					au_flags <= signal_au_flags;
					presentation_flag <= "11"; --Resultado
					signal_menuOutput <= alu_output;
				when others =>
					au_flags <= "00";
					presentation_flag <= "00"; --LEDS de indicaao apagados: contagem fora do loop normal
					signal_menuOutput <= alu_output;
			end case;
		end process;
		
		--Atribuiao das sadas
		p_flag <= presentation_flag;
		menuOutput <= signal_menuOutput;
end behavorial_menu;

