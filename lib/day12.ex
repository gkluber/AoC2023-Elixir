defmodule Day12 do
  defp combinations(options_list) do
    if length(options_list) == 0 do
      []
    else
      [ops | rest] = options_list
      Enum.map(ops, fn op ->
        [op] ++ combinations(rest)
      end) |> Enum.reduce([], fn list, acc ->
        acc ++ [list]
      end)
    end
  end

  def solution1(lines) do
    Enum.map(lines, fn line ->
      [arrangement, conditions] = String.split(line, " ")
      arrangement = arrangement |> String.graphemes()
      conditions = conditions |> String.trim() |> String.split(",") |> Enum.map(fn x -> elem(Integer.parse(x), 0) end)
      possible = arrangement |> Enum.map(fn char ->
        case char do
          "?" -> [".", "#"]
          "." -> ["."]
          "#" -> ["#"]
        end
      end) |> combinations

      IO.puts(inspect possible)
    end)
  end
end
