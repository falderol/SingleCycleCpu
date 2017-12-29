LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY test_bench_32x1 IS
END test_bench_32x1;

ARCHITECTURE test OF test_bench_32x1 IS
    SIGNAL testI00, testI01, testI02, testI03, testI04, testI05, testI06, testI07,
           testI08, testI09, testI10, testI11, testI12, testI13, testI14, testI15,
           testI16, testI17, testI18, testI19, testI20, testI21, testI22, testI23,
           testI24, testI25, testI26, testI27, testI28, testI29, testI30, testI31,
           testS0, testS1, testS2, testS3, testS4, testOUT: STD_LOGIC;

BEGIN
    test32: ENTITY work.MUX_32x1_4x1(logic) PORT MAP ( testI00, testI01, testI02,
                                                       testI03, testI04, testI05,
                                                       testI06, testI07, testI08, 
                                                       testI09, testI10, testI11, 
                                                       testI12, testI13, testI14, 
                                                       testI15, testI16, testI17, 
                                                       testI18, testI19, testI20, 
                                                       testI21, testI22, testI23, 
                                                       testI24, testI25, testI26, 
                                                       testI27, testI28, testI29, 
                                                       testI30, testI31, testS0, 
                                                       testS1, testS2, testS3, 
                                                       testS4, testOUT );
    PROCESS
        TYPE pattern_type IS RECORD
            I00, I01, I02, I03, I04, I05, I06, I07, I08, I09, I10, I11, I12, I13,
            I14, I15, I16, I17, I18, I19, I20, I21, I22, I23, I24, I25, I26, I27,
            I28, I29, I30, I31, S0, S1, S2, S3, S4: STD_LOGIC; --redo for 32x1
            o: STD_LOGIC;
        END RECORD;

        TYPE pattern_array IS ARRAY (NATURAL RANGE <>) OF pattern_type;
        CONSTANT patterns: pattern_array :=
