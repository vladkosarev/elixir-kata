defmodule Kata03 do
  def get_min_spread do
    {:ok, file} = File.open("lib/kata03/weather.dat", [:read])
    # skip header lines
    IO.read(file, :line)
    IO.read(file, :line)
    do_get_min_spread(file, {0,999}) # assuming < 999 spread
  end

  defp do_get_min_spread(file, {cur_day, cur_min}) do
    case IO.read(file, :line) do
      :eof -> {cur_day, cur_min} # this shouldn't fire
      ["mo" | _] -> {cur_day, cur_min} # this should be real :eof
      data -> (
        [[day] , [max] , [min] | _] = Regex.scan(~r/\w+/, data)
        {day, spread} = get_min_spread({cur_day, cur_min}, {day, min, max})
        do_get_min_spread(file, {day, spread})
      )
    end
  end

  defp get_min_spread({cur_day, cur_min}, {day, min, max}) do
    new_spread = String.to_integer(String.rstrip(max, ?*)) - String.to_integer(String.rstrip(min, ?*))
    if cur_min>new_spread, do: {day, new_spread}, else: {cur_day, cur_min}
  end
end
