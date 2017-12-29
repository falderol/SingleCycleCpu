LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.reg_type.all;

ENTITY DEC_5x32 IS
    PORT (input: IN reg_address;
          enable: IN STD_LOGIC;
          output: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
         );
END DEC_5x32;

ARCHITECTURE logic OF DEC_5x32 IS
    SIGNAL L0: STD_LOGIC_VECTOR(15 DOWNTO 0);
BEGIN
    DEC00: ENTITY work.DEC_4x16(logic) PORT MAP (input(4 DOWNTO 1), L0(15 DOWNTO 0));
    
    outLoop: FOR i IN 0 to 15 generate
--To be most accurate should not input(4) on its own
        output(i*2) <= L0(i) AND enable AND NOT input(0) after 10 ps;
        output(i*2+1) <= L0(i) AND enable AND input(0) after 5 ps;
    END generate outLoop;
END logic;

