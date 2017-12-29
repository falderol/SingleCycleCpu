LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY test_bench_4x1 IS
END test_bench_4x1;

ARCHITECTURE test OF test_bench_4x1 IS
    SIGNAL testI0_4x1, testI1_4x1, testI2_4x1, testI3_4x1, testS0_4x1, 
           testS1_4x1, testOUT_4x1 : STD_LOGIC;

BEGIN
    rc: ENTITY work.MUX_4x1(logic) PORT MAP (testI0_4x1, testI1_4x1, testI2_4x1,                                             testI3_4x1, testS0_4x1, testS1_4x1,
                                             testOUT_4x1);
    PROCESS
        TYPE pattern_type IS RECORD
            I0_4x1, I1_4x1, I2_4x1, I3_4x1, S0_4x1, S1_4x1: STD_LOGIC;
            o: STD_LOGIC;
        END RECORD;

        TYPE pattern_array IS ARRAY (NATURAL RANGE <>) OF pattern_type;
        CONSTANT patterns: pattern_array :=
            ( ('0', '0', '0', '1', '0', '0', '1'),
              ('0', '0', '1', '0', '0', '1', '1'),
              ('0', '1', '0', '0', '1', '0', '1'),
              ('1', '0', '0', '0', '1', '1', '1')
            );
    BEGIN
        FOR i IN patterns'range LOOP
            testI0_4x1 <= patterns(i).I0_4x1;
            testI1_4x1 <= patterns(i).I1_4x1;
            testI2_4x1 <= patterns(i).I2_4x1;
            testI3_4x1 <= patterns(i).I3_4x1;
            testS0_4x1 <= patterns(i).S0_4x1;
            testS1_4x1 <= patterns(i).S1_4x1;

            wait for 1 ms;

            assert testOUT_4x1 = patterns(i).o 
                report "bad output" severity error;
        END LOOP;

        assert false
            report "end of test" severity note;
        wait;
    END PROCESS;
END test;
