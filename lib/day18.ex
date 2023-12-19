defmodule Day18 do
  defmodule Parser do
    import NimbleParsec

    defparsec(
      :parse,
      choice([
        string("U"),
        string("D"),
        string("L"),
        string("R")
      ])
      |> ignore(string(" "))
      |> integer(min: 1)
      |> ignore(string(" (#"))
      |> ascii_string([?0..?9] ++ [?a..?f], 6)
      |> ignore(string(")"))
    )
  end

  def solution1(lines) do
    {plane, _} = lines |> Enum.reduce({MapSet.new(), {0,0}}, fn l, {set, {cur_x, cur_y}}->
      {:ok, [dir, steps, _color], _, _, _, _} = Parser.parse(l)
      {dx, dy} = case dir do
        "U" -> {0, 1}
        "D" -> {0, -1}
        "L" -> {-1, 0}
        "R" -> {1, 0}
      end

      set = Enum.reduce(0..steps, set, fn step, set ->
        new_x = cur_x + dx * step
        new_y = cur_y + dy * step
        MapSet.put(set, {new_x, new_y, abs(dy)})
      end)

      {set, {cur_x + dx * steps, cur_y + dy * steps}}
    end)

    {{min_x, _, _}, {max_x, _, _}} = Enum.min_max_by(plane, fn {x,_y,_} -> x end)
    {{_, min_y, _}, {_, max_y, _}} = Enum.min_max_by(plane, fn {_x,y,_} -> y end)

    # Scanlines going left to right
    Enum.reduce(min_y..max_y, 0, fn y, acc ->
      {line_acc, false} = Enum.reduce(min_x..max_x, {0, false}, fn x, {lacc, in_gon} ->
        new_ingon = if MapSet.member?(plane, {x, y, 1}) do
          !in_gon
        else
          in_gon
        end

        new_acc = if in_gon || Enum.any?(Enum.map(0..1, fn o -> MapSet.member?(plane, {x,y,o}) end)) do
          lacc + 1
        else
          lacc
        end

        IO.puts("#{x}, #{y}--#{in_gon} #{lacc} #{MapSet.member?(plane, {x, y, 1})} #{MapSet.member?(plane, {x, y, 0})}")

        {new_acc, new_ingon}
      end)
      acc + line_acc
    end)
  end
end
