library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
	port (inputA : in STD_LOGIC_VECTOR (3  downto 0);
	      inputB : in STD_LOGIC_VECTOR (3 downto 0);
         selectionVector : in STD_LOGIC_VECTOR (2 downto 0);
			output : out STD_LOGIC_VECTOR (3 downto 0);
			au_flags : out STD_LOGIC_VECTOR (1 downto 0)
 	);
end ALU;

architecture behavioral_ALU of ALU is
  component andOp
	port (vectorA : in STD_LOGIC_VECTOR (3 downto 0);
	      vectorB : in STD_LOGIC_VECTOR (3 downto 0);
	      vectorOut : out STD_LOGIC_VECTOR (3 downto 0)
 	);
  end component;

  component orOp
	port (	vectorA : in STD_LOGIC_VECTOR (3 downto 0);
			vectorB : in STD_LOGIC_VECTOR (3 downto 0);
			vectorOut : out STD_LOGIC_VECTOR (3 downto 0)
 	);
  end component;

  component xorOp
	port (	vectorA : in STD_LOGIC_VECTOR (3 downto 0);
			vectorB : in STD_LOGIC_VECTOR (3 downto 0);
			vectorOut : out STD_LOGIC_VECTOR (3 downto 0)
 	);
  end component;
  
  component AU
		port (	inputVectorA : in STD_LOGIC_VECTOR (3  downto 0);
				inputVectorB : in STD_LOGIC_VECTOR (3 downto 0);
				selectionVector : in STD_LOGIC_VECTOR (2 downto 0);
				output : out STD_LOGIC_VECTOR (3 downto 0);
				carryOut : out STD_LOGIC;
				overflow : out STD_LOGIC
		);
  end component;

  signal outputAND, outputOR, outputXOR, outputALU : STD_LOGIC_VECTOR (3 downto 0);
  signal carryOut, overflow : STD_LOGIC;

begin

and_operator : andOp port map (inputA, inputB, outputAND);
or_operator  : orOp port map (inputA, inputB, outputOR);
xor_operator : xorOp port map (inputA, inputB, outputXOR);
au_operator  : AU port map (inputA, inputB, selectionVector, outputALU, carryOut, overflow);

	menu:process(selectionVector, inputA, inputB, outputAND, outputOR, outputXOR, outputALU)
	begin
		case selectionVector is
			when	"000" =>
				--ADD
				output <= outputAND;
 			when	"001" =>
				--OR
				output <= outputOR;
 			when	"010" =>
				--XOR
				output <= outputXOR;
 			when	"011" =>
               			--INCREMENTO
				output <= outputALU;
			when	"100" =>
              			--SOMA
               			output <= outputALU;
			when	"101" =>
               			--SUBTRACAO
               			output <= outputALU;
			when	"110" =>
               			--SOMA COM CARRY
               			output <= outputALU;
			when	"111" =>
				--INVERTER
				output <= outputALU;
			when others =>
				--SOMA
				output <= outputALU;
		end case;		
	end process;
	
	--Empacotamento  dos flags de carry e overflow para um vector de saída
	au_flags(0) <= overflow;
	au_flags(1) <= carryOut;

end behavioral_ALU;


