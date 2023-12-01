defmodule Day1 do
  @spec solution(list(String.t())) :: number()
  def solution(lines) do
    Enum.reduce(lines, fn line ->
      chars = String.graphemes(line)
      raw_nums = Enum.filter(chars, fn(char) -> String.match?(char, "[0-9]") end)
      Integer.parse(List.first(raw_nums) <> List.last(raw_nums))
    end)
  end
end
