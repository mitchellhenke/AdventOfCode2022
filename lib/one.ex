defmodule AdventOfCode2022.One do
  @external_resource "data/one.txt"
  @numbers File.read!("data/one.txt")
           |> String.split("\n\n", trim: true)
           |> Enum.map(fn x ->
             String.split(x, "\n", trim: true)
             |> Enum.map(&String.to_integer(&1))
           end)
  def first do
    @numbers
    |> Enum.map(fn number_list ->
      Enum.sum(number_list)
    end)
    |> Enum.max()
  end

  def second do
    @numbers
    |> Enum.map(fn number_list ->
      Enum.sum(number_list)
    end)
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(3)
    |> Enum.sum()
  end
end
