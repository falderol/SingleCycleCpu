Library ieee;
USE ieee.std_logic_1164.all;
USE work.word_type.all;

ENTITY test_bench_zero_flag IS
END test_bench_zero_flag;

ARCHITECTURE test OF test_bench_zero_flag IS
    SIGNAL testIn: word;
    SIGNAL testOut: STD_LOGIC;
BEGIN
    testZeroFlag: ENTITY work.zero_flag_32x1(logic) PORT MAP (testIn, testOut);

    PROCESS
    TYPE pattern_type IS RECORD
        Inp: word;
        Outp: STD_LOGIC;
    END RECORD;

    TYPE pattern_array IS ARRAY (NATURAL RANGE <>) OF pattern_type;
        CONSTANT patterns: pattern_array :=
            ( (x"DEADBEEF", '0'),
              (x"B0000000", '0'),
              (x"00000000", '1'),
              (x"CAFEBEEF", '0')            
            );
    BEGIN
        FOR i IN patterns'range LOOP
            testIn <= patterns(i).Inp;
        wait for 1 ms;
        assert testOut = patterns(i).Outp
            report "Zero flag failed" severity error;
        END LOOP;
        
        assert false
            report "end of test" severity note;
        wait;
    END PROCESS;
END test;
