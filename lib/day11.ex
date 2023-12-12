defmodule Day11 do
  defp index_lines(lines) do
    indexed_chars = Enum.map(lines, fn line ->
      chars = String.graphemes(line)
      Enum.zip(0..(length(chars)-1), chars)
    end)
    Enum.zip(0..(length(lines)-1), indexed_chars)
  end

  defp make_map(indexed) do
    Enum.reduce(indexed, MapSet.new(), fn {y, line}, acc ->
      Enum.reduce(line, acc, fn {x, char}, acc ->
        if char=="#", do: MapSet.put(acc, {x,y}), else: acc
      end)
    end)
  end

  def solution1(lines) do
    grid = index_lines(lines)
    galaxies = grid |> make_map

    MapSet.to_list(galaxies) |> Enum.map(fn {x,y} ->
      Enum.map(galaxies, fn {x2,y2} ->
        cond do
          x==x2 and y==y2 -> 100000000000
          true -> abs(x-x2) + abs(y-y2)
        end
      end) |> Enum.min
    end) |> Enum.sum
  end
end
