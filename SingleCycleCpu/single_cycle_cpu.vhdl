LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.word_type.all;
USE work.reg_type.all;
USE work.op_type.all;

ENTITY CPU IS
END CPU;

ARCHITECTURE logic OF CPU IS
--Misc Signals
    SIGNAL instruct25to21: STD_LOGIC_VECTOR(25 DOWNTO 21);
    SIGNAL instruct20to16: STD_LOGIC_VECTOR(20 DOWNTO 16);
    SIGNAL instruct15to11: STD_LOGIC_VECTOR(15 DOWNTO 11);
    SIGNAL instruct10to6: STD_LOGIC_VECTOR(10 DOWNTO 6);
    SIGNAL instruct15to0: STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL signExt15to0, branchAddress: word;
    SIGNAL instruct25to0: STD_LOGIC_VECTOR(25 DOWNTO 0);
    SIGNAL signExt25to0, leftTwo25to0, PCPlus4Merge25to0: word;
    SIGNAL jumpR: word;
    SIGNAL BAplusPCplus4: word;
    SIGNAL BranchAndZero: STD_LOGIC_VECTOR(0 DOWNTO 0); --alu zero flag and branch for control and for mux above pc source mux
    --SIGNAL ext10to6: word;
--Control Signals
    SIGNAL Operation: STD_LOGIC_VECTOR(31 DOWNTO 26); -- 31 to 26 for out of instruction mem file
    SIGNAL Func: STD_LOGIC_VECTOR(5 DOWNTO 0); -- 5 to 0 for out of instruction mem file
    SIGNAL Branch, MemRead, NMemRead, MemWrite, NMemWrite, RegWrite, SignExtend, ALUSrc1: STD_LOGIC; -- 1 bit control values
    SIGNAL ALUSrc1_vector: STD_LOGIC_VECTOR(0 DOWNTO 0);
    SIGNAL ALUSrc2, MemToReg, WriteRegDst, PCSrc, ALUOpType: STD_LOGIC_VECTOR(1 DOWNTO 0); -- 2 bit control values
--ALU Control Signals
    SIGNAL ALUOperation: STD_LOGIC_VECTOR (3 DOWNTO 0);
--Clock Signals
    SIGNAL killClock: STD_LOGIC := '0';
    SIGNAL clock: STD_LOGIC;
--Register Signals
    SIGNAL regIn0, regIn1, writeReg: reg_address;
    SIGNAL regWriteData, regOut0, regOut0Wait, regOut1, regOut1Wait: word;
--Instruction Memory
    SIGNAL InstructionNCS: STD_LOGIC := '0'; --not chip select, 0 to start using 1 to stop
    SIGNAL InstructionAddr: word;
    SIGNAL InstructionData: word; --inout
    SIGNAL InstructionNWE: STD_LOGIC; --not write enable
    SIGNAL InstructionNOE: STD_LOGIC; --not output enable
--Data Memory
    SIGNAL DataNCS: STD_LOGIC := '0'; --0 to start using 1 to stop
    SIGNAL DataAddr: word; 
    SIGNAL DataData: word; --inout
    SIGNAL DataNWE: STD_LOGIC := '1'; --assignemnt for testing
    SIGNAL DataNOE: STD_LOGIC := '1'; --assignment for testing
    SIGNAL InDataData: word;
--Program Counter
    SIGNAL ProgramCounterIn, ProgramCounterOut, ProgramCounterAdd4: word;
    SIGNAL pcAddFlagOver, pcAddFlagNeg, pcAddFlagZero, pcAddFlagCOUT: STD_LOGIC;
--ALU
    SIGNAL ALUin0, ALUin1: word;
    SIGNAL ALUout: word;
    SIGNAL ALUOver, ALUNegative, ALUZero, ALUCarryOut: STD_LOGIC;
--RDMUX
    SIGNAL RDEntryArray: reg_array_4;
--Branch or not mux
    SIGNAL BONArray: word_array_2;
    SIGNAL BONOut: word;
--What goes into pc
    SIGNAL PCSourceArray: word_array_4;
--ALU0 MUX
    SIGNAL ALU0Array: word_array_2;
--ALU1 MUX
    SIGNAL ALU1Array: word_array_4;
