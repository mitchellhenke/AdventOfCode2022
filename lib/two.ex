defmodule AdventOfCode2022.Two do
  @external_resource "data/two.txt"
  @plays File.read!("data/two.txt")
         |> String.split("\n", trim: true)
         |> Enum.map(&String.split(&1, " ", trim: true))

  # A - Rock
  # B - Paper
  # C - Scissors
  # X - Rock
  # Y - Paper
  # Z - Scissors

  @scores %{
    ["A", "X"] => 1 + 3,
    ["B", "X"] => 1 + 0,
    ["C", "X"] => 1 + 6,
    ["A", "Y"] => 2 + 6,
    ["B", "Y"] => 2 + 3,
    ["C", "Y"] => 2 + 0,
    ["A", "Z"] => 3 + 0,
    ["B", "Z"] => 3 + 6,
    ["C", "Z"] => 3 + 3
  }

  @lose %{
    "A" => "Z",
    "B" => "X",
    "C" => "Y"
  }

  @draw %{
    "A" => "X",
    "B" => "Y",
    "C" => "Z"
  }

  @win %{
    "A" => "Y",
    "B" => "Z",
    "C" => "X"
  }

  def first do
    Enum.map(@plays, fn play ->
      Map.get(@scores, play)
    end)
    |> Enum.sum()
  end

  def second do
    Enum.map(@plays, fn play ->
      [opponent_choice, result] = play

      my_choice =
        case result do
          # lose
          "X" ->
            Map.get(@lose, opponent_choice)

          # draw
          "Y" ->
            Map.get(@draw, opponent_choice)

          # win
          "Z" ->
            Map.get(@win, opponent_choice)
        end

      Map.get(@scores, [opponent_choice, my_choice])
    end)
    |> Enum.sum()
  end
end
