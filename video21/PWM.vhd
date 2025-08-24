library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PWM is
    Port (
        clk     : in  std_logic;       -- Reloj del sistema
        btn0    : in  std_logic;       -- Botón posición 0°
        btn45   : in  std_logic;       -- Botón posición 45°
        btn90   : in  std_logic;       -- Botón posición 90°
        btn180  : in  std_logic;       -- Botón posición 180°
        servo   : out std_logic        -- Señal PWM hacia servo
    );
end PWM;

architecture Behavioral of PWM is

    -- Contador para generar PWM de 20 ms (50 Hz)
    signal pwm_cnt : integer := 0;
    signal pulse_width : integer := 1000; -- ancho inicial 1ms (0°)

    -- Señales debounced
    signal db_btn0, db_btn45, db_btn90, db_btn180 : std_logic := '0';

    -- Parámetros del clock (50 MHz por ejemplo)
    constant CLK_FREQ : integer := 50000000;
    constant PERIOD   : integer := 20000000; -- 20 ms en ns
    constant TICKS    : integer := CLK_FREQ / 50; -- ciclos por periodo PWM

    -- Rango del servo (en ciclos de reloj)
    constant SERVO_MIN : integer := (CLK_FREQ / 1000) * 1;   -- 1 ms
    constant SERVO_MAX : integer := (CLK_FREQ / 1000) * 2;   -- 2 ms
    constant SERVO_45  : integer := (SERVO_MIN + ((SERVO_MAX - SERVO_MIN) * 45) / 180);
    constant SERVO_90  : integer := (SERVO_MIN + ((SERVO_MAX - SERVO_MIN) * 90) / 180);
    constant SERVO_180 : integer := SERVO_MAX;

    -- Debounce
    constant DEBOUNCE_LIMIT : integer := 500000; -- ~10 ms @50MHz
    signal cnt0, cnt45, cnt90, cnt180 : integer := 0;
    signal btn0_sync, btn45_sync, btn90_sync, btn180_sync : std_logic := '0';

begin

    ----------------------------------------------------------------
    -- Debouncer process para cada botón
    ----------------------------------------------------------------
    process(clk)
    begin
        if rising_edge(clk) then
            -- Debounce btn0
            if btn0 = btn0_sync then
                if cnt0 < DEBOUNCE_LIMIT then
                    cnt0 <= cnt0 + 1;
                else
                    db_btn0 <= btn0;
                end if;
            else
                cnt0 <= 0;
            end if;
            btn0_sync <= btn0;

            -- Debounce btn45
            if btn45 = btn45_sync then
                if cnt45 < DEBOUNCE_LIMIT then
                    cnt45 <= cnt45 + 1;
                else
                    db_btn45 <= btn45;
                end if;
            else
                cnt45 <= 0;
            end if;
            btn45_sync <= btn45;

            -- Debounce btn90
            if btn90 = btn90_sync then
                if cnt90 < DEBOUNCE_LIMIT then
                    cnt90 <= cnt90 + 1;
                else
                    db_btn90 <= btn90;
                end if;
            else
                cnt90 <= 0;
            end if;
            btn90_sync <= btn90;

            -- Debounce btn180
            if btn180 = btn180_sync then
                if cnt180 < DEBOUNCE_LIMIT then
                    cnt180 <= cnt180 + 1;
                else
                    db_btn180 <= btn180;
                end if;
            else
                cnt180 <= 0;
            end if;
            btn180_sync <= btn180;
        end if;
    end process;

    ----------------------------------------------------------------
    -- Selección de posición según botón presionado
    ----------------------------------------------------------------
    process(clk)
    begin
        if rising_edge(clk) then
            if db_btn0 = '1' then
                pulse_width <= SERVO_MIN;   -- 0°
            elsif db_btn45 = '1' then
                pulse_width <= SERVO_45;    -- 45°
            elsif db_btn90 = '1' then
                pulse_width <= SERVO_90;    -- 90°
            elsif db_btn180 = '1' then
                pulse_width <= SERVO_180;   -- 180°
            end if;
        end if;
    end process;

    ----------------------------------------------------------------
    -- Generación de señal PWM para el servo
    ----------------------------------------------------------------
    process(clk)
    begin
        if rising_edge(clk) then
            if pwm_cnt >= TICKS-1 then
                pwm_cnt <= 0;
            else
                pwm_cnt <= pwm_cnt + 1;
            end if;

            if pwm_cnt < pulse_width then
                servo <= '1';
            else
                servo <= '0';
            end if;
        end if;
    end process;

end Behavioral;
