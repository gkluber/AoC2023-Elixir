defmodule Day3 do

  defp make_matrix(lines) do
    indexed_lines = Enum.map(lines, fn line ->
      len = length(line)
      Enum.zip(0..(len-1), line)
    end)
    Enum.zip(0..(length(indexed_lines)-1), indexed_lines)
  end

  def solution1(lines) do
    totally_indexed_lines = make_matrix(Enum.map(lines, &String.graphemes/1))

    map = Enum.reduce(totally_indexed_lines, %{}, fn {lidx, line}, acc ->
      Enum.reduce(line, acc, fn {cidx, char}, acc ->
        Map.put(acc, {cidx, lidx}, char)
      end)
    end)

    len_y = length(totally_indexed_lines)
    len_x = length(elem(Enum.at(totally_indexed_lines, 0), 1))

    symbol_adjacency = Enum.map(totally_indexed_lines, fn {y, line} ->
      Enum.map(line, fn {x, _} ->
        dirs = [{x-1,y}, {x+1,y}, {x,y-1}, {x,y+1}, {x+1, y+1}, {x+1, y-1}, {x-1, y+1}, {x-1, y-1}]
        dirs = Enum.filter(dirs, fn {x,y} ->
          x >= 0 && y >= 0 && x < len_x && y < len_y
        end)

        Enum.reduce(dirs, false, fn neighbor, acc ->
          char = Map.get(map, neighbor)
          acc || String.match?(char, ~r/[^\.\d]/)
        end)
      end)
    end)

    adjacency_matrix = make_matrix(symbol_adjacency) |> Enum.reduce(%{}, fn {y, line}, acc ->
      Enum.reduce(line, acc, fn {x, bool}, acc ->
        Map.put(acc, {x,y}, bool)
      end)
    end)

    # Now scan through each line, looking for truthiness
    Enum.map(totally_indexed_lines, fn {y, line} ->
      nums = Enum.chunk_by(line, fn {x, char} ->
        String.match?(char, ~r/[0-9]/)
      end) |> Enum.map(fn chunk ->
        Enum.filter(chunk, fn {_, char} ->
          String.match?(char, ~r/[0-9]/)
        end)
      end) |> Enum.filter(fn chunk -> length(chunk) > 0 end)

      nums |> Enum.map(fn chunk ->
        Enum.reduce(chunk, {"", MapSet.new()}, fn {x, char}, {str, set} ->
          set = MapSet.put(set, {x,y})
          {str <> char, set}
        end)
      end) |> Enum.map(fn {num, set} ->
        IO.puts(num)
        IO.puts(inspect set)
        if Enum.reduce(set, false, fn {x,y}, acc ->
          acc || Map.get(adjacency_matrix, {x,y})
        end) do
          {valid, _} = Integer.parse(num)
          valid
        else
          0
        end
      end) |> Enum.sum
    end) |> Enum.sum
  end
end
