--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: Acquisition_Detection.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::PolarFireSoC> <Die::MPFS025TL> <Package::FCVG484>
-- Author: <Name>
--
--------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Acquisition_APB_Wrapper is
    port (
        -- APB clock and reset
        PCLK    : in std_logic;
        PRESETN : in std_logic;

        -- Acquisition_V3 outputs
        OUT_DATA_READY  : in std_logic;
        ABS_OUT_DATA    : in std_logic_vector(31 downto 0);
        F_Doppler_DATA  : in std_logic_vector(4 downto 0);
        SAT_ID_DATA_O   : in std_logic_vector(4 downto 0);
        CODE_DELAY_DATA : in std_logic_vector(15 downto 0);

        -- APB3 slave interface
        PSEL    : in std_logic;
        PENABLE : in std_logic;
        PWRITE  : in std_logic;
        PADDR   : in std_logic_vector(31 downto 0);
        PWDATA  : in std_logic_vector(31 downto 0);
        PRDATA  : out std_logic_vector(31 downto 0);
        PREADY  : out std_logic;
        PSLVERR : out std_logic;

        -- Optional interrupt
        IRQ : out std_logic
    );
end entity;

architecture RTL of Acquisition_APB_Wrapper is

    signal capture_en   : std_logic;
    signal rst_high     : std_logic;
    signal new_result   : std_logic;
    signal data_ready   : std_logic;
    signal overflow     : std_logic;
    signal ready_d      : std_logic;
    
    signal abs_reg      : std_logic_vector(31 downto 0);
    signal doppler_reg  : std_logic_vector(4 downto 0);
    signal sat_reg      : std_logic_vector(4 downto 0);
    signal delay_reg    : std_logic_vector(15 downto 0);
    
    signal apb_write    : std_logic;
    signal ack_write    : std_logic;
    
    component reg_gen
    generic(
        reg_width : integer := 16
    );
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        en  : in  std_logic;
        D   : in  std_logic_vector(reg_width-1 downto 0);
        Q   : out std_logic_vector(reg_width-1 downto 0)
    );
    end component;

begin

    -- APB access phase
    apb_write <= PSEL and PENABLE and PWRITE;

    -- ACK at offset 0x14
    ack_write <= '1' when 
            apb_write = '1'
            and PADDR(7 downto 0) = x"14"
            and PWDATA(0) = '1'
            else '0';
            
    rst_high    <= not PRESETN;
    new_result  <= OUT_DATA_READY and not ready_d;
    capture_en  <= new_result and 
                (not data_ready or ack_write);

    U_ABS_REG : reg_gen generic map (reg_width => 32)
        port map (  clk => PCLK, rst => rst_high, 
                    en  => capture_en, D   => ABS_OUT_DATA, 
                    Q   => abs_reg);

    U_DOPPLER_REG : reg_gen generic map (reg_width => 5)
        port map (  clk => PCLK, rst => rst_high,
                    en  => capture_en, D   => F_Doppler_DATA,
                    Q   => doppler_reg);

    U_SAT_REG : reg_gen generic map (reg_width => 5)
        port map (  clk => PCLK, rst => rst_high,
                    en  => capture_en, D   => SAT_ID_DATA_O,
                    Q   => sat_reg);

    U_DELAY_REG : reg_gen generic map (reg_width => 16)
        port map (  clk => PCLK, rst => rst_high,
                    en  => capture_en, D   => CODE_DELAY_DATA,
                    Q   => delay_reg);
            
    -- Capture acquisition results
    process(PCLK, PRESETN)
    begin
        if PRESETN = '0' then
            data_ready <= '0';
            overflow <= '0';
            ready_d <= '0';
        elsif rising_edge(PCLK) then
            ready_d <= OUT_DATA_READY;
            if ack_write = '1' then
                data_ready <= '0';
                overflow <= '0';
            end if;
            -- Rising-edge detection
            if OUT_DATA_READY = '1'
               and ready_d = '0' then
                if data_ready = '0'
                   or ack_write = '1' then
                    data_ready <= '1';
                else
                    overflow <= '1';
                end if;
            end if;
        end if;
    end process;

    -- APB read multiplexer
    process(all)
    begin
        PRDATA <= (others => '0');

        if PSEL = '1' then

            case PADDR(7 downto 0) is

                when x"00" =>
                    PRDATA(0) <= data_ready;
                    PRDATA(1) <= overflow;

                when x"04" =>
                    PRDATA <= abs_reg;

                when x"08" =>
                    PRDATA(4 downto 0)
                        <= doppler_reg;

                when x"0C" =>
                    PRDATA(4 downto 0)
                        <= sat_reg;

                when x"10" =>
                    PRDATA(15 downto 0)
                        <= delay_reg;

                when others =>
                    null;

            end case;

        end if;
    end process;

    -- Zero-wait-state APB slave
    PREADY <= '1';
    PSLVERR <= '0';

    IRQ <= data_ready;

end architecture;
