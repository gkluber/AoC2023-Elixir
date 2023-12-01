defmodule Day1 do
  @spec solution1(list(String.t())) :: number()
  def solution1(lines) do
    Enum.map(lines, fn line ->
      chars = String.graphemes(line)
      raw_nums = Enum.filter(chars, fn(char) -> String.match?(char, ~r/[0-9]/) end)
      {num, _} = Integer.parse(List.first(raw_nums) <> List.last(raw_nums))
      num
    end)
    |> Enum.sum
  end

  def solution2(lines) do
    word_map = fn(text) ->
      case text do
        "one" -> 1
        "two" -> 2
        "three" -> 3
        "four" -> 4
        "five" -> 5
        "six" -> 6
        "seven" -> 7
        "eight" -> 8
        "nine" -> 9
        _ -> 0
      end
    end

    Enum.map(lines, fn line ->
      chars = String.graphemes(line)
      len = length(chars)
      chars_enumerate = Enum.zip(0..(len-1), chars)
      chars_substrings = chars_enumerate |> Enum.map(fn {idx, char} ->
        [char, Enum.join(Enum.slice(chars, idx, len))]
      end )

      IO.puts(inspect chars_substrings)

    end ) |> Enum.sum
  end
end
