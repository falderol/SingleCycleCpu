LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.word_type.all;
USE work.reg_type.all;

ENTITY test_bench_regfile_32x32 IS
END test_bench_regfile_32x32;

ARCHITECTURE test OF test_bench_regfile_32x32 IS
    SIGNAL testKillClock: STD_LOGIC := '0';
    SIGNAL testReg1, testReg2, testWriteReg: reg_address;
    SIGNAL testClock, testWE: STD_LOGIC;
    SIGNAL testWriteData, testRead1Data, testRead2Data: word;
BEGIN

    testTick: ENTITY work.Clock(Behavior) PORT MAP (testKillClock, testClock);
    testRegFile: ENTITY work.REGFILE_32x32(logic) PORT MAP(testReg1, testReg2, testWriteReg,
                                                           testWe, testClock,
                                                           testWriteData,
                                                           testRead1Data, testRead2Data
                                                          ); 
    PROCESS
    TYPE pattern_type IS RECORD
        reg1, reg2, writeReg: reg_address;
        WE: STD_LOGIC;
        writeData, read1Data, read2Data: word;
    END RECORD;

    TYPE pattern_array IS ARRAY (NATURAL RANGE <>) OF pattern_type;
        CONSTANT patterns:pattern_array :=
            ( ("00000", "00001", "00001", --reg1, reg2, writeReg
               '1', --writeEnable
               x"00000001",x"00000000",x"00000001"), -- writeData, read1Data, read2Data
--01
              ("00000", "00010", "00010", --reg1, reg2, writeReg
               '1', --writeEnable
               x"00000002",x"00000000",x"00000002"), -- writeData, read1Data, read2Data  
--02
              ("00000", "00011", "00011", --reg1, reg2, writeReg
               '1', --writeEnable
               x"00000003",x"00000000",x"00000003"), -- writeData, read1Data, read2Data  
--03
              ("00000", "00100", "00100", --reg1, reg2, writeReg
               '1', --writeEnable
               x"00000004",x"00000000",x"00000004"), -- writeData, read1Data, read2Data  
--04
              ("00000", "00101", "00101", --reg1, reg2, writeReg
               '1', --writeEnable
               x"00000005",x"00000000",x"00000005"), -- writeData, read1Data, read2Data  
--05
              ("00000", "00110", "00110", --reg1, reg2, writeReg
               '1', --writeEnable
               x"00000006",x"00000000",x"00000006"), -- writeData, read1Data, read2Data  
--06
              ("00000", "00111", "00111", --reg1, reg2, writeReg
               '1', --writeEnable
               x"00000007",x"00000000",x"00000007"), -- writeData, read1Data, read2Data  
--07
              ("00000", "01000", "01000", --reg1, reg2, writeReg
               '1', --writeEnable
               x"00000008",x"00000000",x"00000008"), -- writeData, read1Data, read2Data  
--08
              ("00000", "01001", "01001", --reg1, reg2, writeReg
               '1', --writeEnable
               x"00000009",x"00000000",x"00000009"), -- writeData, read1Data, read2Data  
--09
              ("00000", "01010", "01010", --reg1, reg2, writeReg
               '1', --writeEnable
               x"0000000A",x"00000000",x"0000000A"), -- writeData, read1Data, read2Data  
--10
              ("00000", "01011", "01011", --reg1, reg2, writeReg
               '1', --writeEnable
               x"0000000B",x"00000000",x"0000000B"), -- writeData, read1Data, read2Data  
--11
              ("00000", "01100", "01100", --reg1, reg2, writeReg
               '1', --writeEnable
               x"0000000C",x"00000000",x"0000000C"), -- writeData, read1Data, read2Data  
--12
              ("00000", "01101", "01101", --reg1, reg2, writeReg
               '1', --writeEnable
               x"0000000D",x"00000000",x"0000000D"), -- writeData, read1Data, read2Data  
--13
              ("00000", "01110", "01110", --reg1, reg2, writeReg
               '1', --writeEnable
               x"0000000E",x"00000000",x"0000000E"), -- writeData, read1Data, read2Data  
--14
              ("00000", "01111", "01111", --reg1, reg2, writeReg
               '1', --writeEnable
               x"0000000F",x"00000000",x"0000000F"), -- writeData, read1Data, read2Data  
--15
              ("00000", "10000", "10000", --reg1, reg2, writeReg
               '1', --writeEnable
               x"00000010",x"00000000",x"00000010"), -- writeData, read1Data, read2Data  
--16
              ("00000", "10001", "10001", --reg1, reg2, writeReg
               '1', --writeEnable
               x"00000011",x"00000000",x"00000011"), -- writeData, read1Data, read2Data  
--17
              ("00000", "10010", "10010", --reg1, reg2, writeReg
               '1', --writeEnable
               x"00000012",x"00000000",x"00000012"), -- writeData, read1Data, read2Data  
--18
              ("00000", "10011", "10011", --reg1, reg2, writeReg
               '1', --writeEnable
               x"00000013",x"00000000",x"00000013"), -- writeData, read1Data, read2Data  
--19
              ("00000", "10100", "10100", --reg1, reg2, writeReg
               '1', --writeEnable
               x"00000014",x"00000000",x"00000014"), -- writeData, read1Data, read2Data  
--20
              ("00000", "10101", "10101", --reg1, reg2, writeReg
               '1', --writeEnable
               x"00000015",x"00000000",x"00000015"), -- writeData, read1Data, read2Data  
--21
              ("00000", "10110", "10110", --reg1, reg2, writeReg
               '1', --writeEnable
               x"00000016",x"00000000",x"00000016"), -- writeData, read1Data, read2Data  
--22
              ("00000", "10111", "10111", --reg1, reg2, writeReg
               '1', --writeEnable
               x"00000017",x"00000000",x"00000017"), -- writeData, read1Data, read2Data  
--23
              ("00000", "11000", "11000", --reg1, reg2, writeReg
               '1', --writeEnable
               x"00000018",x"00000000",x"00000018"), -- writeData, read1Data, read2Data  
--24
              ("00000", "11001", "11001", --reg1, reg2, writeReg
               '1', --writeEnable
               x"00000019",x"00000000",x"00000019"), -- writeData, read1Data, read2Data  
--25
              ("00000", "11010", "11010", --reg1, reg2, writeReg
               '1', --writeEnable
               x"0000001A",x"00000000",x"0000001A"), -- writeData, read1Data, read2Data  
--26
              ("00000", "11011", "11011", --reg1, reg2, writeReg
               '1', --writeEnable
               x"0000001B",x"00000000",x"0000001B"), -- writeData, read1Data, read2Data  
--27
              ("00000", "11100", "11100", --reg1, reg2, writeReg
               '1', --writeEnable
               x"0000001C",x"00000000",x"0000001C"), -- writeData, read1Data, read2Data  
--28
              ("00000", "11101", "11101", --reg1, reg2, writeReg
               '1', --writeEnable
               x"0000001D",x"00000000",x"0000001D"), -- writeData, read1Data, read2Data  
--29
              ("00000", "11110", "11110", --reg1, reg2, writeReg
               '1', --writeEnable
               x"0000001E",x"00000000",x"0000001E"), -- writeData, read1Data, read2Data  
--30
              ("00000", "11111", "11111", --reg1, reg2, writeReg
               '1', --writeEnable
               x"0000001F",x"00000000",x"0000001F"), -- writeData, read1Data, read2Data  
--31 All registers are now assigned to have a unique value corresponding to thier register number
              ("00000", "00001", "00000", --reg1, reg2, writeReg
               '0', --writeEnable
               x"00000000",x"00000000",x"00000001"), -- writeData, read1Data, read2Data  
--32
              ("00010", "00011", "00000", --reg1, reg2, writeReg
               '0', --writeEnable
               x"00000000",x"00000002",x"00000003"), -- writeData, read1Data, read2Data  
--33
              ("00100", "00101", "00000", --reg1, reg2, writeReg
               '0', --writeEnable
               x"00000000",x"00000004",x"00000005"), -- writeData, read1Data, read2Data  
--34
              ("00110", "00111", "00000", --reg1, reg2, writeReg
               '0', --writeEnable
               x"00000000",x"00000006",x"00000007"), -- writeData, read1Data, read2Data  
--35
              ("01000", "01001", "00000", --reg1, reg2, writeReg
               '0', --writeEnable
               x"00000000",x"00000008",x"00000009"), -- writeData, read1Data, read2Data  
--36
              ("01010", "01011", "00000", --reg1, reg2, writeReg
               '0', --writeEnable
               x"00000000",x"0000000A",x"0000000B"), -- writeData, read1Data, read2Data  
--37
              ("01100", "01101", "00000", --reg1, reg2, writeReg
               '0', --writeEnable
               x"00000000",x"0000000C",x"0000000D"), -- writeData, read1Data, read2Data  
--38
              ("01110", "01111", "00000", --reg1, reg2, writeReg
               '0', --writeEnable
               x"00000000",x"0000000E",x"0000000F"), -- writeData, read1Data, read2Data  
--39
              ("10000", "10001", "00000", --reg1, reg2, writeReg
               '0', --writeEnable
               x"00000000",x"00000010",x"00000011"), -- writeData, read1Data, read2Data  
--40
              ("10010", "10011", "00000", --reg1, reg2, writeReg
               '0', --writeEnable
               x"00000000",x"00000012",x"00000013"), -- writeData, read1Data, read2Data  
--41
              ("10100", "10101", "00000", --reg1, reg2, writeReg
               '0', --writeEnable
               x"00000000",x"00000014",x"00000015"), -- writeData, read1Data, read2Data  
--42
              ("10110", "10111", "00000", --reg1, reg2, writeReg
               '0', --writeEnable
               x"00000000",x"00000016",x"00000017"), -- writeData, read1Data, read2Data  
--43
              ("11000", "11001", "00000", --reg1, reg2, writeReg
               '0', --writeEnable
               x"00000000",x"00000018",x"00000019"), -- writeData, read1Data, read2Data  
--44
              ("11010", "11011", "00000", --reg1, reg2, writeReg
               '0', --writeEnable
               x"00000000",x"0000001A",x"0000001B"), -- writeData, read1Data, read2Data  
--45
              ("11100", "11101", "00000", --reg1, reg2, writeReg
               '0', --writeEnable
               x"00000000",x"0000001C",x"0000001D"), -- writeData, read1Data, read2Data  
--46
              ("11110", "11111", "00000", --reg1, reg2, writeReg
               '0', --writeEnable
               x"00000000",x"0000001E",x"0000001F"), -- writeData, read1Data, read2Data  
--47 at this point all of the registers have been tested to see if they still contain their unique value
              ("11110", "11111", "00001", --reg1, reg2, writeReg
               '1', --writeEnable
               x"00000101",x"0000001E",x"0000001F"), -- writeData, read1Data, read2Data  
--48 test reading from two registers and writing to a third
              ("00001", "00000", "00000", --reg1, reg2, writeReg
               '1', --writeEnable
               x"DEADBEEF",x"00000101",x"00000000"), -- writeData, read1Data, read2Data  
--49 verify register written to above is correct, verrify writing to zero doesnt change the value
              ("00001", "00001", "00001", --reg1, reg2, writeReg
               '1', --writeEnable
               x"DEADBEEF",x"DEADBEEF",x"DEADBEEF") -- writeData, read1Data, read2Data  
--50 verify we reg1 and reg2 can be the same
            );
    BEGIN
    wait for 100 ps;
        FOR i IN patterns'range LOOP
        testReg1 <= patterns(i).reg1;
        testReg2 <= patterns(i).reg2;
        testWriteReg <= patterns(i).writeReg;
        testWE <= patterns(i).WE;
        testWriteData <= patterns(i).writeData;
        testRead1Data <= patterns(i).read1Data;
        testRead2Data <= patterns(i).read2Data;
    wait for 10 ns;

    assert testRead1Data = patterns(i).read1Data
        report "read1Data is wrong" severity error;
    assert testRead2Data = patterns(i).read2Data
        report "read2Data is wrong" severity error;
    END LOOP;
    testKillClock <= '1';
    assert false
        report "end of test" severity note;
    wait;
    END PROCESS;
END test;
