defmodule Kata04 do

  def get_diff(filePath, processor) do
    {:ok, file} = File.open(filePath, [:read])
    processor.(file, {"", 999})
  end

  def get_goals_diff(file, {cur_team, cur_diff}) do
    case IO.read(file, :line) do
      "   -" <> _ -> get_goals_diff(file, {cur_team, cur_diff})
      "       Team" <> _ -> get_goals_diff(file, {cur_team, cur_diff})
      :eof -> {cur_team, cur_diff}
      data -> (
        [[_],[team],[_],[_],[_],[_],[goals_for],[goals_against],[_]] = Regex.scan(~r/\w+/, data)
        {team, diff} = get_min_diff({cur_team, cur_diff}, {team, goals_for, goals_against})
        get_goals_diff(file, {team, diff})
      )
    end
  end

  def get_min_spread(file, {cur_day, cur_min}) do
    case IO.read(file, :line) do
      "  Dy" <> _ -> get_min_spread(file, {cur_day, cur_min})
      "\n" -> get_min_spread(file, {cur_day, cur_min})
      "  mo" <> _ -> {cur_day, cur_min} # this should be real :eof
      #:eof -> {cur_day, cur_min} # this shouldn't fire
      data -> (
        [[day] , [max] , [min] | _] = Regex.scan(~r/\w+/, data)
        {day, spread} = get_min_diff({cur_day, cur_min}, {day, min, max})
        get_min_spread(file, {day, spread})
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
