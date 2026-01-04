----------------------------------------------------------------------------------
--
-- Description:   Contador de 4 bits, baseado no circuito sequencial b�sico 
--                           que deve contar  0, 1, 6, 5, A, 6, E, F
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity sequencial2 is
	Port (ini : in STD_LOGIC;
		  clk : in STD_LOGIC;
		  S : out STD_LOGIC_VECTOR (3 downto 0);
		  Q : out STD_LOGIC_VECTOR (2 downto 0));
end sequencial2;

architecture Behavioral of sequencial2 is

signal seq_Q: STD_LOGIC_VECTOR (2 downto 0);

component sequencial is
   Port (	ini : in STD_LOGIC;
		clk : in STD_LOGIC;
		m : in STD_LOGIC;
		B : in STD_LOGIC_VECTOR (2 downto 0);
		Q : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component decoder is
    Port ( 
	I 	: in STD_LOGIC_VECTOR (2 downto 0);
	en  : in STD_LOGIC;
	O   : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component decoder_neg is
    Port ( 
	I 	: in STD_LOGIC_VECTOR (2 downto 0);
    en  : in STD_LOGIC;
    O   : out STD_LOGIC_VECTOR (7 downto 0));
end component;


signal  dec_O : std_logic_vector (7 downto 0);
signal  dec_neg_O : std_logic_vector (7 downto 0);

begin

-- inst�ncia do circuito sequencial b�sico
-- DEVE MODIFICAR O VALOR DE B
SEQ : sequencial port map (
    ini => ini,
    clk => clk,
    m => '0',
    b => "101",
    Q => seq_Q  
); 
Q <= seq_Q;

-- instancia do DECODER (port map)
-- n�o modificar
DEC : decoder port map (
    en => '1',
    I => seq_Q,
    O   => dec_O
); 
-- instancia do DECODER_NEG (port map)
-- n�o modificar
DEC_NEG : decoder_neg port map (
    en => '1',
    I => seq_Q,
    O   => dec_neg_O
); 


-- Sa�das do circuito sequancial2
-- DEVE MODIFICAR 
S(0) <= dec_O(3) or dec_O(4) or dec_O(5) or dec_O(6);

S(1) <= dec_O(1) or dec_O(5) or dec_O(7);
         
S(2) <= not(dec_neg_O(1) and dec_neg_O(2) and dec_neg_O(4));

S(3) <= not(dec_neg_O(1) and dec_neg_O(2) and dec_neg_O(6) and dec_neg_O(7));

end Behavioral;
