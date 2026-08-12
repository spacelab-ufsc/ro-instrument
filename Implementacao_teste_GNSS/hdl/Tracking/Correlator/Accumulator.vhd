--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: Multiply_Accumulate.vhd
--
-- Description:
--  Multiply–Accumulate with dump-and-clear logic for coherent integration.
--  Suitable for GNSS correlators (I/Q accumulation).
--
-- Targeted device: PolarFireSoC MPFS025T
-- Author: <Name>
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Accumulator is
    generic (
        input_width  : integer := 64;
        output_width : integer := 64
    );
    port (
        clk     : in  std_logic;
        rst     : in  std_logic;
        en      : in  std_logic;
        dump    : in  std_logic;

        data_in : in  std_logic_vector(input_width-1 downto 0);
        result  : out std_logic_vector(output_width-1 downto 0)
    );
end entity Accumulator;

architecture architecture_Accumulate of Accumulator is

    --------------------------------------------------------------------
    -- Internal signals
    --------------------------------------------------------------------
    signal acc_reg      : std_logic_vector(output_width-1 downto 0);
    signal add_result   : std_logic_vector(output_width-1 downto 0);
    signal add_input    : std_logic_vector(output_width-1 downto 0);
    signal reg_input    : std_logic_vector(output_width-1 downto 0);

    --------------------------------------------------------------------
    -- Components
    --------------------------------------------------------------------
    component shift_reg is
        generic (
            data_width : integer := 64
        );
        port (
            en     : in  std_logic;
            clk    : in  std_logic;
            rst    : in  std_logic;
            serial : in  std_logic;
            shift  : in  std_logic;
            I      : in  std_logic_vector(data_width-1 downto 0);
            O      : out std_logic_vector(data_width-1 downto 0)
        );
    end component;

    component UAL is
        generic (
            data_width : integer := 64
        );
        port (
            A    : in  std_logic_vector(data_width-1 downto 0);
            B    : in  std_logic_vector(data_width-1 downto 0);
            Cin  : in  std_logic;
            S    : out std_logic_vector(data_width-1 downto 0);
            Cout : out std_logic
        );
    end component;

begin

    --------------------------------------------------------------------
    -- Sign extension of input to accumulator width
    --------------------------------------------------------------------
    add_input <= (output_width-1 downto input_width => data_in(input_width-1)) &
                 data_in
                 when en = '1' else
                 (others => '0');

    --------------------------------------------------------------------
    -- Adder (accumulator + input)
    --------------------------------------------------------------------
    UAL_inst : UAL
        generic map (
            data_width => output_width
        )
        port map (
            A    => acc_reg,
            B    => add_input,
            Cin  => '0',
            S    => add_result,
            Cout => open
        );

    --------------------------------------------------------------------
    -- Dump-and-clear logic
    -- dump = 1 ? accumulator cleared after result is observed
    --------------------------------------------------------------------
    reg_input <= (others => '0') when dump = '1' else
                 add_result;

    --------------------------------------------------------------------
    -- Accumulator register
    --------------------------------------------------------------------
    SHIFT_REG_inst : shift_reg
        generic map (
            data_width => output_width
        )
        port map (
            clk    => clk,
            rst    => rst,
            en     => '1',       -- always clocked
            serial => '0',
            shift  => '0',
            I      => reg_input,
            O      => acc_reg
        );

    --------------------------------------------------------------------
    -- Output assignment
    -- Result is valid on dump cycle
    --------------------------------------------------------------------
    result <= acc_reg;

end architecture architecture_Accumulate;
