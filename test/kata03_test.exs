defmodule Kata03Test do
  use ExUnit.Case
  import Kata03
  doctest Kata03

  test "minimum spread of 2 happens on day 14" do
    assert get_min_spread == {"14", 2}
  end

  test "minimum" do
    assert get_goals_diff == {"Aston_Villa", 1}
  end
end
