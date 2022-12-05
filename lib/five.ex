defmodule AdventOfCode2022.Five do
  @external_resource "data/five.txt"
  @stacks_and_moves File.read!("data/five.txt")
                    |> String.split("\n\n", trim: true)

  @stacks @stacks_and_moves
          |> hd
          |> String.split("\n", trim: true)
          |> Enum.map(fn line ->
            String.graphemes(line)
            |> Enum.chunk_every(4)
            |> Enum.map(fn columns ->
              Enum.at(columns, 1)
            end)
          end)
          |> Enum.drop(-1)
          |> List.zip()
          |> Enum.map(fn column ->
            Tuple.to_list(column)
            |> Enum.filter(&(&1 != " "))
          end)

  @moves @stacks_and_moves
         |> tl()
         |> hd()
         |> String.split("\n", trim: true)
         |> Enum.map(fn command ->
           %{"count" => count, "from" => from, "to" => to} =
             Regex.named_captures(~r/\w+ (?<count>\d+) \w+ (?<from>\d+) \w+ (?<to>\d+)/, command)

           [String.to_integer(count), String.to_integer(from), String.to_integer(to)]
         end)

  def first do
    Enum.reduce(@moves, @stacks, fn [count, from, to], stacks ->
      from_stack = Enum.at(stacks, from - 1)
      to_stack = Enum.at(stacks, to - 1)
      {popped, left} = Enum.split(from_stack, count)
      stacks = List.replace_at(stacks, from - 1, left)
      stacks = List.replace_at(stacks, to - 1, Enum.reverse(popped) ++ to_stack)
      stacks
    end)
    |> Enum.map(&hd/1)
    |> Enum.join()
  end

  def second do
    Enum.reduce(@moves, @stacks, fn [count, from, to], stacks ->
      from_stack = Enum.at(stacks, from - 1)
      to_stack = Enum.at(stacks, to - 1)
      {popped, left} = Enum.split(from_stack, count)
      stacks = List.replace_at(stacks, from - 1, left)
      stacks = List.replace_at(stacks, to - 1, popped ++ to_stack)
      stacks
    end)
    |> Enum.map(&hd/1)
    |> Enum.join()
  end
end
