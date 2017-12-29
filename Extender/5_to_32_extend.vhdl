LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.word_type.all;

ENTITY Extend_5x32 IS
    PORT(Input: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
         Sign: IN STD_LOGIC;
         Output: OUT word);
END Extend_5x32;

ARCHITECTURE behavior of Extend_5x32 IS
    SIGNAL filler: STD_LOGIC;
    SIGNAL Out1: STD_LOGIC_VECTOR(31 DOWNTO 5);
BEGIN
    filler <= Input(4) AND Sign after 5 ps;
    extend: FOR i in 5 to 31 generate
        Out1(i) <= filler;
    END generate;
    output <= Out1 & Input;
END behavior;

