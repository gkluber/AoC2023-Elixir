defmodule Day5 do
  def solution1(lines) do
    file = Enum.join(lines, " ")
    sections = String.split(file, ":")
    filtered = Enum.map(sections, fn block ->
      block |> String.trim |> String.split(~r/\s+/)
    end) |> Enum.map(fn block ->
      Enum.filter(block, fn token ->
        token |> String.match?(~r/\d+/)
      end)
    end) |> Enum.filter(fn block ->
      length(block) > 0
    end)

    [seeds | maps] = filtered

    roll_map = fn f -> fn list ->
      case length(list) do
        x when x > 3 ->
          [x1,x2,x3 | rest] = list
          [[x1,x2,x3], f.(rest)]
        _ -> list
      end
    end end

    roll_map = roll_map.(roll_map)

    rolled_maps = maps |> Enum.map(fn section ->
      roll_map.(section)
    end)

    IO.puts(length(Enum.at(rolled_maps, 1)))
  end
end
