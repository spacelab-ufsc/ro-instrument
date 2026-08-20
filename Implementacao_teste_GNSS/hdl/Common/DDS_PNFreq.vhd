--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: Acquisition.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::PolarFire> <Die::MPF050T> <Package::FCSG325>
-- Author: <Name>
--
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity DDS_PNFreq is
-- Port list
port(
    -- Inputs
    CLK            : in  std_logic;
    FREQ_OFFSET    : in  std_logic_vector(4 downto 0);
    NGRST          : in  std_logic;
    RSTN           : in  std_logic;
    PN_SIN         : in  std_logic;
    -- Outputs
    COSINE         : out std_logic_vector(3 downto 0);
    SINE           : out std_logic_vector(3 downto 0)
    );
end DDS_PNFreq;


architecture Behavioral of DDS_PNFreq is

    -- Internal signals
    signal sin_signal : std_logic_vector(3 downto 0);
    signal sin_neg_signal : std_logic_vector(3 downto 0);

    --- DDS component declaration
    component COREDDS_C0 is
        port(
            CLK            : in  std_logic;
            FREQ_OFFSET    : in  std_logic_vector(4 downto 0);
            FREQ_OFFSET_WE : in  std_logic;
            INIT           : in  std_logic;
            NGRST          : in  std_logic;
            RSTN           : in  std_logic;
            COSINE         : out std_logic_vector(3 downto 0);
            INIT_OVER      : out std_logic;
            SINE           : out std_logic_vector(3 downto 0)
        );
    end component;
    
    component Negative_Integer is
    generic(
        data_width : integer := 10
        );
    port (
        SIG_IN  : IN  std_logic_vector(data_width-1 downto 0); -- example
        SIG_OUT : OUT std_logic_vector(data_width-1 downto 0)  -- example
        --<other_ports>;
        );
    end component;

begin

        -- DDS e contador 
    SINE_GENERATOR: COREDDS_C0 port map (
        CLK             => CLK,
        FREQ_OFFSET     => FREQ_OFFSET,
        FREQ_OFFSET_WE  => '1',
        INIT            => '0',
        NGRST           => NGRST,
        RSTN            => RSTN,
        COSINE          => COSINE,
        INIT_OVER       => open,
        SINE            => sin_signal
    );

    sin_neg_signal <= std_logic_vector(-signed(sin_signal));
    
    --SIN_NEG: entity Negative_Integer 
    --    generic map (
    --        data_width => sin_signal'length
    --        )
    --    port map (
    --        SIG_IN  => sin_signal,
    --        SIG_OUT => sin_neg_signal
    --    );

    SINE <= sin_signal when PN_SIN = '0' else sin_neg_signal;    

end Behavioral;
