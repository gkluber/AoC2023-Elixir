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
end
