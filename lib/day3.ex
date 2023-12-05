defmodule Day3 do
  def solution1(lines) do
    indexed_lines = Enum.map(lines, fn line ->
      len = String.length(line)
      Enum.zip(0..(len-1), String.graphemes(line))
    end)
    totally_indexed_lines = Enum.zip(0..(length(indexed_lines)-1), indexed_lines)

    get = fn(x,y) -> Enum.at(Enum.at(totally_indexed_lines, y), x) end

    len_y = length(totally_indexed_lines)
    len_x = length(Enum.at(totally_indexed_lines, 0))

    IO.puts(inspect totally_indexed_lines)

    symbol_adjacency = Enum.map(totally_indexed_lines, fn {y, {x, _}} ->
      dirs = [{x-1,y}, {x+1,y}, {x,y-1}, {x,y+1}]
      dirs = Enum.filter(dirs, fn {x,y} ->
        x >= 0 && y >= 0 && x < len_x && y < len_y
      end)

      Enum.reduce(dirs, false, fn {x,y}, acc ->
        {_, char} = get.(x,y)
        acc || String.match?(char, ~r/[^\.\d]/)
      end)
    end)

    IO.puts(inspect symbol_adjacency)

    :error
  end
end
