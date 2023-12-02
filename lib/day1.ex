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
        "one" <> _ -> "1"
        "two" <> _ -> "2"
        "three" <> _ -> "3"
        "four" <> _ -> "4"
        "five" <> _ -> "5"
        "six" <> _ -> "6"
        "seven" <> _ -> "7"
        "eight" <> _ -> "8"
        "nine" <> _ -> "9"
        _ -> ""
      end
    end

    Enum.map(lines, fn line ->
      chars = String.graphemes(line)
      len = length(chars)
      chars_enumerate = Enum.zip(0..(len-1), chars)
      chars_substrings = chars_enumerate |> Enum.map(fn {idx, char} ->
        [char, Enum.join(Enum.slice(chars, idx, len))]
      end )
      numbers_strings = chars_substrings |> Enum.map(fn [char, substring] ->
        case Integer.parse(char) do
          {val, _} -> Integer.to_string(val)
          :error -> word_map.(substring)
        end
      end)
      big_fat_numbers = Enum.join(numbers_strings) |> String.graphemes()
      case Integer.parse(List.first(big_fat_numbers) <> List.last(big_fat_numbers)) do
        {val, _} -> val
        :error -> raise("Piss")
      end
    end ) |> Enum.sum
  end
end
