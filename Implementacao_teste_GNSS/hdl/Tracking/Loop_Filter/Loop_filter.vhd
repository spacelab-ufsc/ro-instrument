library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Loop_filter is
    generic (
        WIDTH     : integer := 16;
        KP_SHIFT  : integer := 2;
        USE_P   : boolean := true;
        KI_SHIFT  : integer := 6;
        USE_I   : boolean := true;
        KD_SHIFT  : integer := 0;
        USE_D   : boolean := true
    );
	Port ( 
		clk             : in  std_logic;
		reset           : in  std_logic;
        update          : in  std_logic;
		input_error     : in  std_logic_vector(WIDTH-1 downto 0);
		filtered_out    : out std_logic_vector(WIDTH-1 downto 0)
	);
end Loop_filter;

architecture Behavioral of Loop_filter is

    signal input_d, 
            I_input,
            Not_D_signal,
            P_out,
            I_out, 
            D_out,
            D_buffer,
            I_signal,
            D_signal,
            PI_out : std_logic_vector(WIDTH-1 downto 0);


	component adder 
	generic(
		data_width : integer := WIDTH
	);
	port(	
		A:	in std_logic_vector(data_width-1 downto 0);
		B:	in std_logic_vector(data_width-1 downto 0);
		Cin:	in std_logic;

		S:	out std_logic_vector(data_width-1 downto 0);
		Cout:	out std_logic
	);
	end component;

	component shift_reg
	generic(
		data_width : integer := WIDTH
	);
	port(
		-- 	Bit Inputs
		en:	in std_logic;
		clk:	in std_logic;
		rst:	in std_logic;
		serial:	in std_logic;
		shift:	in std_logic;

		-- 	Bit_Vector Inputs
		I:	in std_logic_vector(data_width-1 downto 0);

		--	Bit_Vector Outputs
		O:	out std_logic_vector(data_width-1 downto 0)
	);
	end component;

begin

    err_d: shift_reg 
		generic map( data_width => WIDTH)
		port map (en=>update,clk=>clk,rst=>reset,serial => '0', shift  => '0', I => input_error, O => input_d);

    P_GEN : if USE_P generate
        P_out <= std_logic_vector(
                     shift_right(signed(input_d), KP_SHIFT));
    end generate;

    NO_P_GEN : if not USE_P generate
        P_out <= (others => '0');
    end generate;

    
    I_GEN : if USE_I generate
        I_input <= std_logic_vector(
                      shift_right(signed(input_d), KI_SHIFT));

        I_REG : shift_reg
            generic map (data_width => WIDTH)
            port map (
                en   => update,
                clk  => clk,
                rst  => reset,
                serial => '0',
                shift  => '0',
                I => I_out,
                O => I_signal
            );

        I_SUM : adder
            generic map (data_width => WIDTH)
            port map (
                A => I_input,
                B => I_signal,
                Cin => '0',
                S => I_out,
                Cout => open
            );
    end generate;

    NO_I_GEN : if not USE_I generate
        I_out <= (others => '0');
    end generate;

    
    D_GEN : if USE_D generate

        D_PREV : shift_reg
            generic map (data_width => WIDTH)
            port map (
                en   => update,
                clk  => clk,
                rst  => reset,
                serial => '0',
                shift  => '0',
                I => input_d,
                O => D_signal
            );
        
        Not_D_signal <= not D_signal;
        -- input_d - D_signal
        D_SUB : adder
            generic map (data_width => WIDTH)
            port map (
                A => input_d,
                B => Not_D_signal,
                Cin => '1',
                S => D_buffer,
                Cout => open
            );

        -- REGISTERED derivative (very good idea)
        D_REG : shift_reg
            generic map (data_width => WIDTH)
            port map (
                en   => update,
                clk  => clk,
                rst  => reset,
                serial => '0',
                shift  => '0',
                I => std_logic_vector(
                        shift_right(signed(D_buffer), KD_SHIFT)),
                O => D_out
            );

    end generate;

    NO_D_GEN : if not USE_D generate
        D_out <= (others => '0');
    end generate;

    
    Sum_PI : adder
            generic map(data_width => WIDTH)
            port map (A => P_out, B => I_out, Cin => '0', S => PI_out, Cout => open);
          
    Sum_PID : adder
            generic map(data_width => WIDTH)
            port map (A => PI_out, B => D_out, Cin => '0', S => filtered_out, Cout => open);
    end Behavioral;
