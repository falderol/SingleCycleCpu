LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY test_bench_2x1_vector IS
END test_bench_2x1_vector;

ARCHITECTURE test OF test_bench_2x1_vector IS
    SIGNAL testI: STD_LOGIC_VECTOR(1 DOWNTO 0); 
    SIGNAL testS: STD_LOGIC_VECTOR(0 DOWNTO 0);
    SIGNAL testOUT : STD_LOGIC_VECTOR(0 DOWNTO 0);

BEGIN
    rc: ENTITY work.MUX_2x1_vector(logic) PORT MAP (testI, testS, testOUT);
    PROCESS
        TYPE pattern_type IS RECORD
            I: STD_LOGIC_VECTOR(1 DOWNTO 0);
            S: STD_LOGIC_VECTOR(0 DOWNTO 0);
            o: STD_LOGIC_VECTOR(0 DOWNTO 0);
        END RECORD;

        TYPE pattern_array IS ARRAY (NATURAL RANGE <>) OF pattern_type;
        CONSTANT patterns: pattern_array :=
            ( ("01", "0", "1"),
              ("01", "1", "0")
            );
    BEGIN
        FOR i IN patterns'range LOOP
            testI(0) <= patterns(i).I(0);
            testI(1) <= patterns(i).I(1);
            testS(0) <= patterns(i).S(0);

            wait for 1 ms;

            assert testOUT= patterns(i).o
                report "bad output" severity error;
        END LOOP;

        assert false
            report "end of test" severity note;
        wait;
    END PROCESS;
END test;
