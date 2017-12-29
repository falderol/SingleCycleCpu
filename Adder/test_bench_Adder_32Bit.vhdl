LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.word_type.all;

ENTITY test_bench_adder_32 IS
END test_bench_adder_32;

ARCHITECTURE test OF test_bench_adder_32 IS
    SIGNAL testIN0, testIN1: word;
    SIGNAL testCIN: STD_LOGIC;
    SIGNAL testOUTPUT: word;
    SIGNAL testOVER, testNEGATIVE, testZERO, testCOUT: STD_LOGIC; 
BEGIN

    test0: ENTITY work.Add_32(logic) PORT MAP (testIN0, testIN1, testCIN, 
                                                  testOUTPUT, testOVER, testNEGATIVE, testZERO,                                                   testCOUT
                                                 );

    PROCESS
    TYPE pattern_type IS RECORD
        IN0_32, IN1_32: word; 
        CIN_32: STD_LOGIC;
        OUTPUT_32: word; 
        OVER_32, NEGATIVE_32, ZERO_32, COUT_32: STD_LOGIC;
    END RECORD; 
    
    TYPE pattern_array IS ARRAY (NATURAL RANGE <>) OF pattern_type;
        CONSTANT patterns:pattern_array :=
							  --O    N    Z    C
            ( (x"00000000", x"00000000", '0', x"00000000", '0', '0', '1', '0'),
              (x"00000003", x"00000000", '0', x"00000003", '0', '0', '0', '0'),
              (x"00000002", x"00000001", '0', x"00000003", '0', '0', '0', '0'),
              (x"80000000", x"00000000", '0', x"80000000", '0', '1', '0', '0'),
              (x"00000001", x"80000000", '0', x"80000001", '0', '1', '0', '0'),
              (x"0ABCDEF0", x"00000000", '0', x"0ABCDEF0", '0', '0', '0', '0'),
              (x"7FFFFFFF", x"00000001", '0', x"80000000", '1', '1', '0', '0'),
              (x"00000001", x"00000001", '1', x"00000000", '0', '0', '1', '1'),
              (x"FFFFFFFF", x"AAAAAAAA", '0', x"AAAAAAA9", '0', '1', '0', '1'),
              (x"FFFFFFFF", x"0FFFFFFF", '1', x"F0000000", '0', '1', '0', '1'),
              (x"80000000", x"FFFFFFFF", '0', x"7FFFFFFF", '1', '0', '0', '1'),
              (x"80000000", x"00000001", '1', x"7FFFFFFF", '1', '0', '0', '1'),
              (x"00000001", x"00000000", '0', x"00000001", '0', '0', '0', '0')
            );
    BEGIN
        FOR i IN patterns'range LOOP
            testIN0 <= patterns(i).IN0_32;
            testIN1 <= patterns(i).IN1_32;
            testCIN <= patterns(i).CIN_32;
        
        wait for 1 ms;
        
        assert testOUTPUT = patterns(i).OUTPUT_32
            report "Output is incorrect" severity error;
        assert testOVER = patterns(i).OVER_32
            report "Overflow is incorrect" severity error;
        assert testNEGATIVE = patterns(i).NEGATIVE_32
            report "Negative is incorrect" severity error;
        assert testZERO = patterns(i).ZERO_32
            report "Zero is incorrect" severity error;
        assert testCOUT = patterns(i).COUT_32
            report "COUT is incorrect" severity error;
        END LOOP;

        assert false
            report "end of test" severity note;
        wait;
    END PROCESS;
END test;
