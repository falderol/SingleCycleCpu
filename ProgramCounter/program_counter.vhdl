LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.word_type.all;

ENTITY ProgCount IS
    PORT(Input: IN word;
         Clock: IN STD_LOGIC;
         Output: OUT word);
END ProgCount;

ARCHITECTURE behavior OF ProgCount IS
BEGIN
    REG: ENTITY work.REG_x32(logic) PORT MAP(Input, '1', Clock, Output);
END behavior;
