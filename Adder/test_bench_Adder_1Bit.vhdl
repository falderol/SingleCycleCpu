LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY test_bench_Add_1 IS
END test_bench_Add_1;

ARCHITECTURE test OF test_Bench_Add_1 IS
    SIGNAL testI0, testI1, testCIN, testSIG, testCOUT: STD_LOGIC;

BEGIN
    test1: ENTITY work.Add_1(logic) PORT MAP (testI0, testI1, testCIN, testSIG, testCOUT);
    PROCESS
    TYPE pattern_type IS RECORD
        I0_1, I1_1, CIN_1, SIG_1, COUT_1: STD_LOGIC;
    END RECORD;

    TYPE pattern_array IS ARRAY (NATURAL RANGE <>) OF pattern_type;
        CONSTANT patterns: pattern_array :=
            ( ('0', '0', '0', '0', '0'),
              ('0', '0', '1', '1', '0'),
              ('0', '1', '0', '1', '0'),
              ('0', '1', '1', '0', '1'),
              ('1', '0', '0', '1', '0'),
              ('1', '0', '1', '0', '1'),
              ('1', '1', '0', '0', '1'),
              ('1', '1', '1', '1', '1')
            );
    BEGIN
        FOR i IN patterns'range LOOP
            testI0  <= patterns(i).I0_1;
            testI1  <= patterns(i).I1_1;
            testCIN <= patterns(i).CIN_1;
        wait for 1 ns;

        assert testSIG = patterns(i).SIG_1
            report "SIG Incorrect" severity error;
        assert testCOUT = patterns(i).COUT_1
            report "COUT Incorrect" severity error;
        END LOOP;

        assert false
            report "end of test" severity note;
        wait;
    END PROCESS;
END test;

