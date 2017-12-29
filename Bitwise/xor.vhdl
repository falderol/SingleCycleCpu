LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.word_type.all;

ENTITY XOR_32 IS
    PORT(IN0, IN1: IN word;
         Output: OUT word;
         NEGATIVE, ZERO: OUT STD_LOGIC
        );
END XOR_32;

ARCHITECTURE logic of XOR_32 IS
    SIGNAL tempOutput: word;
BEGIN
    xor32: FOR i in 0 to 31 generate
        tempOutput(i) <= IN0(i) XOR IN1(i) after 5 ps;
    END generate;
    Output <= tempOutput;
    NEGATIVE <= tempOutput(31);
    zero_flag: ENTITY work.zero_flag_32x1 PORT MAP (tempOutput, ZERO);
END logic;
