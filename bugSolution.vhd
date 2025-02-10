library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity example is
  port (
    clk : in std_logic;
    reset : in std_logic;
    data_a : in std_logic_vector(7 downto 0);
    data_b : in std_logic_vector(7 downto 0);
    shared_signal : out std_logic_vector(7 downto 0)
  );
end entity;

architecture behavioral of example is
  signal mutex : std_logic := '0';
begin
  process (clk, reset)
  begin
    if reset = '1' then
      shared_signal <= (others => '0');
      mutex <= '0';
    elsif rising_edge(clk) then
      if mutex = '0' then
        mutex <= '1';
        shared_signal <= data_a;
        mutex <= '0';
      end if;
    end if;
  end process;

  process (clk, reset)
  begin
    if reset = '1' then
      -- No action required
    elsif rising_edge(clk) then
      if mutex = '0' then
        mutex <= '1';
        shared_signal <= data_b;
        mutex <= '0';
      end if;
    end if;
  end process;
end architecture;