LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.word_type.all;

ENTITY test_bench_less_than IS
END test_bench_less_than;

ARCHITECTURE test OF test_bench_less_than IS
    SIGNAL testIN0, testIN1, testOutput: word;
    SIGNAL testZERO: STD_LOGIC;
BEGIN
    test0: ENTITY work.less_than_32(logic) PORT MAP (testIN0, testIN1, testOutput, testZERO);
    PROCESS
    TYPE pattern_type IS RECORD
        IN0_32, IN1_32, Output_32: word;
        ZERO_L: STD_LOGIC;
END RECORD;

    TYPE pattern_array IS ARRAY (NATURAL RANGE <>) OF pattern_type;
        CONSTANT patterns: pattern_array :=
            ( (x"55555555",x"44444444",x"00000000",'0'),
              (x"22222222",x"55555555",x"00000001",'0'),
              (x"0CA7CAFE",x"0CA7CAFE",x"00000000",'1')
            );
    BEGIN
        FOR i IN patterns'range LOOP
            testIN0 <= patterns(i).IN0_32;
            testIN1 <= patterns(i).IN1_32;
        wait for 1 ms;
        assert testOutput = patterns(i).Output_32
            report "Output incorrect" severity error;
        assert testZERO = patterns(i).ZERO_l
            report "Zero incorrect" severity error;
         
        END LOOP;

        assert false
            report "end of test" severity note;
        wait;
    END PROCESS;
END test;


