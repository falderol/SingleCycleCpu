LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.word_type.all;

ENTITY left_two IS
    PORT(Input: IN word;
         Output: OUT word);
END left_two;

ARCHITECTURE behavior of left_two IS

BEGIN
    shifter: FOR i in 0 TO 29 generate
        Output(i+2) <= Input(i);
    END generate;
    Output(0) <= '0';
    Output(1) <= '0';
END behavior;
