library vunit_lib;
context vunit_lib.vunit_context;

library ieee;
use ieee.std_logic_1164.all;

entity tb_split is
  generic (
    runner_cfg : runner_cfg_t := runner_cfg_default);
end tb_split;

architecture tb of tb_split is
  signal vector:   std_logic_vector (21 downto 6) := x"1234";
  signal left_part:   std_logic_vector (18 downto 13);
  signal right_part:   std_logic_vector (2 to 11);

  procedure split (
    signal vector  : in  std_logic_vector;
    signal between : out std_logic_vector;
    signal \and\    : out std_logic_vector) is
    variable vector_i : std_logic_vector(vector'length - 1 downto 0) := vector;
  begin
    assert vector'length = between'length + \and\'length report "Vector lengths don't add up";
    between <= vector_i(vector_i'left downto vector_i'left - between'length + 1);
    \and\ <= vector_i(\and\'length - 1 downto 0);
  end procedure split;
begin
  test_runner : process
  begin
    test_runner_setup(runner, runner_cfg);

    while test_suite loop
      if run("Test splitting the signal") then
        split(vector, between => left_part, \and\ => right_part);
        wait for 0 ns;
        check_equal(left_part & right_part, vector);
      end if;
    end loop;

    test_runner_cleanup(runner);
    wait;
  end process test_runner;

  test_runner_watchdog(runner, 10 ms);
end;
