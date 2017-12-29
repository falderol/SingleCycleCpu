LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.word_type.all;

ENTITY test_bench_reg_x32 IS
END test_bench_reg_x32;

ARCHITECTURE test OF test_bench_reg_x32 IS
    SIGNAL testKillClock: STD_LOGIC := '0';
    SIGNAL testClock, testWriteEnable: STD_LOGIC;
    SIGNAL testWriteData, testReadData: word;

BEGIN
    testTick: ENTITY work.Clock(Behavior) PORT MAP (testKillClock, testClock);
    testReg: ENTITY work.REG_x32(logic) PORT MAP (testWriteData, testWriteEnable,
                                                  testClock, testReadData);
    PROCESS
    TYPE pattern_type IS RECORD
        writeData: word;
        writeEnable: STD_LOGIC;
        readData: word;
    END RECORD;

    TYPE pattern_array IS ARRAY (NATURAL RANGE <>) OF pattern_type;
        CONSTANT patterns: pattern_array :=
            ( ("11111111111111111111111111111111",'0',"00000000000000000000000000000000"),
              ("00000000000000000000000000000000",'1',"00000000000000000000000000000000"),
              ("11111111111111111111111111111111",'1',"11111111111111111111111111111111"),
              ("00000000000000000000000000000000",'0',"11111111111111111111111111111111"),
              ("01010101010101010101010101010101",'1',"01010101010101010101010101010101"),
              ("10101010101010101010101010101010",'1',"10101010101010101010101010101010")
            );
        BEGIN
            FOR i IN patterns'range LOOP
            testWriteData <= patterns(i).writeData;
            testWriteEnable <= patterns(i).writeEnable;
        wait for 10 ns;

        assert testReadData = patterns(i).readData
            report "bad output" severity error;
        END LOOP;
        testKillClock <= '1';
        assert false
            report "end of test" severity note;
        wait;
    END PROCESS;
END test;
