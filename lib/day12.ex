defmodule Day12 do
  defp combinations(options_list) do
    if length(options_list) == 0 do
      [[]]
    else
      [ops | rest] = options_list
      rest_list = combinations(rest)
      Enum.map(ops, fn op ->
        Enum.map(rest_list, fn partial ->
          [op] ++ partial
        end)
      end) |> Enum.reduce([], fn list, acc ->
        acc ++ list
      end)
    end
  end

  def solution1(lines) do
    Enum.map(lines, fn line ->
      [arrangement, conditions] = String.split(line, " ")
      arrangement = arrangement |> String.graphemes()
      conditions = conditions |> String.trim() |> String.split(",") |> Enum.map(fn x -> elem(Integer.parse(x), 0) end)
      possibles = arrangement |> Enum.map(fn char ->
        case char do
          "?" -> [".", "#"]
          "." -> ["."]
          "#" -> ["#"]
        end
      end) |> combinations

      matches = possibles |> Enum.map(fn cand ->
        cand |> Enum.chunk_by(fn x -> x end)
        |> Enum.filter(fn chunk ->
          [x | _] = chunk
          x == "#"
        end)
        |> Enum.map(fn chunk -> length(chunk) end)
      end)
      |> Enum.filter(fn lens ->
        lens == conditions
      end) |> Enum.count
    end) |> Enum.sum
  end
end
