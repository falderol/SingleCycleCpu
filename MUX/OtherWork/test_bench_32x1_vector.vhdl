LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY test_bench_32x1_vector IS
END test_bench_32x1_vector;

ARCHITECTURE test OF test_bench_32x1_vector IS
    SIGNAL testI: STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL testS: STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL testOUT: STD_LOGIC_VECTOR(0 DOWNTO 0);

BEGIN
    test32: ENTITY work.MUX_32x1_vector(logic) PORT MAP ( testI, testS, testOUT );
    PROCESS
        TYPE pattern_type IS RECORD
            I: STD_LOGIC_VECTOR(31 DOWNTO 0);
            S: STD_LOGIC_VECTOR(4 DOWNTO 0);
            o: STD_LOGIC_VECTOR(0 DOWNTO 0);
        END RECORD;

        TYPE pattern_array IS ARRAY (NATURAL RANGE <>) OF pattern_type;
        CONSTANT patterns: pattern_array :=
-- All 1's I00, All 0's I31
            ( ("00000000000000000000000000000000","00000","0"),
              ("00000000000000000000000000000001","00000","1"),
              ("00000000000000000000000000000010","00001","1"),
              ("00000000000000000000000000000100","00010","1"),
              ("00000000000000000000000000010000","00100","1"),
              ("00000000000000000000000001000000","00110","1"),
              ("00000000000000000000000100000000","01000","1"),
              ("00000000000000000000100000000000","01011","1"),
              ("00000000000000010000000000000000","10000","1"),
              ("00000100000000000000000000000000","11010","1"),
              ("10000000000000000000000000000000","11111","1")
            );
    BEGIN
        FOR i IN patterns'range LOOP
            testI(0) <= patterns(i).I(0);
            testI(1) <= patterns(i).I(1);
            testI(2) <= patterns(i).I(2);
            testI(3) <= patterns(i).I(3);
            testI(4) <= patterns(i).I(4);
            testI(5) <= patterns(i).I(5);
            testI(6) <= patterns(i).I(6);
            testI(7) <= patterns(i).I(7);
            testI(8) <= patterns(i).I(8);
            testI(9) <= patterns(i).I(9);
            testI(10) <= patterns(i).I(10);
            testI(11) <= patterns(i).I(11);
            testI(12) <= patterns(i).I(12);
            testI(13) <= patterns(i).I(13);
            testI(14) <= patterns(i).I(14);
            testI(15) <= patterns(i).I(15);
            testI(16) <= patterns(i).I(16);
            testI(17) <= patterns(i).I(17);
            testI(18) <= patterns(i).I(18);
            testI(19) <= patterns(i).I(19);
            testI(20) <= patterns(i).I(20);
            testI(21) <= patterns(i).I(21);
            testI(22) <= patterns(i).I(22);
            testI(23) <= patterns(i).I(23);
            testI(24) <= patterns(i).I(24);
            testI(25) <= patterns(i).I(25);
            testI(26) <= patterns(i).I(26);
            testI(27) <= patterns(i).I(27);
            testI(28) <= patterns(i).I(28);
            testI(29) <= patterns(i).I(29);
            testI(30) <= patterns(i).I(30);
            testI(31) <= patterns(i).I(31);
            testS(0) <= patterns(i).S(0);
            testS(1) <= patterns(i).S(1);
            testS(2) <= patterns(i).S(2);
            testS(3) <= patterns(i).S(3);
            testS(4) <= patterns(i).S(4);

            wait for 1 ms;

            assert testOUT(0) = patterns(i).o(0)
                report "bad output" severity error;
        END LOOP;

        assert false
            report "end of test" severity note;
        wait;
    END PROCESS;
END test;
