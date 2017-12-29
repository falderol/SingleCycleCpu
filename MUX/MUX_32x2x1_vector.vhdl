LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.word_type.all;

ENTITY MUX_32x2x1_vector IS
    PORT (I: IN word_array_2;
          S: IN STD_LOGIC_VECTOR(0 DOWNTO 0);
          output: OUT word
         );

END MUX_32x2x1_vector;

ARCHITECTURE logic OF MUX_32x2x1_vector IS

BEGIN

ENCASE:
FOR Inc in 0 to 31 generate
-- 2x MUX
    MUX00: ENTITY work.MUX_2x1_vector(logic) PORT MAP (                   
                                                       Inp(0) => I(0)(Inc),
                                                       Inp(1) => I(1)(Inc),
                                                       Sig(0) => S(0),
                                                       output(0) => output(Inc)
                                                      );
END generate ENCASE;
END logic;

