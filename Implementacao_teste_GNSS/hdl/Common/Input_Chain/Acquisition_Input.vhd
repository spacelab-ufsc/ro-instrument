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

entity GNSS_Input is
generic(
    DDS_Width   : integer := 5;
    OUT_Width   : integer := 8
);
port (
    --<port_name> : <direction> <type>;
	MAX_INPUT_I : IN  std_logic_vector(1 downto 0); -- MAX INPUT IN PHASE SIGNAL
    MAX_INPUT_Q : IN  std_logic_vector(1 downto 0); -- MAX INPUT QUADRATURE SIGNAL
    cos_signal  : IN  std_logic_vector(DDS_Width-1 downto 0); -- MAX INPUT IN PHASE SIGNAL
    sin_signal  : IN  std_logic_vector(DDS_Width-1 downto 0); -- MAX INPUT QUADRATURE SIGNAL
    OUT_I       : OUT  std_logic_vector(OUT_Width-1 downto 0); -- OUTPUT REAL PART
    OUT_Q       : OUT  std_logic_vector(OUT_Width-1 downto 0) -- OUTPUT IMAG PART
);
end GNSS_Input;

architecture architecture_GNSS_Input of GNSS_Input is
    -- signal, component etc. declarations
    signal I1_mult, I2_mult, Q1_mult, Q2_mult :  std_logic_vector(DDS_Width downto 0);
    signal OUT_I_signal, OUT_Q_signal : std_logic_vector(OUT_Width-1 downto 0);
    
    component Multiplier_simplified is
    generic(
        data_width : integer := 12
    );
    port(
        -- 	Bit_Vector Inputs
        A :	in std_logic_vector(data_width-1 downto 0);
        B :	in std_logic_vector(1 downto 0);

        --	Bit_Vector Outputs
        S :	out std_logic_vector(data_width downto 0)
    );
    end component;
    
    component UAL is
    generic(
        data_width : integer := 64
    );
    port(	
        A:	in std_logic_vector(data_width-1 downto 0);
        B:	in std_logic_vector(data_width-1 downto 0);
        Cin:	in std_logic;

        S:	out std_logic_vector(data_width-1 downto 0);
        Cout:	out std_logic
    );
    end component;
begin
    -- architecture body
    Assert (DDS_Width < OUT_Width)
        report "Error: DDS Width is greater than FFT WIDTH."
        severity error;
    
    ---Ajuste para o multiplicador simplificado    
    MULT_IN1: Multiplier_simplified generic map (data_width => DDS_Width) port map (cos_signal,    MAX_INPUT_I, I1_mult);
    MULT_IN2: Multiplier_simplified generic map (data_width => DDS_Width) port map (sin_signal,    MAX_INPUT_I, I2_mult);
    MULT_IN3: Multiplier_simplified generic map (data_width => DDS_Width) port map (cos_signal,    MAX_INPUT_Q, Q1_mult);
    MULT_IN4: Multiplier_simplified generic map (data_width => DDS_Width) port map (sin_signal,    MAX_INPUT_Q, Q2_mult);
    
    ADDER_INPUT1: UAL generic map(data_width => DDS_Width + 1) 
        port map (I1_mult, not Q2_mult,   '1', OUT_I_signal(DDS_Width downto 0), open);
    ADDER_INPUT2: UAL generic map(data_width => DDS_Width + 1) 
        port map (I2_mult, Q1_mult,       '0', OUT_Q_signal(DDS_Width downto 0), open);
    
    OUT_I_signal(OUT_Width - 1 downto DDS_Width + 1) <= (others => OUT_I_signal(DDS_Width));
    OUT_Q_signal(OUT_Width - 1 downto DDS_Width + 1) <= (others => OUT_Q_signal(DDS_Width));
    
    OUT_I <= OUT_I_signal;
    OUT_Q <= OUT_Q_signal;
end architecture_GNSS_Input;