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

  defp parse_input(lines) do
    [dirs | [""] ++ lines] = lines
    formatted = lines |> Enum.map(&String.replace(&1, " ", ""))
    eqs = formatted |> Enum.map(fn line ->
      {:ok, values, _, _, _, _} = Parser.parse(line)
      values
    end)
    forks = eqs |> Enum.reduce(%{}, fn [source, left, right], acc ->
      Map.put(acc, source, {left, right})
    end)

    #infinitely cycle/loop through instructions
    dirs = Stream.cycle(dirs |> String.graphemes)

    {dirs, forks}
  end

  defp lcm(a,b) do
    div(a*b, Integer.gcd(a,b))
  end

  def solution1(lines) do
    {dirs, forks} = parse_input(lines)

    dirs |> Enum.reduce_while({1, "AAA"}, fn dir, {num, cur} ->
      {left, right} = Map.get(forks, cur)
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

  def solution2(lines) do
    {dirs, forks} = parse_input(lines)
    as = Map.keys(forks) |> Enum.filter(&String.ends_with?(&1, "A"))
    zs = Map.keys(forks) |> Enum.filter(&String.ends_with?(&1, "Z"))

    cycles = Enum.map(as, fn seed ->
      dirs |> Enum.reduce_while({1, seed}, fn dir, {num, cur} ->
        {left, right} = Map.get(forks, cur)
        next = case dir do
          "L" -> left
          "R" -> right
        end
        if next in zs do
          {:halt, num}
        else
          {:cont, {num+1, next}}
        end
      end)
    end)

    answer = Enum.reduce(cycles, 1, fn x, acc ->
      lcm(x,acc)
    end)

    answer
  end
end
