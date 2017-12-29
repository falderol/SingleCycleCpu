LIBRARY ieee;
USE ieee.std_logic_1164.all;


PACKAGE reg_type IS 
    SUBTYPE reg_address IS STD_LOGIC_VECTOR(4 DOWNTO 0);
    TYPE reg_array_4 IS ARRAY (3 DOWNTO 0) OF reg_address;
END reg_type;

