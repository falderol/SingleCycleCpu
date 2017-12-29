LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY MUX_2x1_vector IS
    PORT (Inp: IN STD_LOGIC_VECTOR(1 DOWNTO 0); 
          Sig: IN STD_LOGIC_VECTOR(0 DOWNTO 0);
          output: OUT STD_LOGIC_VECTOR(0 DOWNTO 0));
END MUX_2x1_vector;

--Maximum of 4 terms and one type per statement.
ARCHITECTURE logic OF MUX_2x1_vector IS
    SIGNAL NS: STD_LOGIC_VECTOR(0 DOWNTO 0); 
    SIGNAL  O: STD_LOGIC_VECTOR(1 DOWNTO 0);
           
BEGIN
--Not-ed selection signals
    NS(0) <= NOT Sig(0) AFTER 5 ps;
--Select Correct Signal
    O(0) <=  NS(0) AND Inp(0) AFTER 5 pS;
    O(1) <= Sig(0) AND Inp(1) AFTER 5 pS;
--Or signals together
    output(0) <= O(0) OR O(1) AFTER 5 pS;
END logic;
