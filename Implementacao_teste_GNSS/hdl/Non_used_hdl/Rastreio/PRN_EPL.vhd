library IEEE;
use IEEE.STD_LOGIC_1164.ALL;   
use ieee.std_logic_arith.all;

entity PRN_Early_Prompt_Late is
port ( 
    clk           : in  std_logic;
    reset         : in  std_logic;

    -- Chip timing from external counter / NCO
    chip_en_1x    : in  std_logic;  -- 1.023 MHz
    chip_en_2x    : in  std_logic;  -- 2.046 MHz (half-chip)

    early_code    : out std_logic;
    prompt_code   : out std_logic;
    late_code     : out std_logic;

    valid_out     : out std_logic;
    SAT           : in integer range 0 to 31
);
end PRN_Early_Prompt_Late;


architecture Behavioral of PRN_Early_Prompt_Late is
    signal ca_bit       : std_logic;
    type shift_array_t is array (0 to 2) of std_logic;
    signal shift_reg : shift_array_t;
    
	component Flip_Flop_D_en is
    port(	
        D:	in std_logic;
        rst:	in std_logic;
        set:    in std_logic;
        clk:	in std_logic;
        en:     in std_logic;
        Q:	out std_logic
    );
	end component;
    
    component L1_CA_generator is
	Port (
        clk : in std_logic;
        rst	: in std_logic;		
        PRN : out std_logic;			
        ENABLE : in std_logic;
        valid_out : out std_logic;
        epoch : out std_logic;
        epoch_advce : out std_logic;
        SAT : in integer range 0 to 31 -- 32 GPS
		);
    end component;
	
begin

    ------------------------------------------------------------------
    -- CA generator (1.023 MHz logical advance)
    ------------------------------------------------------------------
    ca_gen_inst : L1_CA_generator        
    port map (
        clk         => clk,
        rst         => reset,
        PRN         => ca_bit,
        ENABLE      => chip_en_1x,
        valid_out   => valid_out,
        epoch       => open,
        epoch_advce => open,
        SAT         => SAT
    );

    ------------------------------------------------------------------
    -- Early / Prompt / Late shift chain
    ------------------------------------------------------------------
    gen_shift : for i in 0 to 2 generate

        -- First stage takes CA bit
        gen_first : if i = 0 generate
            FF0 : entity work.Flip_Flop_D_en
            port map (
                D   => ca_bit,
                rst => reset,
                set => '1',
                clk => clk,
                en  => chip_en_2x,
                Q   => shift_reg(i)
            );
        end generate;

        -- Remaining stages shift
        gen_rest : if i > 0 generate
            FFN : entity work.Flip_Flop_D_en
            port map (
                D   => shift_reg(i-1),
                rst => reset,
                set => '1',
                clk => clk,
                en  => chip_en_2x,
                Q   => shift_reg(i)
            );
        end generate;

    end generate;

    early_code  <= shift_reg(0);
    prompt_code <= shift_reg(1);
    late_code   <= shift_reg(2);

end Behavioral;
