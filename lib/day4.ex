defmodule Day4 do
  def solution1(lines) do
    points = Enum.map(lines, fn line ->
      scratchcard = Enum.at(String.split(line, ":"), 1)
      [winning_nums, nums] = String.split(scratchcard, "|")
        |> Enum.map(fn line -> String.trim(line) |> String.split(~r/\s+/) |> Enum.map(fn num -> String.trim(num) end) end)
      winner_set = MapSet.new(winning_nums)

      num_winners = MapSet.size(winner_set)
      remaining = Enum.reduce(nums, winner_set, fn x, acc ->
        MapSet.delete(acc, x)
      end) |> MapSet.size
      marks = num_winners - remaining
      points = case marks do
        0 -> 0
        mark -> 2**(mark-1)
      end

      points
    end)

    answer = Enum.sum(points)

    answer
  end
end
