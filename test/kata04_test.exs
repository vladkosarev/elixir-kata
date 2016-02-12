defmodule Kata04Test do
  use ExUnit.Case, async: true
  import Kata04
  doctest Kata04

  test "minimum spread of 2 happens on day 14" do
    assert get_diff("lib/kata04/weather.dat", &get_min_spread/2) == {"14", 2}
  end

  test "minimum goal diff team is Aston Villa and 1 goal" do
    assert get_diff("lib/kata04/football.dat", &get_goals_diff/2) == {"Aston_Villa", 1}
  end
end
