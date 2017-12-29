LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY DEC_4x16 IS
    PORT (input: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
          output: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
         );
END DEC_4x16;

ARCHITECTURE logic OF DEC_4x16 IS
    SIGNAL NInput: STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
--Not Input
    NInput <= NOT input after 5 ps;
--I think doing it this was should be fastest, also painful
    output(0)  <= NInput(0) AND NInput(1) AND NInput(2) AND NInput(3) AFTER 5 ps;
    output(1)  <=  Input(0) AND NInput(1) AND NInput(2) AND NInput(3) AFTER 5 ps;
    output(2)  <= NInput(0) AND  Input(1) AND NInput(2) AND NInput(3) AFTER 5 ps;
    output(3)  <=  Input(0) AND  Input(1) AND NInput(2) AND NInput(3) AFTER 5 ps;
    output(4)  <= NInput(0) AND NInput(1) AND  Input(2) AND NInput(3) AFTER 5 ps;
    output(5)  <=  Input(0) AND NInput(1) AND  Input(2) AND NInput(3) AFTER 5 ps;
    output(6)  <= NInput(0) AND  Input(1) AND  Input(2) AND NInput(3) AFTER 5 ps;
    output(7)  <=  Input(0) AND  Input(1) AND  Input(2) AND NInput(3) AFTER 5 ps;
    output(8)  <= NInput(0) AND NInput(1) AND NInput(2) AND  Input(3) AFTER 5 ps;
    output(9)  <=  Input(0) AND NInput(1) AND NInput(2) AND  Input(3) AFTER 5 ps;
    output(10) <= NInput(0) AND  Input(1) AND NInput(2) AND  Input(3) AFTER 5 ps;
    output(11) <=  Input(0) AND  Input(1) AND NInput(2) AND  Input(3) AFTER 5 ps;
    output(12) <= NInput(0) AND NInput(1) AND  Input(2) AND  Input(3) AFTER 5 ps;
    output(13) <=  Input(0) AND NInput(1) AND  Input(2) AND  Input(3) AFTER 5 ps;
    output(14) <= NInput(0) AND  Input(1) AND  Input(2) AND  Input(3) AFTER 5 ps;
    output(15) <=  Input(0) AND  Input(1) AND  Input(2) AND  Input(3) AFTER 5 ps;

END logic;

