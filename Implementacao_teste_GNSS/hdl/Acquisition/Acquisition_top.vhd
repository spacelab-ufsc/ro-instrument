--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: Acquisition_top.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::PolarFireSoC> <Die::MPFS025T> <Package::FCVG484>
-- Author: <Name>
--
--------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;

entity Acquisition_top is
port (
    CLK             : IN  std_logic; -- example
        CA_CLK          : IN std_logic;
        RST             : IN    std_logic;
        MAX_INPUT_I     : IN  std_logic_vector(1 downto 0); -- MAX INPUT IN PHASE SIGNAL
        MAX_INPUT_Q     : IN  std_logic_vector(1 downto 0); -- MAX INPUT QUADRATURE SIGNAL
        MAX_INPUT_CLK   : IN  std_logic; -- MAX INPUT CLOCK
        READ_OUT        : IN  std_logic; -- READ  OUTPUT
        READ_OUT_V      : OUT  std_logic; -- VALID OUTPUT
        OUT_I           : OUT  std_logic_vector(20 downto 0); -- OUTPUT REAL PART
        OUT_Q           : OUT  std_logic_vector(20 downto 0); -- OUTPUT IMAG PART
        SAT_state       : out std_logic;
        idle            : out std_logic
);
end Acquisition_top;
architecture architecture_Acquisition_top of Acquisition_top is
   -- signal, component etc. declarations
	signal READ_OUT_V_SIGNAL : std_logic; -- example
	signal OUT_I_SIGNAL,OUT_Q_SIGNAL : std_logic_vector(20 downto 0) ; -- example
    
    component Acquisition is
    port(
        CLK             : IN  std_logic; -- example
        CA_CLK          : IN std_logic;
        RST             : IN    std_logic;
        MAX_INPUT_I     : IN  std_logic_vector(1 downto 0); -- MAX INPUT IN PHASE SIGNAL
        MAX_INPUT_Q     : IN  std_logic_vector(1 downto 0); -- MAX INPUT QUADRATURE SIGNAL
        MAX_INPUT_CLK   : IN  std_logic; -- MAX INPUT CLOCK
        READ_OUT        : IN  std_logic; -- READ  OUTPUT
        READ_OUT_V      : OUT  std_logic; -- VALID OUTPUT
        OUT_I           : OUT  std_logic_vector(20 downto 0); -- OUTPUT REAL PART
        OUT_Q           : OUT  std_logic_vector(20 downto 0) -- OUTPUT IMAG PART
    );
    end component;
    
    component Acquisition_control is
    port(
        clk : in std_logic;
        reset : in std_logic;
        OUT_I : in std_logic_vector(20 downto 0);
        OUT_Q : in std_logic_vector(20 downto 0);
        READ_OUT_V : out std_logic;
        SAT_state : out std_logic;
        idle : out std_logic
    );
    end component;

begin
    SIGNAL_ACQUISITION : Acquisition
    port map(
        CLK           => CLK,
        CA_CLK        => CA_CLK,  
        RST           => RST,
        MAX_INPUT_I   => MAX_INPUT_I,  
        MAX_INPUT_Q   => MAX_INPUT_Q, 
        MAX_INPUT_CLK => MAX_INPUT_CLK,   
        READ_OUT      => READ_OUT,  
        READ_OUT_V    => READ_OUT_V_SIGNAL,  
        OUT_I         => OUT_I_SIGNAL,  
        OUT_Q         => OUT_Q_SIGNAL
    );
    
    CONTROL: Acquisition_control
    port map(
        clk        => CLK,
        reset      => RST,
        OUT_I      => OUT_I_SIGNAL,
        OUT_Q      => OUT_Q_SIGNAL,
        READ_OUT_V => READ_OUT_V_SIGNAL,
        SAT_state  => SAT_state,
        idle       => idle
    );
    
    OUT_I <= OUT_I_SIGNAL; 
    OUT_Q <= OUT_Q_SIGNAL;
end architecture_Acquisition_top;
