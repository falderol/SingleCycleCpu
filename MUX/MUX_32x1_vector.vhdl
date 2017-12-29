LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY MUX_32x1_vector IS
    PORT (I: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
          S:   IN STD_LOGIC_VECTOR(4 DOWNTO 0);
          output: OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
         );
END MUX_32x1_vector;

--Maximum of 4 terms and one type per statement.
ARCHITECTURE logic OF MUX_32x1_vector IS
    SIGNAL O: STD_LOGIC_VECTOR(9 DOWNTO 0);
BEGIN

-- First Layer of 4x MUX's
    LAYER1:
    FOR Ind in 0 to 7 generate
    MUX00: ENTITY work.MUX_4x1_vector(logic) PORT MAP (
                                                       I(0) => I(4*Ind), 
                                                       I(1) => I(4*Ind+1),
                                                       I(2) => I(4*Ind+2), 
                                                       I(3) => I(4*Ind+3),
                                                       S(0) => S(0),
                                                       S(1) => S(1),
                                                       output(0) => O(Ind)

                                                      );
   END generate LAYER1;
-- Second Layer of 4x MUX's
    LAYER2:
    FOR Index in 0 to 1 generate
    MUX01: ENTITY work.MUX_4x1_vector(logic) PORT MAP (
                                                       I(0) => O(Index*4), 
                                                       I(1) => O(Index*4+1),
                                                       I(2) => O(Index*4+2), 
                                                       I(3) => O(Index*4+3),
                                                       S(0) => S(2), 
                                                       S(1) => S(3),
                                                       output(0) => O(8+Index)
                                                      );
    END generate LAYER2;
-- Third Layer of 2x MUX
    MUX10: ENTITY work.MUX_2x1_vector(logic) PORT MAP (
                                                       Inp(0) => O(8), 
                                                       Inp(1) => O(9), 
                                                       Sig(0) => S(4),
                                                       output(0) => output(0)
                                                      );
END logic;
