LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY test_bench_Dec_1x2 IS
END test_bench_Dec_1x2;

ARCHITECTURE test OF test_bench_Dec_1x2 IS
    SIGNAL testInput: STD_LOGIC; 
    SIGNAL testOutput: STD_LOGIC_VECTOR(1 DOWNTO 0);

BEGIN
    test1x2: ENTITY work.DEC_1x2(logic) PORT MAP (testInput, testOutput);
    PROCESS
    TYPE pattern_type IS RECORD
        Input_1x2: STD_LOGIC;
        Output_1x2: STD_LOGIC_VECTOR(1 DOWNTO 0);
    END RECORD;

    TYPE pattern_array IS ARRAY (NATURAL RANGE <>) OF pattern_type;
        CONSTANT patterns: pattern_array :=
            ( ('0', "01"),
              ('1', "10")
            );
    BEGIN
        FOR i In patterns'range LOOP
            testInput <= patterns(i).Input_1x2;

        wait for 1 ms;
 
        assert testOutput = patterns(i).Output_1x2
            report "bad output" severity error;
        END LOOP;

        assert false
            report "end of test" severity note;
        wait;
    END PROCESS;
END test;
