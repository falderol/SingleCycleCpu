LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY MUX_2x1 IS
    PORT (I0, I1, S0: IN STD_LOGIC;
          output: OUT STD_LOGIC);
END MUX_2x1;

--Maximum of 4 terms and one type per statement.
ARCHITECTURE logic OF MUX_2x1 IS
    SIGNAL NS0, O0, O1: STD_LOGIC;
BEGIN
--Not-ed selection signals
    NS0 <= NOT S0 AFTER 5 ps;
--Select Correct Signal
    O0 <= NS0 AND I0 AFTER 5 pS;
    O1 <= S0  AND I1 AFTER 5 pS;
--Or signals together
    output <= O0 OR O1 AFTER 5 pS;
END logic;
