defmodule Advent do
  use Application

  def start(_type, _args) do
    data_files = Path.wildcard(File.cwd! <> "/data/*.txt")
    files_and_days = Enum.map(data_files, fn path ->
      {day_location, day_len} = :binary.match(path, "day_")
      num_start = day_location + day_len
      path_slice = String.slice(path, num_start, String.length(path))
      {next_underscore, _} = :binary.match(path_slice, "_")
      {num, _} = Integer.parse(String.slice(path_slice, 0, next_underscore))
      {path, num}
    end)

    IO.puts(inspect data_files)
    IO.puts(inspect files_and_days)

    Enum.sort(files_and_days, fn {_path, num}, {_path2, num2} -> num < num2 end)

    sorted = Enum.map(files_and_days, fn {path, _day} -> path end)

    lines_sets = Enum.map(sorted, fn path -> File.stream!(path) end)

    IO.puts(inspect lines_sets)

    IO.puts(Day1.solution(Enum.to_list(Enum.at(lines_sets, 0))))

    Task.start(fn -> :timer.sleep(1000); IO.puts("done sleeping") end)
  end
end