-- All 1's I00, All 0's I31
            ( ('1', '1', '1', '1', '1', '1', '1', '1', --00-07 
               '1', '1', '1', '1', '1', '1', '1', '1', --08-15
               '1', '1', '1', '1', '1', '1', '1', '1', --16-21
               '1', '1', '1', '1', '1', '1', '1', '1', --22-31
               '0', '0', '0', '0', '0', --Signal 0-4
               '1'), -- output
              ('1', '0', '0', '0', '0', '0', '0', '0', --00-07 
               '0', '0', '0', '0', '0', '0', '0', '0', --08-15
               '0', '0', '0', '0', '0', '0', '0', '0', --16-21
               '0', '0', '0', '0', '0', '0', '0', '0', --22-31
               '0', '0', '0', '0', '0', --Signal 0-4
               '1'), -- output
              ('0', '1', '0', '0', '0', '0', '0', '0', --00-07 
               '0', '0', '0', '0', '0', '0', '0', '0', --08-15
               '0', '0', '0', '0', '0', '0', '0', '0', --16-21
               '0', '0', '0', '0', '0', '0', '0', '0', --22-31
               '0', '0', '0', '0', '1', --Signal 0-4
               '1'), -- output
              ('0', '0', '1', '0', '0', '0', '0', '0', --00-07
               '0', '0', '0', '0', '0', '0', '0', '0', --08-15
               '0', '0', '0', '0', '0', '0', '0', '0', --16-21
               '0', '0', '0', '0', '0', '0', '0', '0', --22-31
               '0', '0', '0', '1', '0', --Signal 0-4
               '1'), -- output
              ('0', '0', '0', '0', '1', '0', '0', '0', --00-07
               '0', '0', '0', '0', '0', '0', '0', '0', --08-15
               '0', '0', '0', '0', '0', '0', '0', '0', --16-21
               '0', '0', '0', '0', '0', '0', '0', '0', --22-31
               '0', '0', '1', '0', '0', --Signal 0-4
               '1'), -- output
              ('0', '0', '0', '0', '0', '0', '0', '0', --00-07
               '1', '0', '0', '0', '0', '0', '0', '0', --08-15
               '0', '0', '0', '0', '0', '0', '0', '0', --16-21
               '0', '0', '0', '0', '0', '0', '0', '0', --22-31
               '0', '1', '0', '0', '0', --Signal 0-4
               '1'), -- output
              ('0', '0', '0', '0', '0', '0', '0', '1', --00-07
               '0', '0', '0', '0', '0', '0', '0', '0', --08-15
               '0', '0', '0', '0', '0', '0', '0', '0', --16-21
               '0', '0', '0', '0', '0', '0', '0', '0', --22-31
               '0', '0', '1', '1', '1', --Signal 0-4
               '1'), -- output
              ('0', '0', '0', '0', '0', '0', '0', '0', --00-07
               '0', '1', '0', '0', '0', '0', '0', '0', --08-15
               '0', '0', '0', '0', '0', '0', '0', '0', --16-21
               '0', '0', '0', '0', '0', '0', '0', '0', --22-31
               '0', '1', '0', '0', '1', --Signal 0-4
               '1'), -- output



              ('0', '0', '0', '0', '0', '0', '0', '0', --00-07
               '0', '0', '0', '0', '0', '0', '0', '0', --08-15
               '1', '0', '0', '0', '0', '0', '0', '0', --16-21
               '0', '0', '0', '0', '0', '0', '0', '0', --22-31
               '1', '0', '0', '0', '0', --Signal 0-4
               '1'), -- output
              ('0', '0', '0', '0', '0', '0', '0', '0', --00-07 
               '0', '0', '0', '0', '0', '0', '0', '0', --08-15
               '0', '0', '0', '0', '0', '0', '0', '0', --16-21
               '0', '0', '0', '0', '0', '0', '0', '1', --22-31
               '1', '1', '1', '1', '1', --Signal 0-4
               '1'), -- output
              ('0', '0', '0', '0', '0', '0', '0', '0', --00-07
               '0', '0', '0', '0', '0', '0', '0', '0', --08-15
               '0', '0', '0', '0', '0', '0', '0', '0', --16-21
               '0', '0', '0', '0', '0', '0', '0', '0', --22-31
               '0', '0', '0', '0', '0', --Signal 0-4
               '0') -- output
            );
    BEGIN
        FOR i IN patterns'range LOOP
            testI00 <= patterns(i).I00;
            testI01 <= patterns(i).I01;
            testI02 <= patterns(i).I02;
            testI03 <= patterns(i).I03;
            testI04 <= patterns(i).I04;
            testI05 <= patterns(i).I05;
            testI06 <= patterns(i).I06;
            testI07 <= patterns(i).I07;
            testI08 <= patterns(i).I08;
            testI09 <= patterns(i).I09;
            testI10 <= patterns(i).I10;
            testI11 <= patterns(i).I11;
            testI12 <= patterns(i).I12;
            testI13 <= patterns(i).I13;
            testI14 <= patterns(i).I14;
            testI15 <= patterns(i).I15;
            testI16 <= patterns(i).I16;
            testI17 <= patterns(i).I17;
            testI18 <= patterns(i).I18;
            testI19 <= patterns(i).I19;
            testI20 <= patterns(i).I20;
            testI21 <= patterns(i).I21;
            testI22 <= patterns(i).I22;
            testI23 <= patterns(i).I23;
            testI24 <= patterns(i).I24;
            testI25 <= patterns(i).I25;
            testI26 <= patterns(i).I26;
            testI27 <= patterns(i).I27;
            testI28 <= patterns(i).I28;
            testI29 <= patterns(i).I29;
            testI30 <= patterns(i).I30;
            testI31 <= patterns(i).I31;
            testS0 <= patterns(i).S0;
            testS1 <= patterns(i).S1;
            testS2 <= patterns(i).S2;
            testS3 <= patterns(i).S3;
            testS4 <= patterns(i).S4;

            wait for 1 ms;

            assert testOUT = patterns(i).o
                report "bad output" severity error;
        END LOOP;

        assert false
            report "end of test" severity note;
        wait;
    END PROCESS;
END test;
