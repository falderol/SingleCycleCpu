LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY test_bench_2x1 IS
END test_bench_2x1;

ARCHITECTURE test OF test_bench_2x1 IS
    SIGNAL testI0_2x1, testI1_2x1, testS0_2x1, testOUT_2x1 : STD_LOGIC;

BEGIN
    rc: ENTITY work.MUX_2x1(logic) PORT MAP (testI0_2x1, testI1_2x1, testS0_2x1, testOUT_2x1);
    PROCESS
        TYPE pattern_type IS RECORD
            I0_2x1, I1_2x1, S0_2x1: STD_LOGIC;
            o: STD_LOGIC;
        END RECORD;

        TYPE pattern_array IS ARRAY (NATURAL RANGE <>) OF pattern_type;
        CONSTANT patterns: pattern_array :=
            ( ('0', '1', '0', '1'),
              ('0', '1', '1', '0')
            );
    BEGIN
        FOR i IN patterns'range LOOP
            testI0_2x1 <= patterns(i).I0_2x1;
            testI1_2x1 <= patterns(i).I1_2x1;
            testS0_2x1 <= patterns(i).S0_2x1;

            wait for 1 ms;

            assert testOUT_2x1 = patterns(i).o
                report "bad output" severity error;
        END LOOP;

        assert false
            report "end of test" severity note;
        wait;
    END PROCESS;
END test;
