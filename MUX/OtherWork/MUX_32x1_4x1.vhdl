LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY MUX_32x1_4x1 IS
    PORT (I00, I01, I02, I03, I04, I05, I06, I07, I08, I09, I10, I11, I12, I13,
          I14, I15, I16, I17, I18, I19, I20, I21, I22, I23, I24, I25, I26, I27,
          I28, I29, I30, I31, S0, S1, S2, S3, S4: IN STD_LOGIC;
          output: OUT STD_LOGIC);
END MUX_32x1_4x1;

--Maximum of 4 terms and one type per statement.
ARCHITECTURE logic OF MUX_32x1_4x1 IS
    SIGNAL S0_4x1, S1_4x1, S2_4x1, S3_4x1, S4_4x1,
           I00_4x1, I01_4x1, I02_4x1, I03_4x1, O00_4x1,
           I04_4x1, I05_4x1, I06_4x1, I07_4x1, O01_4x1,
           I08_4x1, I09_4x1, I10_4x1, I11_4x1, O02_4x1,
           I12_4x1, I13_4x1, I14_4x1, I15_4x1, O03_4x1,
           I16_4x1, I17_4x1, I18_4x1, I19_4x1, O04_4x1,
           I20_4x1, I21_4x1, I22_4x1, I23_4x1, O05_4x1,
           I24_4x1, I25_4x1, I26_4x1, I27_4x1, O06_4x1,
           I28_4x1, I29_4x1, I30_4x1, I31_4x1, O07_4x1,
           O08_4x1, O09_4x1, O10_4x1
           : STD_LOGIC;
BEGIN

-- First Layer of 4x MUX's
    MUX00: ENTITY work.MUX_4x1(logic) PORT MAP (I00_4x1, I01_4x1, I02_4x1,
                                                I03_4x1, S3_4x1, S4_4x1,
                                                O00_4x1);
    MUX01: ENTITY work.MUX_4x1(logic) PORT MAP (I04_4x1, I05_4x1, I06_4x1,
                                                I07_4x1, S3_4x1, S4_4x1,
                                                O01_4x1);
    MUX02: ENTITY work.MUX_4x1(logic) PORT MAP (I08_4x1, I09_4x1, I10_4x1,
                                                I11_4x1, S3_4x1, S4_4x1,
                                                O02_4x1);
    MUX03: ENTITY work.MUX_4x1(logic) PORT MAP (I12_4x1, I13_4x1, I14_4x1,
                                                I15_4x1, S3_4x1, S4_4x1,
                                                O03_4x1);
    MUX04: ENTITY work.MUX_4x1(logic) PORT MAP (I16_4x1, I17_4x1, I18_4x1,
                                                I19_4x1, S3_4x1, S4_4x1,
                                                O04_4x1);
    MUX05: ENTITY work.MUX_4x1(logic) PORT MAP (I20_4x1, I21_4x1, I22_4x1,
                                                I23_4x1, S3_4x1, S4_4x1,
                                                O05_4x1);
    MUX06: ENTITY work.MUX_4x1(logic) PORT MAP (I24_4x1, I25_4x1, I26_4x1,
                                                I27_4x1, S3_4x1, S4_4x1,
                                                O06_4x1);
    MUX07: ENTITY work.MUX_4x1(logic) PORT MAP (I28_4x1, I29_4x1, I30_4x1,
                                                I31_4x1, S3_4x1, S4_4x1,
                                                O07_4x1);
-- Second Layer of 4x MUX's
    MUX08: ENTITY work.MUX_4x1(logic) PORT MAP (O00_4x1, O01_4x1, O02_4x1,
                                                O03_4x1, S1_4x1, S2_4x1,
                                                O08_4x1);
    MUX09: ENTITY work.MUX_4x1(logic) PORT MAP (O04_4x1, O05_4x1, O06_4x1,
                                                O07_4x1, S1_4x1, S2_4x1,
                                                O09_4x1);
-- Third Layer of 2x MUX
    MUX10: ENTITY work.MUX_2x1(logic) PORT MAP (O08_4x1, O09_4x1, S0_4x1,
                                                O10_4x1);
    
    I00_4x1 <= I00;
    I01_4x1 <= I01;
    I02_4x1 <= I02;
    I03_4x1 <= I03;
    I04_4x1 <= I04;
    I05_4x1 <= I05;
    I06_4x1 <= I06;
    I07_4x1 <= I07;
    I08_4x1 <= I08;
    I09_4x1 <= I09;
    I10_4x1 <= I10;
    I11_4x1 <= I11;
    I12_4x1 <= I12;
    I13_4x1 <= I13;
    I14_4x1 <= I14;
    I15_4x1 <= I15;
    I16_4x1 <= I16;
    I17_4x1 <= I17;
    I18_4x1 <= I18;
    I19_4x1 <= I19;
    I20_4x1 <= I20;
    I21_4x1 <= I21;
    I22_4x1 <= I21;
    I23_4x1 <= I22;
    I24_4x1 <= I24;
    I25_4x1 <= I25;
    I26_4x1 <= I26;
    I27_4x1 <= I27;
    I28_4x1 <= I28;
    I29_4x1 <= I29;
    I30_4x1 <= I30;
    I31_4x1 <= I31;

    S0_4x1 <= S0;
    S1_4x1 <= S1;
    S2_4x1 <= S2;
    S3_4x1 <= S3;
    S4_4x1 <= S4;

    output <= O10_4x1;
END logic;
