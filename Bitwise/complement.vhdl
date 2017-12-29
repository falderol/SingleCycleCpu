LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.word_type.all;

ENTITY COMP_32 IS
    PORT(IN0, IN1: IN word;
         Output: OUT word;
         NEGATIVE, ZERO: OUT STD_LOGIC
        );
END COMP_32;

ARCHITECTURE logic of COMP_32 IS
    SIGNAL tempOutput: word;
BEGIN
    comp32: ENTITY work.XOR_32 PORT MAP (IN0, x"FFFFFFFF", Output, NEGATIVE, ZERO);
END logic;

