defmodule AdventOfCode2022.Six do
  @external_resource "data/six.txt"
  @signal File.read!("data/six.txt")
          |> String.trim_trailing()

  def first do
    String.graphemes(@signal)
    |> Enum.chunk_every(4, 1, :discard)
    |> Enum.reduce_while(4, fn elements, index ->
      if MapSet.size(MapSet.new(elements)) == 4 do
        {:halt, [index, Enum.join(elements)]}
      else
        {:cont, index + 1}
      end
    end)
  end

  def second do
    String.graphemes(@signal)
    |> Enum.chunk_every(14, 1, :discard)
    |> Enum.reduce_while(14, fn elements, index ->
      if MapSet.size(MapSet.new(elements)) == 14 do
        {:halt, [index, Enum.join(elements)]}
      else
        {:cont, index + 1}
      end
    end)
  end
end
