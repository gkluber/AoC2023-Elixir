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

  def solution2(lines) do
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
      marks
    end)

    num_cards = length(points)

    scratchcards = Enum.reduce(0..(num_cards-1), %{}, fn x, acc ->
      Map.put(acc, x, 1)
    end)

    IO.puts(inspect scratchcards)
    IO.puts(Enum.join(points, " "))

    total_cards = Enum.reduce(Enum.zip(0..(num_cards-1), points), scratchcards, fn {idx, wins}, acc ->
      num_cards = Map.get(acc, idx)
      if wins == 0 do
        acc
      else
        range = (idx+1)..(idx + wins)
        Enum.reduce(range, acc, fn idx, acc2 ->
          Map.put(acc2, idx, Map.get(acc2, idx, 0) + num_cards)
        end)
      end
    end)

    IO.puts(inspect total_cards)

    answer = Enum.sum(Map.values(total_cards))

    answer
  end
end
