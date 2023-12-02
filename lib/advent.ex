defmodule Advent do
  use Application

  def start(_type, _args) do
    data_files = Path.wildcard(File.cwd! <> "/data/*.txt")

    # Extract day number from the file names
    files_and_days = Enum.map(data_files, fn path ->
      {day_location, day_len} = :binary.match(path, "day_")
      num_start = day_location + day_len
      path_slice = String.slice(path, num_start, String.length(path))
      {next_underscore, _} = :binary.match(path_slice, "_")
      {num, _} = Integer.parse(String.slice(path_slice, 0, next_underscore))
      {path, num}
    end)

    IO.puts(inspect files_and_days)

    # Sort based on that number
    Enum.sort(files_and_days, fn {_path, num}, {_path2, num2} -> num < num2 end)
    sorted = Enum.map(files_and_days, fn {path, _day} -> path end)
    lines_sets = Enum.map(sorted, fn path -> File.read!(path) |> String.split(~r/\r?\n/) |> Enum.drop(-1) end)

    day1_data = Enum.at(lines_sets, 0)
    IO.puts("Day 1 solution 1: " <> Integer.to_string(day1_data |> Day1.solution1))
    IO.puts("Day 1 solution 2: " <> Integer.to_string(day1_data |> Day1.solution2))

    day2_data = Enum.at(lines_sets, 1)
    IO.puts("Day 2 solution 1: " <> Integer.to_string(day2_data |> Day2.solution1))
    IO.puts("Day 2 solution 2: " <> Integer.to_string(day2_data |> Day2.solution2))

    Task.start(fn -> :timer.sleep(1000); IO.puts("done sleeping") end)
  end
end
