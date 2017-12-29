LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.word_type.all;

ENTITY REG_x32 IS
    PORT (writeData: IN word;
          writeEnable, clock: IN STD_LOGIC;
          readData: OUT word
         );
END REG_x32;

ARCHITECTURE logic of REG_x32 IS
    SIGNAL NReadData: word;
BEGIN
    FFloop: FOR i in 0 to 31 generate
    DFF00: ENTITY work.Dff(Behavior) PORT MAP (writeData(i), writeEnable, clock,
                                               readData(i), NReadData(i));
    END generate FFloop;
END logic;
