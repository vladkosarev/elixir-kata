defmodule Kata02 do
  # 3. using split_while/2
  def chop(int, array_of_int) do
    {pre, post} = Enum.split_while(array_of_int, fn x -> x != int end)
    cond do
      post == [] -> -1
      true -> length pre
    end
  end

  # 2. using Enum.find_index/2
  def chop2(int, array_of_int) do
    case index = Enum.find_index(array_of_int, fn x -> x == int end) do
      nil -> -1
      _ -> index
    end
  end

  # 1. Simple recursive function with counter
  def chop3(int, array_of_int) do
    do_chop(int, array_of_int, 0)
  end

  defp do_chop(int, array_of_int, counter) do
    case array_of_int do
      [] -> -1
      [^int | _tail] -> counter
      [_head | tail] -> do_chop(int, tail, counter + 1)
    end
  end


end
