LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.word_type.all;
USE work.reg_type.all;

--register 0 should have a constant zero value
--Do this by assigning '0' as an initial at the dff or register level
ENTITY REGFILE_32x32 IS
    PORT (reg1, reg2, writeReg: IN reg_address;
          WE, clock: IN STD_LOGIC;
          writeData: IN word;
          read1Data, read2Data: OUT word
         );
END REGFILE_32x32;

ARCHITECTURE logic of REGFILE_32x32 IS
    SIGNAL decodedEnable: word;
    SIGNAL storedData: word_array;
    SIGNAL emptyWriteData: word := x"00000000";
    SIGNAL neverEnable: STD_LOGIC := '0';
    SIGNAL delayClock: STD_LOGIC;
BEGIN
    --delayClock <= clock AFTER 20 ps;
    delayClock <= clock; 
    --Decodes which registers should have write enabled
    DecodedWriteEnable: ENTITY work.DEC_5x32(logic) PORT MAP (writeReg, 
                                                              WE, 
                                                              decodedEnable);

    --decleration of the registers
    --register 0 always contains 0
    REG00: ENTITY work.REG_x32(logic) PORT MAP (emptyWriteData,
                                                neverEnable, delayClock,
                                                storedData(0)
                                               );
    --register 1-31 contain stored data    
    Registers: FOR i in 1 to 31 generate
    REGGEN: ENTITY work.REG_x32(logic) PORT MAP (writeData, 
                                                 decodedEnable(i), delayClock,
                                                 storedData(i)
                                                );
    END generate Registers;

    --reads data from two selected registers
    REG01: ENTITY work.MUX_32x32x1_vector(logic) PORT MAP (storedData,
                                                           reg1,
                                                           read1Data
                                                          );

    REG02: ENTITY work.MUX_32x32x1_vector(logic) PORT MAP (storedData,
                                                           reg2,
                                                           read2Data
                                                          );

END logic;