--Data MUX
    SIGNAL DataArray: word_array_4;
--Delay Clock
    SIGNAL DelayClock: STD_LOGIC;
--    SIGNAL DelayMemWrite: STD_LOGIC;
--    SIGNAL DelayMemRead: STD_LOGIC;
BEGIN
    --Misc


ALUSrc1_vector(0) <= ALUSrc1;
    --Control
    controlBlock: ENTITY work.Control(logic) PORT MAP(Operation, Func, Branch, MemRead, MemWrite, RegWrite,
                                                      SignExtend, ALUSrc1, ALUSrc2, MemToReg, WriteRegDst, 
                                                      PCSrc, ALUOpType);

    --ALU Control
    aluControlBlock: ENTITY work.ALUControl(logic) PORT MAP(ALUOpType, Func, ALUOperation);

    --Clock
    cpuClock: ENTITY work.Clock(Behavior) PORT MAP(killClock, clock);
    DelayClock <= clock after 100 ns;
    --Register File
    registerFile: ENTITY work.REGFILE_32x32(logic) PORT MAP(regIn0, regIn1, writeReg, RegWrite, clock, 
                                                            regWriteData, regOut0, regOut1);
    --regOut0 <= regOut0Wait after 100 ps;
    --regOut1 <= regOut1Wait after 100 ps;
    --Instruction Memory
    instructionMemory: ENTITY work.sram64kx8 PORT MAP(InstructionNCS, InstructionAddr, InstructionData,
                                                      InstructionNWE, InstructionNOE);
    
    InstructionNWE <= '1'; -- Instruction should not write
    InstructionNOE <= clock; --most likely wrong
    
    
    Operation <= InstructionData(31 DOWNTO 26);
    Func <= InstructionData(5 DOWNTO 0);
    instruct25to21 <= InstructionData(25 DOWNTO 21);
    instruct20to16 <= InstructionData(20 DOWNTO 16);
    instruct15to11 <= InstructionData(15 DOWNTO 11);    
    instruct10to6 <= InstructionData(10 DOWNTO 6);    

    --Register file in
    regIn0 <= instruct25to21;
    regIn1 <= instruct20to16;

    RDEntryArray(0) <= instruct20to16;
    RDEntryArray(1) <= instruct15to11;
    RDEntryArray(2) <= "11111"; -- $R31

    RDMUX: ENTITY work.MUX_5x4x1_vector(logic) PORT MAP(RDEntryArray, WriteRegDst, writeReg); 
    
    -- NOT SURE THIS SHOULD BE HERERegWrite <= --output from out mux with inputs 20-16, 15-11, $R31, with control writeRegDst
    
    --Data memory
    dataMemory: ENTITY work.sram64kx8 PORT MAP(DataNCS, DataAddr, DataData, DataNWE, DataNOE);

    --Hail Mary
