LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY test_bench_Dec_4x16 IS
END test_bench_Dec_4x16;

ARCHITECTURE test OF test_bench_Dec_4x16 IS
    SIGNAL testInput: STD_LOGIC_VECTOR(3 DOWNTO 0); 
    SIGNAL testOutput: STD_LOGIC_VECTOR(15 DOWNTO 0);

BEGIN
    test4x16: ENTITY work.DEC_4x16(logic) PORT MAP (testInput, testOutput);
    PROCESS
    TYPE pattern_type IS RECORD
        Input_4x16: STD_LOGIC_VECTOR(3 DOWNTO 0);
        Output_4x16: STD_LOGIC_VECTOR(15 DOWNTO 0);
    END RECORD;

    TYPE pattern_array IS ARRAY (NATURAL RANGE <>) OF pattern_type;
        CONSTANT patterns: pattern_array :=
            ( ("0000", "0000000000000001"),
              ("0001", "0000000000000010"),
              ("0010", "0000000000000100"),
              ("0011", "0000000000001000"),
              ("0100", "0000000000010000"),
              ("0101", "0000000000100000"),
              ("0110", "0000000001000000"),
              ("0111", "0000000010000000"),
              ("1000", "0000000100000000"),
              ("1001", "0000001000000000"),
              ("1010", "0000010000000000"),
              ("1011", "0000100000000000"),
              ("1100", "0001000000000000"),
              ("1101", "0010000000000000"),
              ("1110", "0100000000000000"),
              ("1111", "1000000000000000")
            );
    BEGIN
        FOR i In patterns'range LOOP
            testInput <= patterns(i).Input_4x16;

        wait for 1 ms;
 
        assert testOutput = patterns(i).Output_4x16
            report "bad output" severity error;
        END LOOP;

        assert false
            report "end of test" severity note;
        wait;
    END PROCESS;
END test;

