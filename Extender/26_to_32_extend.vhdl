LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.word_type.all;

ENTITY Extend_26x32 IS
    PORT(Input: IN STD_LOGIC_VECTOR (25 DOWNTO 0);
         Output: OUT word);
END Extend_26x32;

ARCHITECTURE behavior of Extend_26x32 IS
    SIGNAL Out1: STD_LOGIC_VECTOR(31 DOWNTO 26) := "111111";
BEGIN
    output <= Out1 & Input;
END behavior;

