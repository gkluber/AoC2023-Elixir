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
    sorted = Enum.sort(files_and_days, fn {_path, num}, {_path2, num2} -> num < num2 end)
    sorted = Enum.map(sorted, fn {path, _day} -> path end)

    lines_sets = Enum.map(sorted, fn path -> File.read!(path) |> String.split(~r/\r?\n/) |> Enum.drop(-1) end)

    num_days = length(lines_sets)

    modules = [Day1, Day2, Day3, Day4, Day5, Day6, Day7, Day8, Day9, Day10, Day11, Day12, Day13, Day14, Day15]
    indexed_modules = Enum.zip([0..(num_days-1), modules, lines_sets])

    # Run the input data on functions of each day
    Enum.each(indexed_modules, fn {idx, module, lines} ->
      Enum.each(module.__info__(:functions), fn {func, _nargs} ->
        case module do
          m when m in [Day15] ->
            try do
              func_name = "#{func}"
              if String.starts_with?(func_name, "solution") do
                answer = apply(module, func, [lines])
                IO.puts("Day #{idx+1} #{func_name}: #{answer}")
              end
            rescue
              e in _ -> IO.puts("An error occurred in Day#{idx+1}/#{func}: #{inspect e}")
              try do
                IO.puts(e.message)
              rescue
                KeyError -> :error
              end
            end
          _ -> :continue
        end
      end)
    end)

    # Needed for `mix run` command
    Task.start(fn -> :timer.sleep(1000); IO.puts("done sleeping") end)
  end
end
