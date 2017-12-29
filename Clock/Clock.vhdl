LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Clock IS
    PORT (killClock: IN STD_LOGIC; -- kills the clock is set to 1
          clock: OUT STD_LOGIC); -- goes from 1 to 0 with a period of 1 nS
END Clock;

ARCHITECTURE Behavior OF Clock IS
    SIGNAL Tick: STD_LOGIC := '0';
BEGIN
    Tick <= NOT Tick after 500 nS when killClock /= '1' else '0'; --half clock cycle
    Clock <= Tick;
END Behavior;
    
