defmodule AdventOfCode2022.Three do
  @external_resource "data/three.txt"
  @rucksacks File.read!("data/three.txt")
             |> String.split("\n", trim: true)
             |> Enum.map(&String.to_charlist/1)

  def first do
    Enum.map(@rucksacks, fn rucksack ->
      {first, second} = Enum.split(rucksack, div(Enum.count(rucksack), 2))

      MapSet.intersection(MapSet.new(first), MapSet.new(second))
      |> MapSet.to_list()
    end)
    |> List.flatten()
    |> Enum.map(fn letter ->
      if letter < 97 do
        letter - 38
      else
        letter - 96
      end
    end)
    |> Enum.sum()
  end

  def second do
    Enum.chunk_every(@rucksacks, 3)
    |> Enum.map(fn [list1, list2, list3] ->
      MapSet.intersection(MapSet.new(list1), MapSet.new(list2))
      |> MapSet.intersection(MapSet.new(list3))
      |> MapSet.to_list()
    end)
    |> List.flatten()
    |> Enum.map(fn letter ->
      if letter < 97 do
        letter - 38
      else
        letter - 96
      end
    end)
    |> Enum.sum()
  end
end
