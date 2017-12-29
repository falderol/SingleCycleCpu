LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.word_type.all;
USE work.op_type.all;

ENTITY test_bench_alu IS
END test_bench_alu;

ARCHITECTURE test of test_bench_alu IS
    SIGNAL testValue1, testValue2: word;
    SIGNAL testOperation: op;
    SIGNAL testValueOut: word;
    Signal testOverflow, testNegative, testZero, testCarryOut: STD_LOGIC;
BEGIN
    test0: ENTITY work.ALU(logic) PORT MAP(testValue1, testValue2, 
                                           testOperation,
                                           testValueOut,
                                           testOverflow, testNegative, testZero, testCarryOut
                                          );
    PROCESS
    TYPE pattern_type IS RECORD
        Value1_ALU, Value2_ALU: word;
        Operation_ALU: op;
        ValueOut_ALU: word;
        Overflow_ALU, Negative_ALU, Zero_ALU, CarryOut_ALU: STD_LOGIC;
    END RECORD;

    TYPE pattern_array IS ARRAY (NATURAL RANGE <>) of pattern_type;
        CONSTANT patterns:pattern_array :=
--                 VAL1         VAL2       OP        OUTP      O    N    Z    C
            ( (x"00000000", x"FFFF0000", "0000", x"FFFF0000", '0', '1', '0', '0'), --Add
              (x"F00F00F0", x"01001001", "0001", x"F10F10F1", '0', '0', '0', '0'), --Add Unsigned
              (x"FFFFFFFF", x"00000004", "0010", x"FFFFFFF0", '1', '1', '0', '1'), --Left shift
              (x"FFFFFFFF", x"00000004", "0011", x"0FFFFFFF", '1', '0', '0', '1'), --Right shift
              (x"00000000", x"00000001", "0100", x"FFFFFFFF", '0', '1', '0', '0'), --Subtract
              (x"12345678", x"87654321", "0101", x"00000001", '0', '0', '0', '0'), --Set Less
              (x"FFFFFFFF", x"00000000", "1000", x"FFFFFFFF", '0', '1', '0', '0'), --xor
              (x"FFFFFFFF", x"00000000", "1001", x"00000000", '0', '0', '1', '0'), --nor
              (x"FFFFFFFF", x"00000000", "1010", x"FFFFFFFF", '0', '1', '0', '0'), --nand
              (x"FFFFFFFF", x"00000000", "1100", x"00000000", '0', '0', '1', '0'), --compliment
              (x"DEADBEEF", x"CAFECAFE", "0000", x"A9AC89ED", '0', '1', '0', '1'), --Add
              (x"DEADBEEF", x"CAFECAFE", "0001", x"A9AC89ED", '0', '0', '0', '1'), --Add unsigned
              (x"DEADBEEF", x"CAFECAFE", "0010", x"C0000000", '1', '1', '0', '1'), --Left shift
              (x"DEADBEEF", x"CAFECAFE", "0011", x"00000003", '1', '0', '0', '0'), --Right shift
              (x"DEADBEEF", x"CAFECAFE", "0100", x"13AEF3F1", '0', '0', '0', '1'), --Subtract
              (x"DEADBEEF", x"CAFECAFE", "0101", x"00000000", '0', '0', '0', '0'), --Set Less
              (x"DEADBEEF", x"CAFECAFE", "1000", x"14537411", '0', '0', '0', '0'), --xor
              (x"DEADBEEF", x"CAFECAFE", "1001", x"21000100", '0', '0', '0', '0'), --nor
              (x"DEADBEEF", x"CAFECAFE", "1010", x"35537511", '0', '0', '0', '0'), --nand
              (x"DEADBEEF", x"CAFECAFE", "1100", x"21524110", '0', '0', '0', '0'), --compliment
              (x"00000000", x"00000000", "0000", x"00000000", '0', '0', '1', '0')
            );
    BEGIN 
        FOR i IN patterns'range LOOP
            testValue1 <= patterns(i).Value1_ALU;
            testValue2 <= patterns(i).Value2_ALU;
            testOperation <= patterns(i).Operation_ALU;

        wait for 1 ms;

        assert testValueOut = patterns(i).ValueOut_ALU
            report "Output is incorrect" severity error;
        assert testOverflow = patterns(i).Overflow_ALU
            report "Overflow is incorrect" severity error;
        assert testNegative = patterns(i).Negative_ALU
            report "Negative is incorrect" severity error;
        assert testZero = patterns(i).Zero_ALU
            report "Zero is incorrect" severity error;
        assert testCarryOut = patterns(i).CarryOut_ALU
            report "CarryOut is incorrect" severity error;
        END LOOP;
    
        assert false
            report "end of test" severity note;
        wait;
    END PROCESS;
END test;
