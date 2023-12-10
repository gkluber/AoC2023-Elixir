defmodule Day10 do
  defp index_lines(lines) do
    indexed_chars = Enum.map(lines, fn line ->
      chars = String.graphemes(line)
      Enum.zip(0..(length(chars)-1), chars)
    end)
    Enum.zip(0..(length(lines)-1), indexed_chars)
  end

  defp make_map(indexed) do
    Enum.reduce(indexed, %{}, fn {y, line}, acc ->
      Enum.reduce(line, acc, fn {x, char}, acc ->
        Map.put(acc, {x,y}, char)
      end)
    end)
  end

  def solution1(lines) do
    grid = index_lines(lines)
    map = grid |> make_map

    start = Enum.reduce(grid, nil, fn {y, line}, acc ->
      Enum.reduce(line, acc, fn {x, char}, acc ->
        if char=="S", do: {x,y}, else: acc
      end)
    end)

    IO.puts(inspect map)
    IO.puts(inspect start)
  end
end
