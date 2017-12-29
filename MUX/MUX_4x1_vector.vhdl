LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY MUX_4x1_vector IS
    PORT (I: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
          S: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
          output: OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
         );
END MUX_4x1_vector;

--Maximum of 4 terms and one type per statement.
--00 will select I3, 01 selects I2, 10 selects I1, 11 selects I0
ARCHITECTURE logic OF MUX_4x1_vector IS
    SIGNAL NS: STD_LOGIC_VECTOR(1 DOWNTO 0); 
    SIGNAL  O: STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
--Not-ed selection signals
    NS(0) <= NOT S(0) AFTER 5 ps;
    NS(1) <= NOT S(1) AFTER 5 ps;
--Select Correct Signal
    O(0) <= NS(0) AND NS(1) AND I(0) AFTER 5 pS;
    O(1) <=  S(0) AND NS(1) AND I(1) AFTER 5 pS;
    O(2) <= NS(0) AND  S(1) AND I(2) AFTER 5 pS;
    O(3) <=  S(0) AND  S(1) AND I(3) AFTER 5 pS;
--Or signals together
    output(0) <= O(0) OR O(1) OR O(2) OR O(3) AFTER 5 pS;
END logic;
