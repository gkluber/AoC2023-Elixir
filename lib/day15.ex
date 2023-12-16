defmodule Day15 do
  defp get_strings(lines) do
    input = Enum.join(lines) |> String.replace("\n", "")
    String.split(input, ",")
  end

  defp hash(string) do
    String.graphemes(string) |> Enum.reduce(0, fn char, cur ->
      char_val = char |> String.to_charlist() |> hd
      Integer.mod(17*(char_val + cur), 256)
    end)
  end

  def solution1(lines) do
    get_strings(lines) |> Enum.map(fn str ->
      hash(str)
    end) |> Enum.sum
  end

  defmodule Parser do
    import NimbleParsec

    defparsec(
      :parse,
      ascii_string([?a..?z], min: 1)
      |> choice([
        string("=") |> integer(1),
        string("-")
      ])
    )
  end

  def solution2(lines) do
    bins = get_strings(lines) |> Enum.reduce(%{}, fn str, bins ->
      {:ok, values, _, _, _, _} = Parser.parse(str)
      [name, op | lens] = values
      h = hash(name)
      case op do
        "=" ->
          [lens] = lens
          addition = [{name, lens}]
          Map.update(bins, h, addition, fn existing ->
            {updated_list, found_match} = Enum.reduce(existing, {[], false}, fn {other_name, other_lens}, {new_list, found} ->
              cond do
                other_name == name -> {new_list ++ addition, true}
                true -> {new_list ++ [{other_name, other_lens}], found} # ie do nothing
              end
            end)
            if found_match, do: updated_list, else: updated_list ++ addition
          end)
        "-" ->
          Map.update(bins, h, [], fn existing ->
            Enum.reduce(1..9, existing, fn lens, l ->
              List.delete(l, {name, lens})
            end)
          end)
      end
    end)

    Enum.map(bins, fn {box_id, labels} ->
      Enum.zip(0..(length(labels)-1), labels)
      |> Enum.reduce(0, fn {idx, {_name, lens}}, acc ->
        power = (box_id + 1) * (idx + 1) * lens
        acc + power
      end)
    end) |> Enum.sum
  end
end
