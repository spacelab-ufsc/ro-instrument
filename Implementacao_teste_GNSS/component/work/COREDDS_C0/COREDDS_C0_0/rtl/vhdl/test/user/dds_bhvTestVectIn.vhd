-- CoreDDS Input Test Vectors.
-- - When PH_INC_MODE==1 use the FREQ_OFFSET and FREQ_OFFSET_WE signals
-- - When PH_OFFSET_MODE==2 use the PH_OFFSET and PH_OFFSET_WE signals
-- Test run length = 510

LIBRARY IEEE; 
  USE IEEE.std_logic_1164.all; 

ENTITY dds_bhvTestVectIn IS
  GENERIC ( PH_OFFSET_BITS    : INTEGER := 5;
            FREQ_OFFSET_BITS  : INTEGER := 3   );
  PORT    ( freq_offset_we, ph_offset_we : OUT STD_LOGIC;
            sample_num  :  IN INTEGER;
            freq_offset : OUT STD_LOGIC_VECTOR(FREQ_OFFSET_BITS-1 DOWNTO 0);
            ph_offset   : OUT STD_LOGIC_VECTOR(PH_OFFSET_BITS-1 DOWNTO 0)  );
END ENTITY dds_bhvTestVectIn;

ARCHITECTURE rtl of dds_bhvTestVectIn IS
  BEGIN
    PROCESS (sample_num)
      BEGIN
        CASE sample_num IS
          WHEN   0 => freq_offset <= "00000";
                      freq_offset_we <= '1';
                      ph_offset <= "000";
                      ph_offset_we <= '1';
          WHEN   1 => freq_offset <= "00000";
                      freq_offset_we <= '1';
                      ph_offset <= "000";
                      ph_offset_we <= '1';
          WHEN OTHERS =>  freq_offset_we <= '0';
                          ph_offset_we   <= '0';
      END CASE; 
    END PROCESS; 

END ARCHITECTURE rtl; 