--    DelayMemWrite <= MemWrite after 100 ns;
--    DelayMemRead <= MemRead after 100 ns;
    
    PROCESS BEGIN
        wait until DelayClock'EVENT;
        IF (DelayClock ='0') then --falling edge
            DataNWE <= NMemWrite after 100 ps;
            DataNOE <= NMemRead after 100 ps;
        ELSE
            DataNWE <= '1';
            DataNOE <= '1';
        END IF;
    END PROCESS;
    --DataNWE <= DelayClock AND MemWrite after 5 ps; --this is wrong, took out not
    --DataNOE <= DelayClock AND MemRead  after 5 ps; --this is wrong, took out not
    DataNCS <= '0'; -- maybe change if halt instruction
    
    --Extention
    instruct15to0 <= InstructionData(15 DOWNTO 0);
    instruction15to0Extend: ENTITY work.Extend_16x32(behavior) PORT MAP (instruct15to0, SignExtend, signExt15to0);
    instruction15to0Shift: ENTITY work.left_two(behavior) PORT MAP (signExt15to0, branchAddress);

    instruct25to0 <= InstructionData(25 DOWNTO 0);
    instruction25to0Extend: ENTITY work.Extend_26x32(behavior) PORT MAP (instruct25to0, signExt25to0);
    instruction25to0Shift: ENTITY work.left_two(behavior) PORT MAP (signExt25to0, leftTwo25to0);
    
    programCounter: ENTITY work.ProgCount(behavior) PORT MAP (ProgramCounterIn, clock, ProgramCounterOut);
    InstructionAddr <= ProgramCounterOut;

    programCounterPlusFour: ENTITY work.Add_32(logic) PORT MAP( ProgramCounterOut, x"00000004", '0', 
                                                                ProgramCounterAdd4, pcAddFlagOver,
                                                                pcAddFlagNeg, pcAddFlagZero, pcAddFlagCout);
    --left two has bits from 27 downto 0, PC+4 supplies 31 downto 28
    jumpR(27 DOWNTO 0) <= leftTwo25to0(27 DOWNTO 0);
    jumpR(31 DOWNTO 28) <= ProgramCounterAdd4(31 DOWNTO 28);

    pcPlus4PlusBA: ENTITY work.Add_32(logic) PORT MAP( ProgramCounterAdd4, branchAddress, '0',
                                                                BAplusPCplus4, pcAddFlagOver,
                                                                pcAddFlagNeg, pcAddFlagZero, pcAddFlagCout);
    
    -- branch or not
    BranchAndZero(0) <= Branch AND ALUZero after 5 ps; -- control for mux
    BONArray(1) <= BAplusPCplus4; --fixed
    BONArray(0) <= ProgramCounterAdd4; --fixed
    BranchOrNot: ENTITY work.MUX_32x2x1_vector(logic) PORT MAP (BONArray, BranchAndZero, BONOut);
    
    --what goes into pc
    PCSourceArray(0) <= BONOut;
    PCSourceArray(1) <= regOut0;
    PCSourceArray(2) <= jumpR;
    
    PCSourceMUX: ENTITY work.MUX_32x4x1_vector(logic) PORT MAP (PCSourceArray, "00", ProgramCounterIn); --00 should be PCSrc

    --ALU IN 0
    ALU0Array(0) <= regOut0;
    ALU0Array(1) <= x"00000004";
    ALU0MUX: ENTITY work.MUX_32x2x1_vector(logic) PORT MAP (ALU0Array, ALUSrc1_vector, ALUin0); --ALUSrc1 might need to be STD_LOGIC_VECTOR(0 DOWNTO 0)

    --ALU IN 1
    ALU1Array(0) <= regOut1;
    ALU1Array(1) <= signExt15to0;
    Ext10to6: ENTITY work.Extend_5x32(behavior) PORT MAP (instruct10to6, '0', ALU1Array(2));
    ALU1Array(3) <= ProgramCounterAdd4;
    ALU1MUX: ENTITY work.MUX_32x4x1_vector(logic) PORT MAP (ALU1Array, ALUSrc2, ALUin1);
    
    --ALU
    ALU: ENTITY work.ALU(logic) PORT MAP(ALUin0, ALUin1, ALUOperation, ALUout, ALUOver, ALUNegative, ALUZero,
                                         ALUCarryOut);
    DataAddr <= ALUout;
    
    --Things to be pulses
    --ncs needs to be 0 to do anything

    NMemRead <= NOT MemRead AFTER 5 ps;
    NMemWrite <= NOT MemWrite AFTER 5 ps;

    --Data Memory Data Input

    DataArray(0) <= ALUout;
    DataArray(1) <= DataData;
    DataArray(2) <= ProgramCounterAdd4;

    DataMux: ENTITY work.MUX_32x4x1_vector(logic) PORT MAP (DataArray, MemToReg, regWriteData);

    DataData <= InDataData;
    PROCESS
    BEGIN
        wait until DelayClock'EVENT; -- formerly memwrite
        IF (MemWrite = '1' AND DelayClock = '0') then InDataData <= regOut1 AFTER 20 ps; --20 ps;
        ELSE InDataData <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" AFTER 20 ps; --20 ps; -- High Impedence
        END IF;
    END PROCESS;
    PROCESS
    BEGIN
        wait until Operation'EVENT;
        IF (Operation = "111111") then 
            killClock <= '1';
            InstructionNCS <= '1';
            DataNCS <= '1';
        END IF; 
    END PROCESS;    


END logic;
