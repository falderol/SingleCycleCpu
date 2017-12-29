LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.word_type.all;

ENTITY barrel_shifter IS
    PORT(Input, shiftAmount: IN word;
         D: IN STD_LOGIC;
         Output: OUT word;
         OVER, NEGATIVE, ZERO, COUT: OUT STD_LOGIC
        );
END barrel_shifter;

ARCHITECTURE logic of barrel_shifter IS
    SIGNAL layer0, layer1, layer2, layer3, layer4, layer5: STD_LOGIC_VECTOR (95 DOWNTO 0) := x"000000000000000000000000";
    SIGNAL leftOver, rightOver: STD_LOGIC;
BEGIN
    layer0(63 DOWNTO 32) <= Input(31 DOWNTO 0); --this appears to work and buts are input where we want it\

    layerZero: FOR i IN 1 TO 94 generate -- 1 bit shift
        MUXL0: ENTITY work.MUX_4x1_vector(logic) PORT MAP(
                                                          I(0) => layer0(i),
                                                          I(1) => layer0(i-1),
                                                          I(2) => layer0(i),
                                                          I(3) => layer0(i+1),
                                                          S(0) => shiftAmount(0),
                                                          S(1) => D,
                                                          output(0) => layer1(i)
                                                         );
    END generate;
 
    layerOne: FOR i IN 2 TO 93 generate -- 1 bit shift
        MUXL1: ENTITY work.MUX_4x1_vector(logic) PORT MAP(
                                                          I(0) => layer1(i),
                                                          I(1) => layer1(i-2),
                                                          I(2) => layer1(i),
                                                          I(3) => layer1(i+2),
                                                          S(0) => shiftAmount(1),
                                                          S(1) => D,
                                                          output(0) => layer2(i)
                                                         );
    END generate;
 
    layerTwo: FOR i IN 4 TO 91 generate -- 1 bit shift
        MUXL2: ENTITY work.MUX_4x1_vector(logic) PORT MAP(
                                                          I(0) => layer2(i),
                                                          I(1) => layer2(i-4),
                                                          I(2) => layer2(i),
                                                          I(3) => layer2(i+4),
                                                          S(0) => shiftAmount(2),
                                                          S(1) => D,
                                                          output(0) => layer3(i)
                                                         );
    END generate;
    
    layerThree: FOR i IN 8 TO 87 generate -- 1 bit shift
        MUXL3: ENTITY work.MUX_4x1_vector(logic) PORT MAP(
                                                          I(0) => layer3(i),
                                                          I(1) => layer3(i-8),
                                                          I(2) => layer3(i),
                                                          I(3) => layer3(i+8),
                                                          S(0) => shiftAmount(3),
                                                          S(1) => D,
                                                          output(0) => layer4(i)
                                                         );
    END generate;
    layerFour: FOR i IN 16 TO 79 generate -- 1 bit shift
        MUXL4: ENTITY work.MUX_4x1_vector(logic) PORT MAP(
                                                          I(0) => layer4(i),
                                                          I(1) => layer4(i-16),
                                                          I(2) => layer4(i),
                                                          I(3) => layer4(i+16),
                                                          S(0) => shiftAmount(4),
                                                          S(1) => D,
                                                          output(0) => layer5(i)
                                                         );
    END generate;

    Output(31 DOWNTO 0) <= layer5(63 DOWNTO 32);

    zeroFlag: ENTITY work.zero_flag_32x1 PORT MAP (layer5(63 DOWNTO 32), ZERO);

    leftOverflow: ENTITY work.ones_flag_32x1 PORT MAP (layer5(95 DOWNTO 64), leftOver);
    rightOverflow: ENTITY work.ones_flag_32x1 PORT MAP (layer5(31 DOWNTO 0), rightOver);
    OVER <= leftOver OR rightOver after 5 ps;

    NEGATIVE <= layer5(63);

    COUT <= layer5(64) OR layer5(31) after 5 ps;
    

END logic;
--One shifts right, 0 shifts left
