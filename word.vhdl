LIBRARY ieee;
USE ieee.std_logic_1164.all;

PACKAGE word_type IS 
    SUBTYPE word IS STD_LOGIC_VECTOR(31 DOWNTO 0);
    TYPE word_array IS ARRAY(31 DOWNTO 0) OF word;
    TYPE word_array_4 IS ARRAY(3 DOWNTO 0) OF word;
    TYPE word_array_2 IS ARRAY(1 DOWNTO 0) OF word;
    TYPE word_output IS ARRAY(natural range <>) OF word;
END word_type;
