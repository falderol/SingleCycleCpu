LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.word_type.all;

ENTITY zero_flag_32x1 IS
    PORT (INPUT: IN word;
          SIG: OUT STD_LOGIC
         );
END zero_flag_32x1;

ARCHITECTURE logic of zero_flag_32x1 IS
    SIGNAL T00: STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL T01: STD_LOGIC_VECTOR(1 DOWNTO 0);
BEGIN

    row0: FOR i IN 0 TO 7 generate
        T00(i) <= INPUT(i*4) OR INPUT((i*4)+1) OR INPUT((i*4)+3) OR INPUT((i*4)+3) after 5 ps;
    end generate;

    row1: FOR i in 0 TO 1 generate
        T01(i) <= T00(i*4) OR T00((i*4)+1) OR T00((i*4)+2) OR T00((i*4)+3) after 5 ps;
    end generate;

    SIG <= T01(0) NOR T01(1) after 5 ps;


END logic;
