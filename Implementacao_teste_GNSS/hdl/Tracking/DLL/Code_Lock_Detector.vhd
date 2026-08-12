--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: Code_Lock_Detector.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::PolarFireSoC> <Die::MPFS025T> <Package::FCSG325>
-- Author: <Name>
--
--------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;

entity Code_Lock_Detector is
generic (
    DATA_WIDTH : integer := 32;
    CNT_WIDTH  : integer := 6
);
port (
    clk        : in  std_logic;
    rst        : in  std_logic;
    chip_en    : in  std_logic;

    err_in     : in  std_logic_vector(DATA_WIDTH-1 downto 0);

    lock_th    : in  std_logic_vector(DATA_WIDTH-1 downto 0);
    unlock_th  : in  std_logic_vector(DATA_WIDTH-1 downto 0);

    code_lock  : out std_logic
);
end Code_Lock_Detector;

architecture architecture_Code_Lock_Detector of Code_Lock_Detector is
    type lock_array_t is array (0 to 1) of std_logic_vector(CNT_WIDTH-1 downto 0);
    type lock_bit_array_t   is array (0 to 1) of std_logic;

   -- signal, component etc. declarations
    signal err_abs       : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal err_neg       : std_logic_vector(DATA_WIDTH-1 downto 0);

    signal lock_hit     : lock_bit_array_t;
    signal lock_init    : lock_bit_array_t;
    signal lock_sat     : lock_bit_array_t;
    signal lock_cnt     : lock_array_t;
    
begin
   -- architecture body
   
    SIN_NEG: entity work.Negative_Integer       generic map (data_width => DATA_WIDTH)
            port map (
                SIG_IN  => err_in,
                SIG_OUT => err_neg 
            );
            
    err_abs <= err_in when 
    err_in(DATA_WIDTH-1) = '0' else err_neg;
   
    LOCK_UNLOCK_LOOP: FOR i in 0 to 1 generate
    
    lock_hit(i)   <=
        '1' when (i = 0 and err_abs < lock_th) or
                 (i = 1 and err_abs > unlock_th)
        else '0'; 
    
    lock_init(i)   <= rst or not lock_hit(i);
    
    LOCK_COUNTER : entity work.contador
        generic map (data_width => CNT_WIDTH)
        port map (
            clk   => chip_en,
            init  => lock_init(i),
            count => lock_cnt(i)
        );
    ------------------------------------------------------------------
    -- Saturation detection (counter == all 1s)
    ------------------------------------------------------------------
    lock_sat(i) <= and(lock_cnt(i));
    
    end generate;
   ------------------------------------------------------------------
    -- SR Flip-Flop: final lock decision
    ------------------------------------------------------------------
    LOCK_STATE : entity work.SR_Flip_Flop
        port map (
            clk => clk,
            rst => rst,
            S   => lock_sat(0),
            R   => lock_sat(1),
            Q   => code_lock
        );

end architecture_Code_Lock_Detector;
