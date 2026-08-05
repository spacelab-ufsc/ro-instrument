----------------------------------------------------------------------
-- Created by Microsemi SmartDesign Tue Jun  9 13:43:35 2026
-- Testbench Template
-- This is a basic testbench that instantiates your design with basic 
-- clock and reset pins connected.  If your design has special
-- clock/reset or testbench driver requirements then you should 
-- copy this file and modify it. 
----------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: Testbench_Complex_multiplier.vhd
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


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Testbench_Complex_multiplier is
end Testbench_Complex_multiplier;

architecture behavioral of Testbench_Complex_multiplier is

    constant SYSCLK_PERIOD : time := 6.25 ns; -- 160MHZ

    signal SYSCLK : std_logic := '1';
    signal NSYSRESET, en : std_logic := '1';
    signal a_real, a_imag, b_real, b_imag : std_logic_vector(7 downto 0);
    signal p_real, p_imag : std_logic_vector(15 downto 0);
    signal overflow : std_logic;
    
    component Complex_multiplier
        -- ports
        port( 
            -- Inputs
            clk : in std_logic;
            en : in std_logic;
            rst : in std_logic;
            a_real : in std_logic_vector(7 downto 0);
            a_imag : in std_logic_vector(7 downto 0);
            b_real : in std_logic_vector(7 downto 0);
            b_imag : in std_logic_vector(7 downto 0);

            -- Outputs
            p_real : out std_logic_vector(15 downto 0);
            p_imag : out std_logic_vector(15 downto 0);
            overflow : out std_logic

            -- Inouts

        );
    end component;

begin

stimulus_process: process
    begin
        -- --------------------------------------------------------
        -- TESTE 1: Inicialização e Reset
        -- --------------------------------------------------------
        report "--- Iniciando Teste 1: Reset ---";
        en <= '0';
        a_real <= (others => '0');
        a_imag <= (others => '0');
        b_real <= (others => '0');
        b_imag <= (others => '0');

        -- Mantendo o seu NSYSRESET
        NSYSRESET <= '1'; 
        wait for (SYSCLK_PERIOD * 10);
        
        -- Libera o reset e ativa o multiplicador
        NSYSRESET <= '0'; 
        en <= '1';
        wait for (SYSCLK_PERIOD * 2);

        -- --------------------------------------------------------
        -- TESTE 2: Multiplicação Normal (Sem Overflow)
        -- A = 2 + 3j | B = 4 + 5j
        -- --------------------------------------------------------
        report "--- Iniciando Teste 2: Multiplicacao Normal ---";
        -- Convertendo inteiro decimal para signed e depois para std_logic_vector
        a_real <= std_logic_vector(to_signed(2, 8));
        a_imag <= std_logic_vector(to_signed(3, 8));
        b_real <= std_logic_vector(to_signed(4, 8));
        b_imag <= std_logic_vector(to_signed(5, 8));
        
        -- Espera alguns ciclos de clock para propagar pelos registradores
        wait for (SYSCLK_PERIOD * 2);

        -- --------------------------------------------------------
        -- TESTE 3: Multiplicação com Números Negativos
        -- A = -5 - 2j | B = 3 - 4j
        -- --------------------------------------------------------
        report "--- Iniciando Teste 3: Multiplicacao Negativa ---";
        a_real <= std_logic_vector(to_signed(-5, 8));
        a_imag <= std_logic_vector(to_signed(-2, 8));
        b_real <= std_logic_vector(to_signed(3, 8));
        b_imag <= std_logic_vector(to_signed(-4, 8));
        wait for (SYSCLK_PERIOD * 2);

        -- --------------------------------------------------------
        -- TESTE 4: Forçando Overflow na soma interna (a + ai)
        -- A = 100 + 100j | B = 1 + 2j
        -- --------------------------------------------------------
        report "--- Iniciando Teste 4: Overflow na soma a+ai ---";
        a_real <= std_logic_vector(to_signed(100, 8));
        a_imag <= std_logic_vector(to_signed(100, 8));
        b_real <= std_logic_vector(to_signed(1, 8));
        b_imag <= std_logic_vector(to_signed(2, 8));
        wait for (SYSCLK_PERIOD * 4);

        -- Fim da simulação
        report "--- Fim de todos os testes! ---";
        
        -- O comando wait vazio trava o processo aqui para sempre, 
        -- evitando que os testes rodem em loop infinito.
        wait; 
    end process;

    -- Clock Driver
    SYSCLK <= not SYSCLK after (SYSCLK_PERIOD / 2.0 );

    -- Instantiate Unit Under Test:  Complex_multiplier
    Complex_multiplier_0 : Complex_multiplier
        -- port map
        port map( 
            -- Inputs
            clk => SYSCLK,
            en => en,
            rst => NSYSRESET,
            a_real => a_real,
            a_imag => a_imag,
            b_real => b_real,
            b_imag => b_imag,

            -- Outputs
            p_real => p_real,
            p_imag => p_imag,
            overflow =>  overflow

            -- Inouts

        );

end behavioral;

