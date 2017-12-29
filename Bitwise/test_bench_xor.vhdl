LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.word_type.all;

ENTITY test_bench_xor IS
END test_bench_xor;

ARCHITECTURE test OF test_bench_xor IS
    SIGNAL testIN0, testIN1, testOutput: word;
    SIGNAL testNEGATIVE, testZERO: STD_LOGIC;
BEGIN
    test0: ENTITY work.XOR_32(logic) PORT MAP (testIN0, testIN1, testOutput,testNEGATIVE, testZERO);
    PROCESS
    TYPE pattern_type IS RECORD
        IN0_32, IN1_32, Output_32: word;
        NEGATIVE_L, ZERO_L: STD_LOGIC;
END RECORD;

    TYPE pattern_array IS ARRAY (NATURAL RANGE <>) OF pattern_type;
        CONSTANT patterns: pattern_array :=
            ( (x"00000000",x"FFFFFFFF",x"FFFFFFFF",'1','0'),
              (x"FFFFFFFF",x"FFFFFFFF",x"00000000",'0','1'),
              (x"DEADBEEF",x"CAFECAFE",x"14537411",'0','0')
            );
    BEGIN
        FOR i IN patterns'range LOOP
            testIN0 <= patterns(i).IN0_32;
            testIN1 <= patterns(i).IN1_32;
        wait for 1 ms;
        assert testOutput = patterns(i).Output_32
            report "Output incorrect" severity error;
        assert testNEGATIVE = patterns(i).NEGATIVE_L
            report "Negative incorrect" severity error;
        assert testZERO = patterns(i).ZERO_L
            report "Zero incorrect" severity error;
         
        END LOOP;

        assert false
            report "end of test" severity note;
        wait;
    END PROCESS;
END test;



