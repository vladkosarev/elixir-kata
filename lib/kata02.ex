defmodule Kata02 do
  def chop(int, array_of_int) do
    do_chop(int, array_of_int, 0)
  end

  def do_chop(int, array_of_int, counter) do
    case array_of_int do
      [] -> -1
      [^int | _tail] -> counter
      [_head | tail] -> do_chop(int, tail, counter + 1)
    end
  end
end
