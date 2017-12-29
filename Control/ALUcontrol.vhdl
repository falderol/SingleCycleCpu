LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY ALUControl IS
    PORT(OpType: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
         Func: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
         Operation: OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
        );
END ALUControl;

ARCHITECTURE logic of ALUControl IS

BEGIN
PROCESS
BEGIN

wait until OpType'EVENT or Func'EVENT;

IF (OpType = "00") then Operation <= "0000" after 20 ps; --  ADDITION
ELSIF (OpType = "01") then Operation <= "0100" after 20 ps; -- subtraction
ELSIF (OpType = "10") then 
    IF (Func = "001000") then Operation <= "0000" after 20 ps; -- JR
    ELSIF (Func = "100000") then Operation <= "0000" after 20 ps; -- ADD
    ELSIF (Func = "100111") then Operation <= "1001" after 20 ps; --27 NOR
    ELSIF (Func = "101010") then Operation <= "0101" after 20 ps; -- SLT 0101
    ELSIF (Func = "000000") then Operation <= "0010" after 20 ps; --00 SLL
    ELSIF (Func = "000010") then Operation <= "0011" after 20 ps; --02 SRL
    ELSIF (Func = "100010") then Operation <= "0100" after 20 ps; -- SUB
    ELSIF (Func = "100001") then Operation <= "0001" after 20 ps; -- ADDU
    ELSIF (Func = "100110") then Operation <= "1000" after 20 ps; --26  XOR 1000
    END IF;
ELSIF (OpType = "11") then Operation <= "1011" after 20 ps; --LOGICAL OR
END IF;

END PROCESS;
END logic;
