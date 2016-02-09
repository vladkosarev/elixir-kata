defmodule Kata03Test do
  use ExUnit.Case
  import Kata03
  doctest Kata03

  test "minimum spread of 2 happens on day 14" do
    assert get_min_spread == {"14", 2}
  end
end
