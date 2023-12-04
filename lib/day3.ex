defmodule Day3 do
  def solution1(lines) do
    indexed_lines = Enum.map(lines, fn line ->
      len = String.length(line)
      Enum.zip(0..(len-1), String.graphemes(line))
    end)
    totally_indexed_lines = Enum.zip(0..(length(indexed_lines)-1), indexed_lines)

    IO.puts(inspect totally_indexed_lines)

    solution = Enum.map(totally_indexed_lines, fn [line_idx, [char_idx, char]] ->
      :idk
    end)
  end
end
