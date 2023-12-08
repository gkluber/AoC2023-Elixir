defmodule Day7 do

  def card_to_num(card) do
    if String.match?(card, ~r/[2-9]/) do
      elem(Integer.parse(card), 0) - 1
    else
      case card do
        "T" -> 9
        "J" -> 10
        "Q" -> 11
        "K" -> 12
        "A" -> 13
      end
    end
  end

  def rank_hand(hand) do
    groups = Enum.frequencies_by(hand, &card_to_num(&1))
    {max_card, max_of_kind} = Enum.max(groups, fn {k1,v1}, {k2, v2} ->
      case v1 == v2 do
        false -> v1 < v2
        true -> k1 < k2
      end
    end)

    {high_card, _} = Enum.max(groups, fn {k1,_}, {k2,_} ->
      k1 < k2
    end)

    IO.puts("#{max_of_kind} & #{high_card} -- #{inspect groups}")

    other_card = if max_of_kind != 5 do
      {other_card, _} = Enum.at(Enum.drop_while(groups, fn {k,_} ->
        k == max_card
      end), 0)
      other_card
    else
      max_card
    end


    case max_of_kind do
      0 -> raise("Error.. shouldn't be 0 groups");
      1 -> max_card                         # high card
      2 -> max_card * 14 + high_card        # one pair
      3 -> case map_size(groups) do
        1 -> max_card * 14**2               # 3 of kind
        2 -> max_card * 14**3 + other_card  # full house
      end
      4 -> max_card * 14**4 + other_card    # 4 of a kind
      5 -> max_card * 14**5                 # 5 of a kind
      _ -> raise("Something's wrong")
    end
  end

  def solution1(lines) do
    scores = Enum.map(lines, fn line ->
      [hand, bid] = line |> String.trim |> String.split(~r/\s+/)
      hand = hand |> String.graphemes
      {bid, _} = Integer.parse(bid)
      rank = rank_hand(hand)
      {rank, bid}
    end)

    sorted = Enum.sort(scores, fn {rank, _}, {rank2, _} -> rank < rank2 end) #sort ascending

    new_ranks = Enum.zip(1..length(sorted), Enum.map(sorted, fn {_, bid} -> bid end))

    answer = Enum.map(new_ranks, fn {rank, bid} -> bid*rank end) |> Enum.sum()

    answer
  end
end
