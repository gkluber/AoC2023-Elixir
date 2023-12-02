defmodule Day2 do
  def solution1(lines) do
    max_red = 12
    max_green = 13
    max_blue = 14

    valid_games = Enum.map(lines, fn line ->
      game = String.split(line, ":")
      {game_id, _} = Integer.parse(Enum.at(game, 0) |> String.split(~r/\s/) |> Enum.at(1))

      game_info = Enum.at(game, 1)
      runs = String.split(game_info, ";")
      dice = Enum.map(runs, fn run ->
        Enum.map(String.split(run, ","), fn die ->
          String.trim(die) |> String.split(~r/\s/)
        end)
        # runs :: [dice :: [{str_num, color}]] -- join these runs
      end) |> Enum.reduce([], fn dice, acc ->
        dice ++ acc
      end)

      valid_game = Enum.map(dice, fn die ->
        [str_num, color] = die
        {num, _} = Integer.parse(str_num)
        case color do
          "red" -> num <= max_red
          "green" -> num <= max_green
          "blue" -> num <= max_blue
        end
      end) |> Enum.reduce(true, fn bool, acc ->
        bool && acc
      end)

      {game_id, valid_game}
    end)

    answer = Enum.map(valid_games, fn {idx, valid_bool} ->
      if valid_bool, do: idx, else: 0
    end) |> Enum.sum

    answer
  end
end
