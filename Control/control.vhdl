LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Control IS
    PORT(Operation: IN STD_LOGIC_VECTOR(31 DOWNTO 26);
         Func: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
         Branch, MemRead, MemWrite, RegWrite, SignExtend,
         ALUSrc1: OUT STD_LOGIC;
         ALUSrc2, MemToReg, WriteRegDst, PCSrc,
         ALUOpType: OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
END Control;

ARCHITECTURE logic of Control IS

BEGIN
PROCESS
BEGIN

wait until Operation'EVENT or Func'EVENT;

ALUSrc1 <= '0';

IF (Operation = "000000") then -- r type 0x00
    Branch <= '0' after 20 ps;
    MemRead <= '0' after 20 ps;
    MemWrite <= '0' after 20 ps;
    SignExtend <= '0' after 20 ps;
    MemToReg <= "00" after 20 ps;
    WriteRegDst <= "01" after 20 ps;
    ALUOpType <= "10" after 20 ps;
    IF (Func = "000000") then -- sll 0x00
        RegWrite <= '1' after 20 ps;
        ALUSrc2 <= "10" after 20 ps;
        PCSrc <= "00" after 20 ps;
    ELSIF (Func = "000010") then -- srl 0x02
        RegWrite <= '1' after 20 ps;
        ALUSrc2 <= "10" after 20 ps;
        PCSrc <= "00" after 20 ps;
    ELSIF (Func = "001000") then -- JR 0x80
        RegWrite <= '0' after 20 ps;
        PCSrc <= "10" after 20 ps;
    ELSIF (Func = "100000") then -- Add 0x20
        RegWrite <= '1' after 20 ps;
        ALUSrc2 <= "00" after 20 ps;
        PCSrc <= "00" after 20 ps;   
    ELSIF (Func = "100001") then -- addu 0x21
        RegWrite <= '1' after 20 ps;
        ALUSrc2 <= "00" after 20 ps;
        PCSrc <= "00" after 20 ps; 
    ELSIF (Func = "100010") then -- SUB 0x22
        RegWrite <= '1' after 20 ps;
        ALUSrc2 <= "00" after 20 ps;
        PCSrc <= "00" after 20 ps; 
    ELSIF (Func = "100110") then -- XOR 0x26
        RegWrite <= '1' after 20 ps;
        ALUSrc2 <= "00" after 20 ps;
        PCSrc <= "00" after 20 ps; 
    ELSIF (Func = "100111") then -- Nor 0x27
        RegWrite <= '1' after 20 ps;
        ALUSrc2 <= "00" after 20 ps;
        PCSrc <= "00" after 20 ps; 
    ELSIF (Func = "101010") then -- SLT 0x2A
        RegWrite <= '1' after 20 ps;
        ALUSrc2 <= "00" after 20 ps;
        PCSrc <= "00" after 20 ps; 
    END IF;

ELSIF (Operation = "000010") then -- J 0x02
    Branch <= '0' after 20 ps;
    MemRead <= '0' after 20 ps;
    MemWrite <= '0' after 20 ps;
    RegWrite <= '0' after 20 ps;
    SignExtend <= '0' after 20 ps;
--    ALUSrc2 <= "00" after 20 ps;
--    MemToReg <= "00" after 20 ps;
--    WriteRegDst <= "00" after 20 ps;
    PCSrc <= "01" after 20 ps;
--    ALUOpType <= "00" after 20 ps;
ELSIF (Operation = "000011") then -- jal 0x03
    Branch <= '0' after 20 ps;
    MemRead <= '0' after 20 ps;
    MemWrite <= '0' after 20 ps;
    RegWrite <= '1' after 20 ps;
    SignExtend <= '0' after 20 ps;
--    ALUSrc2 <= "00" after 20 ps;
    MemToReg <= "10" after 20 ps;
    WriteRegDst <= "10" after 20 ps;
    PCSrc <= "01" after 20 ps;
--    ALUOpType <= "00" after 20 ps;
ELSIF (Operation = "000100") then -- beq 0x04
    Branch <= '1' after 20 ps;
    MemRead <= '0' after 20 ps;
    MemWrite <= '0' after 20 ps;
    RegWrite <= '1' after 20 ps;
    SignExtend <= '1' after 20 ps;
    ALUSrc2 <= "00" after 20 ps;
--  MemToReg <= "00" after 20 ps;
--  WriteRegDst <= "00" after 20 ps;
    PCSrc <= "00" after 20 ps;
    ALUOpType <= "01" after 20 ps;
ELSIF (Operation = "001000") then -- addi 0x08
    Branch <= '0' after 20 ps;
    MemRead <= '0' after 20 ps;
    MemWrite <= '0' after 20 ps;
    RegWrite <= '1' after 20 ps;
    SignExtend <= '1' after 20 ps;
    ALUSrc2 <= "01" after 20 ps;
    MemToReg <= "00" after 20 ps;
    WriteRegDst <= "00" after 20 ps;
    PCSrc <= "00" after 20 ps;
    ALUOpType <= "00" after 20 ps;
ELSIF (Operation = "001001") then -- addiu 0x09
    Branch <= '0' after 20 ps;
    MemRead <= '0' after 20 ps;
    MemWrite <= '0' after 20 ps;
    RegWrite <= '1' after 20 ps;
    SignExtend <= '0' after 20 ps;
    ALUSrc2 <= "01" after 20 ps;
    MemToReg <= "00" after 20 ps;
    WriteRegDst <= "00" after 20 ps;
    PCSrc <= "00" after 20 ps;
    ALUOpType <= "00" after 20 ps;
ELSIF (Operation = "001101") then -- ori 0x0D WORKING
    Branch <= '0' after 20 ps;
    MemRead <= '0' after 20 ps;
    MemWrite <= '0' after 20 ps;
    RegWrite <= '1' after 20 ps;
    SignExtend <= '0' after 20 ps;
    ALUSrc2 <= "01" after 20 ps;
    MemToReg <= "00" after 20 ps;
    WriteRegDst <= "00" after 20 ps;
    PCSrc <= "00" after 20 ps;
    ALUOpType <= "11" after 20 ps;
ELSIF (Operation = "100011") then -- LW 0x23
    Branch <= '0' after 20 ps;
    MemRead <= '1' after 20 ps;
    MemWrite <= '0' after 20 ps;
    RegWrite <= '1' after 20 ps;
    SignExtend <= '1' after 20 ps;
    ALUSrc2 <= "01" after 20 ps;
    MemToReg <= "01" after 20 ps;
    WriteRegDst <= "00" after 20 ps;
    PCSrc <= "00" after 20 ps;
    ALUOpType <= "00" after 20 ps;
ELSIF (Operation = "101011") then --SW 0x2B WORKING
    Branch <= '0' after 20 ps;
    MemRead <= '0' after 20 ps;
    MemWrite <= '1' after 20 ps;
    RegWrite <= '0' after 20 ps;
    SignExtend <= '1' after 20 ps;
    ALUSrc2 <= "01" after 20 ps;
--  MemToReg <= "01" after 20 ps;
--  WriteRegDst <= "00" after 20 ps;
    PCSrc <= "00" after 20 ps;
    ALUOpType <= "00" after 20 ps;
ELSIF (Operation = "11111") then -- HALT 0x3F

END IF;
END PROCESS;

END logic;
