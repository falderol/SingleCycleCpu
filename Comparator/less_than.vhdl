--return 1 if less than, 0 else
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.word_type.all;

ENTITY less_than_32 IS
    PORT(IN0, IN1: IN word;
         Output: OUT word;
         ZERO: OUT STD_LOGIC
        );
END less_than_32;

ARCHITECTURE logic of less_than_32 IS
    SIGNAL addOut, tempOut: word := x"00000000";
    SIGNAL addOver, addNegative, addCout: STD_LOGIC;
BEGIN
    subtract: ENTITY work.Add_32(logic) PORT MAP (IN0, IN1, '1', addOut, addOver, addNegative, ZERO, addCout);
    tempOut(0) <= addNegative;
    Output <= tempOut;
END logic;
