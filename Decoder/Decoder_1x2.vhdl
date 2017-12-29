LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY DEC_1x2 IS
    PORT (input: IN STD_LOGIC;
          output: OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
         );
END DEC_1x2;

ARCHITECTURE logic OF DEC_1x2 IS
    SIGNAL NInput: STD_LOGIC;
BEGIN
--Not Input
    NInput <= NOT input after 5 ps;
--First is Not-ed, Second is signal
    output(0) <= NInput;
    output(1) <= input;

END logic;
