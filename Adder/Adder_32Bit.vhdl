LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.word_type.all;

ENTITY Add_32 IS
    PORT(IN0, IN1: IN word;
         CIN: IN STD_LOGIC;
         OUTPUT: OUT word;
         OVER, NEGATIVE, ZERO, COUT: OUT STD_LOGIC
        );
END Add_32;

ARCHITECTURE logic of Add_32 IS
    SIGNAL carryBit: word := x"00000000";
    SIGNAL IN1XOR: word;
    SIGNAL tempOut: word;
BEGIN

    OUTPUT <= tempOut;

    zero_flag: ENTITY work.zero_flag_32x1 PORT MAP (tempOut, ZERO);

    inputB: FOR i In 0 TO 31 generate
        IN1XOR(i) <= IN1(i) XOR CIN after 5 ps;
    END generate;

    LSB: ENTITY work.Add_1(logic) PORT MAP (IN0(0), IN1XOR(0), CIN, tempOut(0),carryBit(0));
    inputRow: FOR i in 1 TO 31 generate
        bits : ENTITY work.Add_1(logic) PORT MAP (IN0(i), IN1XOR(i), carryBit(i-1), tempOut(i), carryBit(i));
    end generate;

    COUT <= carryBit(31);

    OVER <= carryBit(30) XOR carryBit(31);

    NEGATIVE <= tempOut(31); --ignore if unsigned

END logic;
