LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.word_type.all;

ENTITY test_bench_barrel_shifter IS
END test_bench_barrel_shifter;

ARCHITECTURE test OF test_bench_barrel_shifter IS
    SIGNAL testInput, testShiftAmount: word;
    SIGNAL testDirection: STD_LOGIC;
    SIGNAL testOutput: word;
    SIGNAL testOVER, testNEGATIVE, testZERO, testCOUT: STD_LOGIC;
BEGIN

    test0: ENTITY work.barrel_shifter(logic) PORT MAP(testInput, testShiftAmount, testDirection,testOutput,
                                                      testOVER, testNEGATIVE, testZERO, testCOUT
                                                     );
    PROCESS
    TYPE pattern_type IS RECORD
        Input_32, ShiftAmount_32: word;
        Direction_32: STD_LOGIC;
        Output_32: word;
        OVER_32, NEGATIVE_32, ZERO_32, COUT_32: STD_LOGIC;
    END RECORD;

    TYPE pattern_array IS ARRAY (NATURAL RANGE <>) OF pattern_type;
        CONSTANT patterns:pattern_array :=
--                Input        Shift      D       Out       O    N    Z    C
            ( (x"00000001", x"00000001", '0', x"00000002", '0', '0', '0', '0'), --basic left
              (x"10000000", x"00000001", '1', x"08000000", '0', '0', '0', '0'), --basic right
              (x"55555555", x"00000001", '0', x"AAAAAAAA", '0', '1', '0', '0'), --basic left
              (x"F0000000", x"00000003", '0', x"80000000", '1', '1', '0', '1'), --overflow
              (x"FFFFFFFF", x"000000FF", '0', x"80000000", '1', '1', '0', '1'), --shift everything all left
              (x"FFFFFFFF", x"000000FF", '1', x"00000001", '1', '0', '0', '1'), --shift everything all right
              (x"00000000", x"00000000", '1', x"00000000", '0', '0', '1', '0')
            );
    BEGIN
        FOR i IN patterns'range LOOP
            testInput <= patterns(i).Input_32;
            testShiftAmount <= patterns(i).ShiftAmount_32;
            testDirection <= patterns(i).Direction_32;
        
        wait for 1 ms;

        assert testOutput = patterns(i).Output_32
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
