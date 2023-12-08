defmodule Day7 do

  def card_to_num(card) do
    if String.match?(card, ~r/[2-9]/) do
      elem(Integer.parse(card), 0) - 1
    else
      case card do
        "J" -> 9
        "Q" -> 10
        "K" -> 11
      end
    end
  end

  def rank_hand(hand) do
    groups = Enum.frequencies_by(card_to_num)
  end

  def solution1(lines) do
    Enum.map(lines, fn line ->
      [hand, bid] = line |> String.trim |> String.split(~r/\s+/)
      hand = hand |> String.graphemes
      {bid, _} = Integer.parse(bid)
      rank = rank_hand(hand)
      bid * rank
    end) |> Enum.product
  end
end
