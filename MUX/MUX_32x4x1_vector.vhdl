LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.word_type.all;

ENTITY MUX_32x4x1_vector IS
    PORT (I: IN word_array_4;
          S: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
          output: OUT word
         );

END MUX_32x4x1_vector;

ARCHITECTURE logic OF MUX_32x4x1_vector IS

BEGIN

ENCASE:
FOR Inc in 0 to 31 generate
-- 4x MUX
    MUX00: ENTITY work.MUX_4x1_vector(logic) PORT MAP (                   
                                                       I(0) => I(0)(Inc),
                                                       I(1) => I(1)(Inc),
                                                       I(2) => I(2)(Inc),
                                                       I(3) => I(3)(Inc),
                                                       S(0) => S(0),
                                                       S(1) => S(1),
                                                       output(0) => output(Inc)
                                                      );
END generate ENCASE;
END logic;

