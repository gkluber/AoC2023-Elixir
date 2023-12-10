defmodule Day9 do
  defp all_zeroes(arr) do
    Enum.reduce(arr, true, fn num, acc -> acc && (num == 0) end)
  end

  def solution1(lines) do
  Enum.map(lines, fn line ->
    nums = line |> String.trim
    |> String.split(~r/\s+/)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&elem(Integer.parse(&1), 0))

    recursion_max = length(nums)-1

    fin_diffs = Enum.reduce_while(0..recursion_max, [nums], fn idx,list ->
      array = Enum.at(list, idx)
      diffs = array |> Enum.chunk_every(2, 1, :discard) |> Enum.map(fn [x,y] -> y-x end)
      sentinel = if all_zeroes(diffs), do: :halt, else: :cont
      {sentinel, list ++ [diffs]}
    end)

    fin_diffs |> Enum.reduce(0, fn list, acc ->
      [x|_] = Enum.reverse(list)
      acc + x
    end)
  end) |> Enum.sum
 end
end
