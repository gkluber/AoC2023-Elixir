defmodule Day5 do
  def solution1(lines) do
    file = Enum.join(lines, " ")
    sections = String.split(file, ":")
    filtered = Enum.map(sections, fn block ->
      block |> String.trim |> String.split(~r/\s+/)
    end) |> Enum.map(fn block ->
      Enum.filter(block, fn token ->
        token |> String.match?(~r/\d+/)
      end) |> Enum.map(fn token ->
        {res, _} = Integer.parse(token)
        res
      end)
    end) |> Enum.filter(fn block ->
      length(block) > 0
    end)

    [seeds | maps] = filtered

    roll_map = fn f -> fn list ->
      case length(list) do
        x when x > 3 ->
          [x1,x2,x3 | rest] = list
          [[x1,x2,x3]] ++ f.(rest)
        _ -> [list]
      end
    end end

    # Y combinator--https://stackoverflow.com/questions/21982713/recursion-and-anonymous-functions-in-elixir
    # Needed because roll_map is an anonymous function--this probably isn't very efficient tbh
    fix = fn f ->
      (fn z ->
        z.(z)
      end).(fn x ->
        f.(fn y -> (x.(x)).(y) end)
      end)
    end

    roll_map = fix.(roll_map)

    rolled_maps = maps |> Enum.map(fn section ->
      roll_map.(section)
    end)

    process_map = fn(seed, map) ->
      case Enum.filter(map, fn [_,s,l] ->
        seed in s..(s+l-1)
      end) do
        [] -> seed
        [[d,s,_]] -> seed-s+d
      end
    end

    soils = Enum.map(seeds, fn seed ->
      Enum.reduce(rolled_maps, seed, fn map, acc ->
        process_map.(acc, map)
      end)
    end)

    Enum.min(soils)
  end

  def solution2(lines) do
    file = Enum.join(lines, " ")
    sections = String.split(file, ":")
    filtered = Enum.map(sections, fn block ->
      block |> String.trim |> String.split(~r/\s+/)
    end) |> Enum.map(fn block ->
      Enum.filter(block, fn token ->
        token |> String.match?(~r/\d+/)
      end) |> Enum.map(fn token ->
        {res, _} = Integer.parse(token)
        res
      end)
    end) |> Enum.filter(fn block ->
      length(block) > 0
    end)

    [seeds | maps] = filtered

    roll_map = fn f -> fn list ->
      case length(list) do
        x when x > 3 ->
          [x1,x2,x3 | rest] = list
          [[x1,x2,x3]] ++ f.(rest)
        _ -> [list]
      end
    end end

    # Y combinator--https://stackoverflow.com/questions/21982713/recursion-and-anonymous-functions-in-elixir
    # Needed because roll_map is an anonymous function--this probably isn't very efficient tbh
    fix = fn f ->
      (fn z ->
        z.(z)
      end).(fn x ->
        f.(fn y -> (x.(x)).(y) end)
      end)
    end

    roll_map = fix.(roll_map)

    rolled_maps = maps |> Enum.map(fn section ->
      roll_map.(section)
    end)

    transposed = maps |> Enum.map(fn [d,s,l] ->
      [s,d,l]
    end)

    process_map = fn(seed, map) ->
      case Enum.filter(map, fn [_,s,l] ->
        seed in s..(s+l-1)
      end) do
        [] -> seed
        [[d,s,_]] -> seed-s+d
      end
    end

    Enum.drop_while()

    soils = Enum.map(seeds, fn seed ->
      Enum.reduce(rolled_maps, seed, fn map, acc ->
        process_map.(acc, map)
      end)
    end)

    Enum.min(soils)
  end
end
