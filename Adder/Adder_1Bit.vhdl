LIBRARY ieee;
USE ieee.std_logic_1164.all;

--Time to fully stabilize is 20 ps
ENTITY Add_1 IS
    PORT (I0, I1, CIN: IN STD_LOGIC;
          SIG, COUT: out STD_LOGIC
         );
END Add_1;

ARCHITECTURE logic OF Add_1 IS
    SIGNAL S0, S1, S2: STD_LOGIC;
    SIGNAL NS0, NCIN: STD_LOGIC;
    SIGNAL C0, C1, C2: STD_LOGIC;    
BEGIN
--Nots
    NS0  <= NOT S0  after 5 ps;
    NCIN <= NOT CIN after 5 ps;
--SIG is !S0(S1 XOR CIN)+S0*!(S1 XOR CIN)
--Bottom Layer of SIG determintation
    S0 <= I0 XOR I1 after 5 ps;
--Middle Layer of SIG determination
    S1 <= NS0 AND CIN  after 5 ps;
    S2 <= S0  AND NCIN after 5 ps;
--Final Layer of SIG Determination
    SIG <= S1 OR S2 after 5 ps;
--COUT is S1*CIN + S0(S1 XOR CIN)
--Bottom Layer of COUT determination
    C0 <= I1 AND CIN after 5 ps;
    C1 <= I1 XOR CIN after 5 ps;
--Middle Layer of COUT determination
    C2 <= C1 AND I0 after 5 ps;
--Final Layer of COUT Determination
    COUT <= C0 OR C2 after 5 ps;
    
END logic;

