defmodule Kata03 do

  # Football
  def get_goals_diff do
    {:ok, file} = File.open("lib/kata03/football.dat", [:read])
    IO.read(file, :line) # skip header
    do_get_goals_diff(file, {"",999}) # assuming < 999 diff
    #File.close(file)
  end

  defp do_get_goals_diff(file, {cur_team, cur_spread}) do
    case IO.read(file, :line) do
      :eof -> {cur_team, cur_spread}
      "   -" <> _ -> {cur_team, cur_spread}
      data -> (
        [[_],[team],[_],[_],[_],[_],[goals_for],[goals_against],[_]] = Regex.scan(~r/\w+/, data)
        {team, diff} = get_min_diff({cur_team, cur_spread}, {team, goals_for, goals_against})
        do_get_goals_diff(file, {team, diff})
      )
    end
  end

# Weather
  def get_min_spread do
    {:ok, file} = File.open("lib/kata03/weather.dat", [:read])
    # skip header lines
    IO.read(file, :line)
    IO.read(file, :line)
    do_get_min_spread(file, {0,999}) # assuming < 999 spread
    #File.close(file)
  end

  defp do_get_min_spread(file, {cur_day, cur_min}) do
    case IO.read(file, :line) do
      #:eof -> {cur_day, cur_min} # this shouldn't fire
      "  mo" <> _ -> {cur_day, cur_min} # this should be real :eof
      data -> (
        [[day] , [max] , [min] | _] = Regex.scan(~r/\w+/, data)
        {day, spread} = get_min_diff({cur_day, cur_min}, {day, min, max})
        do_get_min_spread(file, {day, spread})
      )
    end
  end

  # Common
  defp get_min_diff({cur_key, cur_min}, {key, min, max}) do
    new_min =
      abs (String.to_integer(String.rstrip(max, ?*)) - String.to_integer(String.rstrip(min, ?*)))
    if cur_min>new_min, do: {key, new_min}, else: {cur_key, cur_min}
  end
end
