LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.word_type.all;
USE work.op_type.all;

ENTITY ALU IS
    PORT(Value1, Value2: IN word;
         Operation: IN op;
         ValueOut: OUT word;
         Overflow, Negative, Zero, CarryOut: OUT STD_LOGIC := '0');
END ALU;

ARCHITECTURE logic OF ALU IS
    SIGNAL addOut: word;
    SIGNAL addO, addSN, addUN, addZ, addC: STD_LOGIC := '0';
    SIGNAL shiftOut: word;
    SIGNAL shiftO, shiftN, shiftZ, shiftC: STD_LOGIC := '0'; 
    SIGNAL lessOut: word;
    SIGNAL lessO, lessN, lessZ, lessC: STD_LOGIC := '0';
    SIGNAL xorOut: word;
    SIGNAL xorO, xorN, xorZ, xorC: STD_LOGIC := '0';
    SIGNAL norOut: word;
    SIGNAL norO, norN, norZ, norC: STD_LOGIC := '0';
    SIGNAL nandOut: word;
    SIGNAL nandO, nandN, nandZ, nandC: STD_LOGIC := '0';
    SIGNAL compOut: word;
    SIGNAL compO, compN, compZ, compC: STD_LOGIC := '0';
    SIGNAL orOut: word;
    SIGNAL orO, orN, orZ, orC: STD_LOGIC := '0';
    SIGNAL outMuxIn: word_array;
    SIGNAL oIn, nIn, zIn, cIn: word;
    SIGNAL opExtended: STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
    SIGNAL oOut, nOut, zOut, cOut: STD_LOGIC_VECTOR (0 DOWNTO 0);
BEGIN

    opExtended(3 DOWNTO 0) <= Operation; 
--Add  0000
--AddU 0001
--Sub  0100
    addOp: ENTITY work.Add_32(logic) PORT MAP (Value1, Value2, Operation(2), addOut, addO, addSN, addZ, addC);

    outMuxIn(0) <= addOut;
    oIn(0) <= addO;
    nIn(0) <= addSN;
    zIn(0) <= addZ;
    cIn(0) <= addC;

    outMuxIn(1) <= addOut;
    oIn(1) <= addO;
    nIn(1) <= addUN;
    zIn(1) <= addZ;
    cIn(1) <= addC;

    outMuxIn(4) <= addOut;
    oIn(4) <= addO;
    nIn(4) <= addSN;
    zIn(4) <= addZ;
    cIn(4) <= addC;

--Left  0010
--Right 0011
    shiftOp: ENTITY work.barrel_shifter(logic) PORT MAP (Value1, Value2, Operation(0), shiftOut, shiftO, shiftN, shiftZ, shiftC);

    outMuxIn(2) <= shiftOut;
    oIn(2) <= shiftO;
    nIn(2) <= shiftN;
    zIn(2) <= shiftZ;
    cIn(2) <= shiftC;

    outMuxIn(3) <= shiftOut;
    oIn(3) <= shiftO;
    nIn(3) <= shiftN;
    zIn(3) <= shiftZ;
    cIn(3) <= shiftC;

--Less 0101
    lessThanOp: ENTITY work.less_than_32(logic) PORT MAP (Value1, Value2, lessOut, lessZ);
 
    outMuxIn(5) <= lessOut;
    oIn(5) <= lessO;
    nIn(5) <= lessN;
    zIn(5) <= lessZ;
    cIn(5) <= lessC;   

--XOR  1000
    xorOp: ENTITY work.XOR_32(logic) PORT MAP (Value1, Value2, xorOut, xorN, xorZ);

    outMuxIn(8) <= xorOut;
    oIn(8) <= xorO;
    nIn(8) <= xorN;
    zIn(8) <= xorZ;
    cIn(8) <= xorC;   
--NOR  1001
    norOp: ENTITY work.NOR_32(logic) PORT MAP (Value1, Value2, norOut, norN, norZ);   

    outMuxIn(9) <= norOut;
    oIn(9) <= norO;
    nIn(9) <= norN;
    zIn(9) <= norZ;
    cIn(9) <= norC; 

--NAND 1010
    nandOp: ENTITY work.NAND_32(logic) PORT MAP (Value1, Value2, nandOut, nandN, nandZ);

    outMuxIn(10) <= nandOut;
    oIn(10) <= nandO;
    nIn(10) <= nandN;
    zIn(10) <= nandZ;
    cIn(10) <= nandC; 

--COMP 1100
    compOp: ENTITY work.comp_32(logic) PORT MAP (Value1, Value2, compOut, compN, compZ);

    outMuxIn(12) <= compOut;
    oIn(12) <= compO;
    nIn(12) <= compN;
    zIn(12) <= compZ;
    cIn(12) <= compC;

--or 1011
    orOp: ENTITY work.or_32(logic) PORT MAP (Value1, Value2, orOut, orN, orZ);

    outMuxIn(11) <= orOut;
    oIn(11) <= orO;
    nIn(11) <= orN;
    zIn(11) <= orZ;
    cIn(11) <= orC;

--Output Mux
    muxOut: ENTITY work.MUX_32x32x1_vector(logic) PORT MAP (outMuxIn, opExtended, ValueOut); 
--Overflow Mux
    muxOver: ENTITY work.MUX_32x1_vector(logic) PORT MAP (oIn, opExtended, oOut);
    Overflow <= oOut(0);
--Negative Mux
    muxNegi: ENTITY work.MUX_32x1_vector(logic) PORT MAP (nIn, opExtended, nOut);
    Negative <= nOut(0);
--Zero Mux
    muxZero: ENTITY work.MUX_32x1_vector(logic) PORT MAP (zIn, opExtended, zOut);
    Zero <= zOut(0);
--Carry Mux
    muxCarr: ENTITY work.MUX_32x1_vector(logic) PORT MAP (cIn, opExtended, cOut);
    CarryOut <= cOut(0);
END logic;
--Set flags back to zero at the beginning of every round 
