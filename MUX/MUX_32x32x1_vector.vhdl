LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.word_type.all;
--END OF FIRST


ENTITY MUX_32x32x1_vector IS
    PORT (I: IN word_array;
          S: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
          output: OUT word
         );

END MUX_32x32x1_vector;
--Maximum of 4 terms and one type per statement.
ARCHITECTURE logic OF MUX_32x32x1_vector IS

    SIGNAL O: word_output(9 DOWNTO 0);
BEGIN

ENCASE:
FOR Inc in 0 to 31 generate
-- First Layer of 4x MUX's
    LAYER1:
    FOR Ind in 0 to 7 generate
    MUX00: ENTITY work.MUX_4x1_vector(logic) PORT MAP (                   
                                                       I(0) => I(Ind*4)(Inc),
                                                       I(1) => I(Ind*4+1)(Inc),
                                                       I(2) => I(Ind*4+2)(Inc),
                                                       I(3) => I(Ind*4+3)(Inc),
                                                       S(0) => S(0),
                                                       S(1) =>  S(1),
                                                       output(0) => O(Ind)(Inc)
                                                      );
   END generate LAYER1;
-- Second Layer of 4x MUX's
    LAYER2:
    FOR Index in 0 to 1 generate
    MUX01: ENTITY work.MUX_4x1_vector(logic) PORT MAP (
                                                       I(0) => O(Index*4)(Inc),
                                                       I(1) => O(Index*4+1)(Inc),
                                                       I(2) => O(Index*4+2)(Inc),
                                                       I(3) => O(Index*4+3)(Inc),
                                                       S(0) => S(2),
                                                       S(1) => S(3),
                                                       output(0) => O(8+Index)(Inc)
                                                      );
    END generate LAYER2;
-- Third Layer of 2x MUX
    MUX10: ENTITY work.MUX_2x1_vector(logic) PORT MAP (
                                                       Inp(0) => O(8)(Inc),
                                                       Inp(1) => O(9)(Inc),
                                                       Sig(0) => S(4),
                                                       output(0) => output(Inc)
                                                      );
END generate ENCASE;
END logic;
