defmodule Day8 do
  defmodule Parser do
    import NimbleParsec

    defparsec(
      :parse,
      ascii_string([?A..?Z], 3)
      |> ignore(string("="))
      |> ignore(string("("))
      |> ascii_string([?A..?Z], 3)
      |> ignore(string(","))
      |> ascii_string([?A..?Z], 3)
      |> ignore(string(")"))
    )
  end

  def solution1(lines) do
    [instructions | [""] ++ lines] = lines
    formatted = lines |> Enum.map(&String.replace(&1, " ", ""))
    eqs = formatted |> Enum.map(fn line ->
      {:ok, values, _, _, _, _} = Parser.parse(line)
      values
    end)
    wobblers = eqs |> Enum.reduce(%{}, fn [source, left, right], acc ->
      Map.put(acc, source, {left, right})
    end)

    instructions = Stream.cycle(instructions |> String.graphemes) #infinitely cycle/loop through instructions

    instructions |> Enum.reduce_while({1, "AAA"}, fn dir, {num, cur} ->
      {left, right} = Map.get(wobblers, cur)
      next = case dir do
        "L" -> left
        "R" -> right
      end
      if next == "ZZZ" do
        {:halt, num}
      else
        {:cont, {num+1, next}}
      end
    end)
  end
end
