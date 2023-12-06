defmodule Day6 do
  def solution1(lines) do
    parsed = Enum.map(lines, fn line ->
      spt = String.split(String.trim(line), ~r/\s+/)
      nums = Enum.slice(spt, 1, length(spt)-1)
      Enum.map(nums, fn num ->
        {res, _} = Integer.parse(num)
        res
      end)
    end)

    [time | [distance]] = parsed

    races = Enum.zip(time, distance)

    scores = Enum.map(races, fn {time, dist} ->
      possible = 0..time
      Enum.filter(possible, fn t ->
        ms = t
        remaining = time - t
        total_dist = remaining*ms
        total_dist > dist
      end) |> length
    end) |> Enum.product
  end
end
