LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY MUX_4x1 IS
    PORT (I0, I1, I2, I3, S0, S1: IN STD_LOGIC;
          output: OUT STD_LOGIC);
END MUX_4x1;

--Maximum of 4 terms and one type per statement.
--00 will select I3, 01 selects I2, 10 selects I1, 11 selects I0
ARCHITECTURE logic OF MUX_4x1 IS
    SIGNAL NS0, NS1, O0, O1, O2, O3: STD_LOGIC;
BEGIN
--Not-ed selection signals
    NS0 <= NOT S0 AFTER 5 ps;
    NS1 <= NOT S1 AFTER 5 ps;
--Select Correct Signal
    O0 <= NS0 AND NS1 AND I0 AFTER 5 pS;
    O1 <= NS0 AND S1  AND I1 AFTER 5 pS;
    O2 <= S0  AND NS1 AND I2 AFTER 5 pS;
    O3 <= S0  AND S1  AND I3 AFTER 5 pS;
--Or signals together
    output <= O0 OR O1 OR O2 OR O3 AFTER 5 pS;
END logic;

