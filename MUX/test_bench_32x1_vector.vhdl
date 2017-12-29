LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY test_bench_32x1_vector IS
END test_bench_32x1_vector;

ARCHITECTURE test OF test_bench_32x1_vector IS
    SIGNAL testI: STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL testS: STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL testOUT: STD_LOGIC_VECTOR(0 DOWNTO 0);

BEGIN
    test32: ENTITY work.MUX_32x1_vector(logic) PORT MAP ( testI, testS, testOUT );
    PROCESS
        TYPE pattern_type IS RECORD
            I: STD_LOGIC_VECTOR(31 DOWNTO 0);
            S: STD_LOGIC_VECTOR(4 DOWNTO 0);
            o: STD_LOGIC_VECTOR(0 DOWNTO 0);
        END RECORD;

        TYPE pattern_array IS ARRAY (NATURAL RANGE <>) OF pattern_type;
        CONSTANT patterns: pattern_array :=
-- All 1's I00, All 0's I31
            ( ("00000000000000000000000000000000","00000","0"),
              ("00000000000000000000000000000001","00000","1"),
              ("00000000000000000000000000000010","00001","1"),
              ("00000000000000000000000000000100","00010","1"),
              ("00000000000000000000000000010000","00100","1"),
              ("00000000000000000000000001000000","00110","1"),
              ("00000000000000000000000100000000","01000","1"),
              ("00000000000000000000100000000000","01011","1"),
              ("00000000000000010000000000000000","10000","1"),
              ("00000100000000000000000000000000","11010","1"),
              ("10000000000000000000000000000000","11111","1")
            );
    BEGIN
        FOR i IN patterns'range LOOP
            testI <= patterns(i).I;
            testS <= patterns(i).S;

            wait for 1 ms;

            assert testOUT = patterns(i).o
                report "bad output" severity error;
        END LOOP;

        assert false
            report "end of test" severity note;
        wait;
    END PROCESS;
END test;
